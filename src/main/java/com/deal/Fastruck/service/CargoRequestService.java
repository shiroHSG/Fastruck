package com.deal.Fastruck.service;

import com.deal.Fastruck.dto.CargoRequestAssignDto;
import com.deal.Fastruck.dto.CargoRequestDto;
import com.deal.Fastruck.dto.CargoRequestRequestDto;
import com.deal.Fastruck.entity.CargoRequest;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.entity.enums.CargoRequestStatus;
import com.deal.Fastruck.entity.enums.Role;
import com.deal.Fastruck.repository.CargoRequestRepository;
import com.deal.Fastruck.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

import static com.deal.Fastruck.entity.enums.Role.SHIPPER;

@Service
@RequiredArgsConstructor
public class CargoRequestService {
    private final CargoRequestRepository cargoRequestRepository;
    private final MemberRepository memberRepository;

    // 생성
    @Transactional
    public CargoRequestDto createCargoRequest(Long id, CargoRequestRequestDto dto) {
        Member shipper = memberRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("화물요청글 없음"));

        if (shipper.getRole() != SHIPPER) {
            throw new IllegalArgumentException("화물 요청은 화주 계정만 생성할 수 있습니다.");
        }

        CargoRequest entity = CargoRequest.builder()
                .shipper(shipper)
                .requestContent(dto.getRequestContent())
                .departureLocation(dto.getDepartureLocation())
                .arrivalLocation(dto.getArrivalLocation())
                .cargoType(dto.getCargoType())
                .weight(dto.getWeight())
                .pickupTime(dto.getPickupTime())
                .deliveryTime(dto.getDeliveryTime())
                .expectedTime(dto.getExpectedTime())
                .status(CargoRequestStatus.UNASSIGNED)
                .build();
        cargoRequestRepository.save(entity);
        return toDto(entity);
    }

    // 수정
    @Transactional
    public CargoRequestDto updateCargoRequest(Long id, Long memberId, CargoRequestRequestDto dto) {
        CargoRequest entity = cargoRequestRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("화물요청글 없음"));
        if (!entity.getShipper().getId().equals(memberId)) {
            throw new RuntimeException("수정 권한 없음");
        }
        entity.setRequestContent(dto.getRequestContent());
        entity.setDepartureLocation(dto.getDepartureLocation());
        entity.setArrivalLocation(dto.getArrivalLocation());
        entity.setCargoType(dto.getCargoType());
        entity.setWeight(dto.getWeight());
        entity.setPickupTime(dto.getPickupTime());
        entity.setDeliveryTime(dto.getDeliveryTime());
        entity.setExpectedTime(dto.getExpectedTime());
        return toDto(entity);
    }

    // 삭제
    @Transactional
    public void deleteCargoRequest(Long id, Long memberId) {
        CargoRequest entity = cargoRequestRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("화물요청글 없음"));
        if (!entity.getShipper().getId().equals(memberId)) {
            throw new RuntimeException("삭제 권한 없음");
        }
        cargoRequestRepository.delete(entity);
    }

    // 배정(ASSIGN) - carrier 지정 및 상태 변경
    @Transactional
    public CargoRequestDto assignCarrier(Long cargoRequestId, Long carrierId, Long shipperId) {
        CargoRequest entity = cargoRequestRepository.findById(cargoRequestId)
                .orElseThrow(() -> new RuntimeException("화물요청글 없음"));
        if (!entity.getShipper().getId().equals(shipperId)) {
            throw new RuntimeException("배정 권한 없음");
        }
        Member carrier = memberRepository.findById(carrierId)
                .orElseThrow(() -> new RuntimeException("운송기사 없음"));
        if (carrier.getRole() != Role.CARRIER) {
            throw new RuntimeException("운송기사만 배정 가능");
        }
        entity.setCarrier(carrier);
        entity.setStatus(CargoRequestStatus.ASSIGN);
        return toDto(entity);
    }

    // 배송 완료(상태 COMPLETE)
    @Transactional
    public CargoRequestDto completeDelivery(Long cargoRequestId, Long carrierId) {
        CargoRequest entity = cargoRequestRepository.findById(cargoRequestId)
                .orElseThrow(() -> new RuntimeException("화물요청글 없음"));
        if (entity.getCarrier() == null || !entity.getCarrier().getId().equals(carrierId)) {
            throw new RuntimeException("완료 권한 없음");
        }
        entity.setStatus(CargoRequestStatus.COMPLETE);
        return toDto(entity);
    }

    // 전체(UNASSIGNED) 리스트
    @Transactional(readOnly = true)
    public List<CargoRequestDto> getOpenCargoRequests() {
        List<CargoRequest> list = cargoRequestRepository.findByStatus(CargoRequestStatus.UNASSIGNED);
        return list.stream().map(this::toDto).collect(Collectors.toList());
    }

    // 출발지+도착지 필터
    @Transactional(readOnly = true)
    public List<CargoRequestDto> getCargoRequestsByFilter(String departure, String arrival) {
        List<CargoRequest> list = cargoRequestRepository.findByDepartureLocationAndArrivalLocationAndStatus(
                departure, arrival, CargoRequestStatus.UNASSIGNED
        );
        return list.stream().map(this::toDto).collect(Collectors.toList());
    }

    // 상세조회
    @Transactional(readOnly = true)
    public CargoRequestDto getCargoRequestById(Long id) {
        CargoRequest entity = cargoRequestRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("존재하지 않는 화물요청글입니다."));
        return toDto(entity);
    }

    // Entity → DTO 변환
    private CargoRequestDto toDto(CargoRequest entity) {
        Member shipper = entity.getShipper();
        Member carrier = entity.getCarrier();
        return CargoRequestDto.builder()
                .id(entity.getId())
                .requestContent(entity.getRequestContent())
                .departureLocation(entity.getDepartureLocation())
                .arrivalLocation(entity.getArrivalLocation())
                .cargoType(entity.getCargoType())
                .weight(entity.getWeight())
                .pickupTime(entity.getPickupTime())
                .deliveryTime(entity.getDeliveryTime())
                .expectedTime(entity.getExpectedTime())
                .status(entity.getStatus())
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .shipperName(shipper != null ? shipper.getName() : null)
                .shipperPhone(shipper != null ? shipper.getPhone() : null)
                .carrierName(carrier != null ? carrier.getName() : null)
                .carrierPhone(carrier != null ? carrier.getPhone() : null)
                .build();
    }
}
