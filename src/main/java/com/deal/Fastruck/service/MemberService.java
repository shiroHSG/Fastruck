package com.deal.Fastruck.service;

import com.deal.Fastruck.dto.LoginRequestDto;
import com.deal.Fastruck.dto.LoginResponseDto;
import com.deal.Fastruck.dto.MemberRequestDto;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.entity.enums.Role;
import com.deal.Fastruck.repository.MemberRepository;
import com.deal.Fastruck.util.JwtUtil;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.io.File;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;

    private final FileUploadService fileUploadService;

    @Transactional
    public void signup(MemberRequestDto dto, MultipartFile image) {
        if (memberRepository.existsByEmail(dto.getEmail())) {
            throw new IllegalArgumentException("이미 사용 중인 이메일입니다.");
        }

        String imageUrl = null;
        if (image != null && !image.isEmpty()) {
            imageUrl = fileUploadService.upload(image, "members"); // 파일 저장 후 URL 리턴
        }

        Member member = Member.builder()
                .name(dto.getName())
                .email(dto.getEmail())
                .password(passwordEncoder.encode(dto.getPassword()))
                .phone(dto.getPhone())
                .imageUrl(imageUrl)
                .role(dto.getRole())
                .build();

        memberRepository.save(member);
    }

    public LoginResponseDto login(LoginRequestDto dto) {

        Optional<Member> optional = memberRepository.findByEmail(dto.getEmail());
        if (optional.isPresent()) {
            Member member = optional.get();

            if (passwordEncoder.matches(dto.getPassword(), member.getPassword())) {
                String accessToken = jwtUtil.generateAccessToken(member.getId());
                String refreshToken = jwtUtil.generateRefreshToken(member.getId());

                // ✅ 발급된 토큰 로그 출력
                System.out.println("[Service] AccessToken: " + accessToken);
                System.out.println("[Service] RefreshToken: " + refreshToken);

                member.setRefreshToken(refreshToken);
                memberRepository.save(member);

                return LoginResponseDto.builder()
                        .accessToken(accessToken)
                        .refreshToken(refreshToken)
                        .memberId(member.getId())
                        .build();
            } else {
                System.out.println("[Service] 비밀번호 불일치");
            }
        } else {
            System.out.println("[Service] 사용자 이메일 없음");
        }

        throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "이메일 또는 비밀번호가 일치하지 않습니다.");
    }
}
