package com.deal.Fastruck.dto;

import com.deal.Fastruck.entity.enums.CargoRequestStatus;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CargoRequestDto {
    private Long id;
    private String requestContent;
    private String departureLocation;
    private String arrivalLocation;
    private String cargoType;
    private Float weight;
    private String volume;
    private LocalDateTime pickupTime;
    private LocalDateTime deliveryTime;
    private CargoRequestStatus status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String shipperName;
    private String shipperPhone;
}
