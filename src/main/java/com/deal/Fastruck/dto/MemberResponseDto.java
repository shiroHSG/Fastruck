package com.deal.Fastruck.dto;

import com.deal.Fastruck.entity.enums.Role;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberResponseDto {
    private Long id;
    private Role role;
    private String name;
    private String email;
    private String phone;
    private String imageUrl;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}