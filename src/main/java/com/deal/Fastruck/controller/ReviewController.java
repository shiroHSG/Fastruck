package com.deal.Fastruck.controller;

import com.deal.Fastruck.annotation.CurrentMember;
import com.deal.Fastruck.dto.ReviewRequestDto;
import com.deal.Fastruck.dto.ReviewResponseDto;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.service.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/reviews")
public class ReviewController {

    private final ReviewService reviewService;

    // 리뷰 작성
    @PostMapping("/contract/{contractId}")
    public ResponseEntity<?> createReview(
            @PathVariable Long contractId,
            @RequestBody ReviewRequestDto dto,
            @CurrentMember Member member) {

        reviewService.createReview(contractId, dto, member);
        return ResponseEntity.ok(Map.of("message", "리뷰 작성"));
    }

    // 화주가 차주 리뷰 리스트 조회
    @GetMapping("/carrier/{carrierId}")
    public ResponseEntity<List<ReviewResponseDto>> getReviewsByCarrier(@PathVariable Long carrierId,
                                                                       @CurrentMember Member member) {
        List<ReviewResponseDto> reviews = reviewService.getReviewsByCarrier(carrierId);
        return ResponseEntity.ok(reviews);
    }

    // 리뷰 상세조회
    @GetMapping("/{reviewId}")
    public ResponseEntity<ReviewResponseDto> getReviewDetail(@PathVariable Long reviewId,
                                                             @CurrentMember Member member) {
        ReviewResponseDto dto = reviewService.getReviewDetail(reviewId);
        return ResponseEntity.ok(dto);
    }

    // 전체 리뷰 목록 조회 (관리자 전용)
    @GetMapping("/admin")
    public ResponseEntity<List<ReviewResponseDto>> getAllReviews() {
        List<ReviewResponseDto> reviews = reviewService.getAllReviews();
        return ResponseEntity.ok(reviews);
    }

    // 리뷰 상세조회 admin용
    @GetMapping("/admin/{reviewId}")
    public ResponseEntity<ReviewResponseDto> getDetailReview(@PathVariable Long reviewId) {
        ReviewResponseDto dto = reviewService.getReviewDetail(reviewId);
        return ResponseEntity.ok(dto);
    }
}
