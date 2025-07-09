package com.deal.Fastruck.controller;

import com.deal.Fastruck.annotation.CurrentMember;
import com.deal.Fastruck.dto.*;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.entity.enums.Role;
import com.deal.Fastruck.repository.MemberRepository;
import com.deal.Fastruck.service.MemberService;
import com.deal.Fastruck.service.ReviewService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validator;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@RestController
@RequestMapping("/api/member")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;
    private final ReviewService reviewService;

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
     * 로그아웃
     */
    @PostMapping("/logout")
    public ResponseEntity<?> logout(@CurrentMember Member member) {

        // 로그 출력용
        System.out.println("[Controller] 로그아웃 요청 - member: " + member);

        memberService.logout(member);
        return ResponseEntity.ok(Map.of("message", "로그아웃 완료"));
    }

    /**
     * 내 정보 조회
     */
    @GetMapping
    public ResponseEntity<MemberResponseDto> getMe(@CurrentMember Member member) {
        MemberResponseDto responseDto = memberService.getMember(member);
        return ResponseEntity.ok(responseDto);
    }

    @GetMapping("/me")
    public ResponseEntity<MemberResponseDto> getAdmin(@CurrentMember Member member) {
        if (member == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        try {
            MemberResponseDto responseDto = memberService.getMember(member);
            return ResponseEntity.ok(responseDto);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    /**
     * ID로 회원 조회
     */
    @GetMapping("/users/{id}")
    public ResponseEntity<MemberResponseDto> getById(@PathVariable Long id) {
        MemberResponseDto responseDto = memberService.getMemberbyId(id);
        return ResponseEntity.ok(responseDto);
    }

    // 내 리뷰 조회
    @GetMapping("/me/reviews")
    public ResponseEntity<List<ReviewResponseDto>> getMyReviews(@CurrentMember Member member) {
        List<ReviewResponseDto> reviews = reviewService.getReviewsByWriter(member);
        return ResponseEntity.ok(reviews);
    }

    // 특정 회원 리뷰 조회
    @GetMapping("/{memberId}/reviews")
    public ResponseEntity<List<ReviewResponseDto>> getReviewsAboutMember(@PathVariable Long memberId) {
        List<ReviewResponseDto> reviews = reviewService.getReviewsForMember(memberId);
        return ResponseEntity.ok(reviews);
    }

    // 전체 회원 조회 (관리자 전용)
    @GetMapping("/all")
    public ResponseEntity<List<MemberResponseDto>> getAllMembers() {
        List<MemberResponseDto> members = memberService.getAllMembers();
        return ResponseEntity.ok(members);
    }

    // 권한(Role) 변경 (관리자 전용)
    @PutMapping("/{id}/role")
    public ResponseEntity<?> updateRole(@PathVariable Long id, @RequestBody RoleUpdateRequestDto dto) {
        memberService.updateMemberRole(id, dto.getNewRole());
        return ResponseEntity.ok(Map.of("message", "권한이 성공적으로 변경되었습니다."));
    }

    @GetMapping("/count/by-year")
    public ResponseEntity<?> getUserStatsByYear(@RequestParam int year) {
        return ResponseEntity.ok(memberService.getUserStatsByYear(year));
    }
}
