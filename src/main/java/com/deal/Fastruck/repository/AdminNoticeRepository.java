package com.deal.Fastruck.repository;

import com.deal.Fastruck.entity.AdminNotice;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AdminNoticeRepository extends JpaRepository<AdminNotice, Long> {
    List<AdminNotice> findByReceiverId(Long receiverId);

    // 특정 회원에 대한 WARNING 메시지만 조회
    List<AdminNotice> findByReceiverIdAndMessageType(Long receiverId, String messageType);

    // 최근 경고 전송 내역 정렬
    List<AdminNotice> findByReceiverIdOrderByCreatedAtDesc(Long receiverId);
}
