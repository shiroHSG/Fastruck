package com.deal.Fastruck.dto;

import com.deal.Fastruck.entity.enums.Role;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberRequestDto {

    @NotNull(message = "역할은 필수입니다.")
    private Role role; // SHIPPER / CARRIER

    @NotBlank(message = "이름은 필수입니다.")
    private String name;

    @NotBlank(message = "이메일은 필수입니다.")
    private String email;

    @NotBlank(message = "비밀번호는 필수입니다.")
    private String password;

    private String phone; // 선택값이므로 유효성 검사는 생략
}