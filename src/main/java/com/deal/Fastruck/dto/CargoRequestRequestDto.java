package com.deal.Fastruck.dto;

import com.deal.Fastruck.entity.enums.CargoRequestStatus;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CargoRequestRequestDto {
    private String requestContent;
    private String departureLocation;
    private String arrivalLocation;
    private String cargoType;
    private Float weight;
    private LocalDateTime pickupTime;
    private LocalDateTime deliveryTime;
    private String expectedTime;
}