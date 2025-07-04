package com.deal.Fastruck.dto;

import lombok.Getter;

@Getter
public class AdminNoticeRequestDto {
    private Long receiverId;     // 메시지 받을 회원 ID
    private String title;
    private String content;
    private String messageType;  // "NOTICE" or "WARNING"
}