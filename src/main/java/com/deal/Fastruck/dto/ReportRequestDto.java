package com.deal.Fastruck.dto;

import lombok.Getter;

@Getter
public class ReportRequestDto {
    private Long targetId;
    private String reason;
    private String description;
}
