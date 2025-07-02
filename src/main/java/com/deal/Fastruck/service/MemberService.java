package com.deal.Fastruck.service;

import com.deal.Fastruck.dto.MemberRequestDto;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.entity.enums.Role;
import com.deal.Fastruck.repository.MemberRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;

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
}
