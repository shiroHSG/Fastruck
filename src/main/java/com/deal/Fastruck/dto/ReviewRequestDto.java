package com.deal.Fastruck.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewRequestDto {
    private Long receiverId;
    private Long rating; // 평점 (예: 1 ~ 5)
    private String comment;
}