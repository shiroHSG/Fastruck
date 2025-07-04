package com.deal.Fastruck.dto;

import com.deal.Fastruck.entity.AdminNotice;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class AdminNoticeResponseDto {

    private Long id;
    private String title;
    private String content;
    private String messageType;
    private LocalDateTime createdAt;

    public static AdminNoticeResponseDto from(AdminNotice notice) {
        return AdminNoticeResponseDto.builder()
                .id(notice.getId())
                .title(notice.getTitle())
                .content(notice.getContent())
                .messageType(notice.getMessageType())
                .createdAt(notice.getCreatedAt())
                .build();
    }
}
