package com.deal.Fastruck.service;

import com.deal.Fastruck.dto.AdminNoticeRequestDto;
import com.deal.Fastruck.entity.AdminNotice;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.repository.AdminNoticeRepository;
import com.deal.Fastruck.repository.MemberRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class AdminNoticeService {

    private final AdminNoticeRepository adminNoticeRepository;
    private final MemberRepository memberRepository;

    @Transactional
    public void sendNotice(AdminNoticeRequestDto dto) {
        Member receiver = memberRepository.findById(dto.getReceiverId())
                .orElseThrow(() -> new EntityNotFoundException("수신 회원을 찾을 수 없습니다."));

        AdminNotice notice = AdminNotice.builder()
                .receiver(receiver)
                .title(dto.getTitle())
                .content(dto.getContent())
                .messageType(dto.getMessageType())
                .build();

        adminNoticeRepository.save(notice);
    }
}
