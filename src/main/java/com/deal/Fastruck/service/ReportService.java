package com.deal.Fastruck.service;

import com.deal.Fastruck.dto.ReportRequestDto;
import com.deal.Fastruck.dto.ReportResponseDto;
import com.deal.Fastruck.dto.ReportedCarrierStatDto;
import com.deal.Fastruck.entity.Contract;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.entity.Report;
import com.deal.Fastruck.repository.ContractRepository;
import com.deal.Fastruck.repository.MemberRepository;
import com.deal.Fastruck.repository.ReportRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ReportService {

    private final ContractRepository contractRepository;
    private final MemberRepository memberRepository;

    private final ReportRepository reportRepository;

    @Transactional
    public void createReport(Long contractId, ReportRequestDto dto, Member reporter) {
        Contract contract = contractRepository.findById(contractId)
                .orElseThrow(() -> new EntityNotFoundException("계약을 찾을 수 없습니다."));

        Member target = memberRepository.findById(dto.getTargetId())
                .orElseThrow(() -> new EntityNotFoundException("신고 대상이 존재하지 않습니다."));

        Report report = Report.builder()
                .contract(contract)
                .reporter(reporter)
                .target(target)
                .reason(dto.getReason())
                .description(dto.getDescription())
                .build();

        reportRepository.save(report);
    }

    @Transactional(readOnly = true)
    public List<ReportResponseDto> getReportsByTarget(Long memberId) {
        List<Report> reports = reportRepository.findByTargetId(memberId);
        return reports.stream()
                .map(ReportResponseDto::from)
                .collect(Collectors.toList());
    }

    /**
     * 전체 신고 목록 조회 (관리자용)
     */
    public List<ReportResponseDto> getAllReports() {
        List<Report> reports = reportRepository.findAll();
        return reports.stream()
                .map(ReportResponseDto::from)
                .collect(Collectors.toList());
    }

    /**
     * 신고 상세 조회
     */
    public ReportResponseDto getReportDetail(Long reportId) {
        Report report = reportRepository.findById(reportId)
                .orElseThrow(() -> new EntityNotFoundException("해당 신고 내역을 찾을 수 없습니다."));
        return ReportResponseDto.from(report);
    }

    @Transactional(readOnly = true)
    public List<ReportedCarrierStatDto> getReportStatistics() {
        return reportRepository.findReportStatistics();
    }
}
