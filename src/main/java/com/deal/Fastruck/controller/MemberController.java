package com.deal.Fastruck.controller;

import com.deal.Fastruck.annotation.CurrentMember;
import com.deal.Fastruck.dto.LoginRequestDto;
import com.deal.Fastruck.dto.LoginResponseDto;
import com.deal.Fastruck.dto.MemberRequestDto;
import com.deal.Fastruck.dto.MemberResponseDto;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.service.MemberService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validator;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;
import java.util.Set;

@RestController
@RequestMapping("/api/member")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    @Autowired
    private Validator validator;

    /**
     * 회원 가입
     */
    @PostMapping(value = "/register", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> create(
            @RequestPart("memberData") String memberDataJson,
            @RequestPart(value = "image", required = false) MultipartFile image
    ) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            mapper.registerModule(new JavaTimeModule());
            mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

            MemberRequestDto dto = mapper.readValue(memberDataJson, MemberRequestDto.class);

            // 수동 검증
            Set<ConstraintViolation<MemberRequestDto>> violations = validator.validate(dto);
            if (!violations.isEmpty()) {
                List<String> errors = violations.stream()
                        .map(ConstraintViolation::getMessage)
                        .toList();
                return ResponseEntity.badRequest().body(Map.of("message", "유효성 검사 실패", "errors", errors));
            }

            memberService.signup(dto, image);

            return ResponseEntity.ok(Map.of("message", "회원가입 성공"));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(Map.of("message", "회원가입 실패: " + e.getMessage()));
        }
    }

    /**
     * 로그인 → AccessToken + RefreshToken 반환
     */
    @PostMapping("/login")
    public ResponseEntity<LoginResponseDto> login(@RequestBody LoginRequestDto loginRequest) {

        // 로그 출력용
        System.out.println("[Controller] 로그인 요청 들어옴");
        System.out.println("[Controller] 이메일: " + loginRequest.getEmail());
        System.out.println("[Controller] 비밀번호: " + loginRequest.getPassword());

        LoginResponseDto loginResponse = memberService.login(loginRequest);
        return ResponseEntity.ok(loginResponse);
    }

    /**
     * 내 정보 조회 (/me)
     */
    @GetMapping
    public ResponseEntity<MemberResponseDto> getMe(@CurrentMember Member member) {
        MemberResponseDto responseDto = memberService.getMember(member);
        return ResponseEntity.ok(responseDto);
    }
}
