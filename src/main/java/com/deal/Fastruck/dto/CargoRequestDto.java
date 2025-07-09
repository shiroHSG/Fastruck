package com.deal.Fastruck.dto;

import com.deal.Fastruck.entity.CargoRequest;
import com.deal.Fastruck.entity.Member;
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
    private String carrierName;   // 배정된 기사 이름
    private String carrierPhone;  // 배정된 기사 연락처
    private String expectedTime;

    // ✅ 정적 변환 메서드 추가
    public static CargoRequestDto from(CargoRequest entity) {

        Member shipper = entity.getShipper();
        Member carrier = entity.getCarrier();

        return CargoRequestDto.builder()
                .id(entity.getId())
                .requestContent(entity.getRequestContent())
                .departureLocation(entity.getDepartureLocation())
                .arrivalLocation(entity.getArrivalLocation())
                .cargoType(entity.getCargoType())
                .weight(entity.getWeight())
                .volume(null) // ❗ entity에 volume 필드 없음
                .pickupTime(entity.getPickupTime())
                .deliveryTime(entity.getDeliveryTime())
                .expectedTime(entity.getExpectedTime())
                .status(entity.getStatus())
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .shipperName(entity.getShipper() != null ? entity.getShipper().getName() : null)
                .shipperPhone(entity.getShipper() != null ? entity.getShipper().getPhone() : null)
                .carrierName(entity.getCarrier() != null ? entity.getCarrier().getName() : null)
                .carrierPhone(entity.getCarrier() != null ? entity.getCarrier().getPhone() : null)
                .build();
    }
}
