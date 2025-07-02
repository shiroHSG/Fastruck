package com.deal.Fastruck.controller;

import com.deal.Fastruck.dto.CargoRequestAssignDto;
import com.deal.Fastruck.dto.CargoRequestDto;
import com.deal.Fastruck.dto.CargoRequestRequestDto;
import com.deal.Fastruck.service.CargoRequestService;
import com.deal.Fastruck.security.MemberDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/cargo-requests")
@RequiredArgsConstructor
public class CargoRequestController {

    private final CargoRequestService cargoRequestService;

    // 생성
    @PostMapping
    public CargoRequestDto create(@RequestBody CargoRequestRequestDto dto, @AuthenticationPrincipal MemberDetails user) {
        return cargoRequestService.createCargoRequest(user.getId(), dto);
    }

    // 수정
    @PutMapping("/{id}")
    public CargoRequestDto update(@PathVariable Long id, @RequestBody CargoRequestRequestDto dto, @AuthenticationPrincipal MemberDetails user) {
        return cargoRequestService.updateCargoRequest(id, user.getId(), dto);
    }

    // 삭제
    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id, @AuthenticationPrincipal MemberDetails user) {
        cargoRequestService.deleteCargoRequest(id, user.getId());
    }

    // 배정
    @PatchMapping("/{id}/assign")
    public CargoRequestDto assign(@PathVariable Long id, @RequestBody CargoRequestAssignDto dto, @AuthenticationPrincipal MemberDetails user) {
        return cargoRequestService.assignCarrier(id, dto.getCarrierId(), user.getId());
    }

    // 배송 완료
    @PatchMapping("/{id}/complete")
    public CargoRequestDto complete(@PathVariable Long id, @AuthenticationPrincipal MemberDetails user) {
        return cargoRequestService.completeDelivery(id, user.getId());
    }

    // 전체 조회 or 조건 검색
    @GetMapping
    public List<CargoRequestDto> getCargoRequests(
            @RequestParam(required = false) String departureLocation,
            @RequestParam(required = false) String arrivalLocation
    ) {
        if (departureLocation == null && arrivalLocation == null) {
            return cargoRequestService.getOpenCargoRequests();
        } else if (departureLocation != null && arrivalLocation != null) {
            return cargoRequestService.getCargoRequestsByFilter(departureLocation, arrivalLocation);
        } else {
            return cargoRequestService.getOpenCargoRequests();
        }
    }

    // 상세조회
    @GetMapping("/{id}")
    public CargoRequestDto getCargoRequestDetail(@PathVariable Long id) {
        return cargoRequestService.getCargoRequestById(id);
    }
}
