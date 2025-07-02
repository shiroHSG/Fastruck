package com.deal.Fastruck.controller;

import com.deal.Fastruck.dto.CargoRequestDto; // <- 이거 추가
import com.deal.Fastruck.service.CargoRequestService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/cargo-requests")
@RequiredArgsConstructor
public class CargoRequestController {

    private final CargoRequestService cargoRequestService;

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

    @GetMapping("/{id}")
    public CargoRequestDto getCargoRequestDetail(@PathVariable Long id) {
        return cargoRequestService.getCargoRequestById(id);
    }
}
