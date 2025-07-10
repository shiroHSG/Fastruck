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
    private String reporterName; // 추가
    private Long targetId;
    private String targetName;   // 추가
    private String reason;
    private String description;
    private LocalDateTime createdAt;

    public static ReportResponseDto from(Report report) {
        return ReportResponseDto.builder()
                .id(report.getId())
                .contractId(report.getContract().getId())
                .reporterId(report.getReporter().getId())
                .reporterName(report.getReporter().getName()) // 추가
                .targetId(report.getTarget().getId())
                .targetName(report.getTarget().getName())     // 추가
                .reason(report.getReason())
                .description(report.getDescription())
                .createdAt(report.getCreatedAt())
                .build();
    }
}
