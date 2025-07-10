package com.deal.Fastruck.repository;

import com.deal.Fastruck.dto.ReportedCarrierStatDto;
import com.deal.Fastruck.entity.Report;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ReportRepository extends JpaRepository<Report, Long> {
    List<Report> findByTargetId(Long memberId);

    // 차주별 신고 건수 통계 (통계용 상단 표)
    @Query("SELECT r.target.id AS carrierId, r.target.name AS carrierName, COUNT(r) AS reportCount " +
            "FROM Report r GROUP BY r.target.id ORDER BY reportCount DESC")
    List<ReportedCarrierStatDto> findReportStatistics();

    // 계약 ID로 신고 목록 조회
    List<Report> findByContract_Id(Long contractId);

    // 특정 신고자(화주) 기준 신고 내역
    List<Report> findByReporterId(Long reporterId);
}
