package com.deal.Fastruck.controller;

import com.deal.Fastruck.annotation.CurrentMember;
import com.deal.Fastruck.dto.ReportRequestDto;
import com.deal.Fastruck.dto.ReportResponseDto;
import com.deal.Fastruck.dto.ReportedCarrierStatDto;
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

    // 특정 멤버가 받은 신고 내역 조회 (관리자 전용)
    @GetMapping("/member/{memberId}")
    public ResponseEntity<List<ReportResponseDto>> getReportsByTarget(@PathVariable Long memberId) {
        List<ReportResponseDto> reports = reportService.getReportsByTarget(memberId);
        return ResponseEntity.ok(reports);
    }

    // 전체 신고 목록 조회 (관리자 전용)
    @GetMapping("/admin")
    public ResponseEntity<List<ReportResponseDto>> getAllReports() {
        List<ReportResponseDto> reports = reportService.getAllReports();
        return ResponseEntity.ok(reports);
    }

    // 신고 상세 조회 (관리자 전용)
    @GetMapping("/{reportId}")
    public ResponseEntity<ReportResponseDto> getReportDetail(@PathVariable Long reportId) {
        ReportResponseDto dto = reportService.getReportDetail(reportId);
        return ResponseEntity.ok(dto);
    }

    // 신고 통계 조회 (차주별 신고 누적 수 - 관리자용)
    @GetMapping("/admin/statistics")
    public ResponseEntity<List<ReportedCarrierStatDto>> getReportStatistics() {
        List<ReportedCarrierStatDto> stats = reportService.getReportStatistics();
        return ResponseEntity.ok(stats);
    }
}
