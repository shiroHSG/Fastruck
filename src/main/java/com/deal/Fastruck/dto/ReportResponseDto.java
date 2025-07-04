package com.deal.Fastruck.dto;

import com.deal.Fastruck.entity.Report;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class ReportResponseDto {
    private Long id;
    private Long contractId;
    private Long reporterId;
    private Long targetId;
    private String reason;
    private String description;
    private LocalDateTime createdAt;

    public static ReportResponseDto from(Report report) {
        return ReportResponseDto.builder()
                .id(report.getId())
                .contractId(report.getContract().getId())
                .reporterId(report.getReporter().getId())
                .targetId(report.getTarget().getId())
                .reason(report.getReason())
                .description(report.getDescription())
                .createdAt(report.getCreatedAt())
                .build();
    }
}