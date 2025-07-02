package com.deal.Fastruck.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CargoRequestFilterDto {
    private String departureLocation;
    private String arrivalLocation;
    private String cargoType;
    private String weight; // (필터 필요시)
    // 날짜 등 추가 가능
}
