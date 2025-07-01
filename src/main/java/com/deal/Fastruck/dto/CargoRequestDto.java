package com.deal.Fastruck.dto;

import com.deal.Fastruck.entity.CargoRequestStatus;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CargoRequestDto {
    private Long id;
    private String title;
    private String content;
    private String departureLocation;
    private String arrivalLocation;
    private String cargoType;
    private String weight;
    private String volume;
    private LocalDateTime pickupTime;
    private LocalDateTime deliveryTime;
    private CargoRequestStatus status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String shipperName;
    private String shipperPhone;
}
