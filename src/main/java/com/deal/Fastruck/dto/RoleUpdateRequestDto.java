package com.deal.Fastruck.dto;

import com.deal.Fastruck.entity.enums.Role;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RoleUpdateRequestDto {
    @JsonProperty("role")
    private Role newRole; // ✅ enum Role로 직접 받기
}