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

    // 리뷰 조회
    @GetMapping("/{reviewId}")
    public ResponseEntity<ReviewResponseDto> getReviewDetail(@PathVariable Long reviewId) {
        ReviewResponseDto dto = reviewService.getReviewDetail(reviewId);
        return ResponseEntity.ok(dto);
    }
}
