package com.deal.Fastruck.controller;

import com.deal.Fastruck.service.BidProposalService;
import com.deal.Fastruck.service.ContractService;
import com.deal.Fastruck.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/dashboard")
@RequiredArgsConstructor
public class DashboardController {

    private final MemberService memberService;
    private final BidProposalService bidProposalService;
    private final ContractService contractService;

    // ✅ 연도별 사용자 통계 (PieChart)
    @GetMapping("/count/by-year")
    public ResponseEntity<?> getUserStatsByYear(@RequestParam int year) {
        return ResponseEntity.ok(memberService.getUserStatsByYear(year));
    }

    // ✅ 월별 수익 통계 (막대그래프)
    @GetMapping("/monthly-earnings")
    public ResponseEntity<List<Map<String, Object>>> getMonthlyEarnings(@RequestParam int year) {
        return ResponseEntity.ok(bidProposalService.getMonthlyEarningsByYear(year));
    }

    // ✅ 최근 계약 5건
    @GetMapping("/recent")
    public ResponseEntity<List<Map<String, Object>>> getRecentContracts() {
        return ResponseEntity.ok(contractService.getRecentContracts());
    }
}
