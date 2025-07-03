package com.deal.Fastruck.controller;

import com.deal.Fastruck.annotation.CurrentMember;
import com.deal.Fastruck.dto.ReportRequestDto;
import com.deal.Fastruck.dto.ReportResponseDto;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.service.ReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/reports")
public class ReportController {

    private final ReportService reportService;

    // 신고 생성
    @PostMapping("/contract/{contractId}")
    public ResponseEntity<?> createReport(
            @PathVariable Long contractId,
            @RequestBody ReportRequestDto dto,
            @CurrentMember Member reporter) {

        reportService.createReport(contractId, dto, reporter);
        return ResponseEntity.ok(Map.of("message", "신고가 접수되었습니다."));
    }

    // 특정 멤버가 받은 신고 내역 조회
    @GetMapping("/member/{memberId}")
    public ResponseEntity<List<ReportResponseDto>> getReportsByTarget(@PathVariable Long memberId) {
        List<ReportResponseDto> reports = reportService.getReportsByTarget(memberId);
        return ResponseEntity.ok(reports);
    }
}
