package com.deal.Fastruck.repository;

import com.deal.Fastruck.entity.Report;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReportRepository extends JpaRepository<Report, Long> {
    List<Report> findByTargetId(Long memberId);
}
