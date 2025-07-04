package com.deal.Fastruck.dto;

import com.deal.Fastruck.entity.Review;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReviewResponseDto {

    private Long id;
    private Long contractId;
    private Long writerId;
    private Long receiverId;
    private Long rating;
    private String comment;
    private LocalDateTime createdAt;

    public static ReviewResponseDto from(Review review) {
        return ReviewResponseDto.builder()
                .id(review.getId())
                .contractId(review.getContract().getId())
                .writerId(review.getWriter().getId())
                .receiverId(review.getReceiver().getId())
                .rating(review.getRating())
                .comment(review.getComment())
                .createdAt(review.getCreatedAt())
                .build();
    }
}