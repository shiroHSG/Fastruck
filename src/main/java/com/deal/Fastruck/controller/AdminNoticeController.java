package com.deal.Fastruck.controller;

import com.deal.Fastruck.annotation.CurrentMember;
import com.deal.Fastruck.dto.AdminNoticeRequestDto;
import com.deal.Fastruck.dto.AdminNoticeResponseDto;
import com.deal.Fastruck.entity.AdminNotice;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.repository.AdminNoticeRepository;
import com.deal.Fastruck.service.AdminNoticeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/notices")
public class AdminNoticeController {

    private final AdminNoticeService adminNoticeService;

    private final AdminNoticeRepository adminNoticeRepository;

    // 알림 전송
    @PostMapping("/admin")
    public ResponseEntity<?> sendAdminNotice(@RequestBody AdminNoticeRequestDto dto) {
        adminNoticeService.sendNotice(dto);
        return ResponseEntity.ok(Map.of("message", "메시지가 성공적으로 발송되었습니다."));
    }

    // 알림 조회
    @GetMapping
    public ResponseEntity<List<AdminNoticeResponseDto>> getMyNotices(@CurrentMember Member member) {
        List<AdminNotice> notices = adminNoticeRepository.findByReceiverId(member.getId());
        List<AdminNoticeResponseDto> response = notices.stream()
                .map(AdminNoticeResponseDto::from)
                .toList();
        return ResponseEntity.ok(response);
    }
}