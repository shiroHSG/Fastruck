package com.deal.Fastruck.repository;

import com.deal.Fastruck.entity.AdminNotice;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AdminNoticeRepository extends JpaRepository<AdminNotice, Long> {
    List<AdminNotice> findByReceiverId(Long receiverId);
}
