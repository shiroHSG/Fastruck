package com.deal.Fastruck.controller;

import com.deal.Fastruck.entity.CargoRequest;
import com.deal.Fastruck.entity.CargoRequestStatus;
import com.deal.Fastruck.service.CargoRequestService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/cargo-requests")
@RequiredArgsConstructor
public class CargoRequestController {

    private final CargoRequestService cargoRequestService;

    // 전체/필터링(입찰가능만) 화물 요청 리스트
    @GetMapping
    public List<CargoRequest> getCargoRequests(
            @RequestParam(required = false) String departureLocation,
            @RequestParam(required = false) String arrivalLocation
    ) {
        // 둘 다 없으면 전체 OPEN 상태
        if (departureLocation == null && arrivalLocation == null) {
            return cargoRequestService.getOpenCargoRequests();
        }
        // 둘 다 있으면 필터 검색
        else if (departureLocation != null && arrivalLocation != null) {
            return cargoRequestService.getCargoRequestsByFilter(departureLocation, arrivalLocation);
        }
        // 하나만 있으면 전체 OPEN 상태 반환
        else {
            return cargoRequestService.getOpenCargoRequests();
        }
    }

    // 화물 요청글 상세 조회
    @GetMapping("/{id}")
    public CargoRequest getCargoRequestDetail(@PathVariable Long id) {
        return cargoRequestService.getCargoRequestById(id);
    }
}
