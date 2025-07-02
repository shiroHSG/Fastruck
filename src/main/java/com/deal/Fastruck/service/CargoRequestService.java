package com.deal.Fastruck.service;

import com.deal.Fastruck.dto.CargoRequestDto;
import com.deal.Fastruck.entity.CargoRequest;
import com.deal.Fastruck.entity.enums.CargoRequestStatus;
import com.deal.Fastruck.repository.CargoRequestRepository;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CargoRequestService {

    private final CargoRequestRepository cargoRequestRepository;
    private final MemberRepository memberRepository;

    // 1. 전체 "입찰가능(OPEN)" 화물 리스트
    @Transactional(readOnly = true)
    public List<CargoRequestDto> getOpenCargoRequests() {
        List<CargoRequest> list = cargoRequestRepository.findByStatus(CargoRequestStatus.OPEN);
        return list.stream().map(this::toDto).collect(Collectors.toList());
    }

    // 2. 출발지+도착지 필터 검색
    @Transactional(readOnly = true)
    public List<CargoRequestDto> getCargoRequestsByFilter(String departure, String arrival) {
        List<CargoRequest> list = cargoRequestRepository.findByDepartureLocationAndArrivalLocationAndStatus(
                departure, arrival, CargoRequestStatus.OPEN
        );
        return list.stream().map(this::toDto).collect(Collectors.toList());
    }

    // 3. 상세조회
    @Transactional(readOnly = true)
    public CargoRequestDto getCargoRequestById(Long id) {
        CargoRequest entity = cargoRequestRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("존재하지 않는 화물요청글입니다."));
        return toDto(entity);
    }

    // Entity → DTO 변환
    private CargoRequestDto toDto(CargoRequest entity) {
        Member shipper = entity.getShipper();
        return CargoRequestDto.builder()
                .id(entity.getId())
                .title(entity.getTitle())
                .content(entity.getContent())
                .departureLocation(entity.getDepartureLocation())
                .arrivalLocation(entity.getArrivalLocation())
                .cargoType(entity.getCargoType())
                .weight(entity.getWeight())
                .volume(entity.getVolume())
                .pickupTime(entity.getPickupTime())
                .deliveryTime(entity.getDeliveryTime())
                .status(entity.getStatus())
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .shipperName(shipper != null ? shipper.getName() : null)
                .shipperPhone(shipper != null ? shipper.getPhone() : null)
                .build();
    }
}
