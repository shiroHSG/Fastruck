package com.deal.Fastruck.repository;

import com.deal.Fastruck.entity.CargoRequest;
import com.deal.Fastruck.entity.enums.CargoRequestStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CargoRequestRepository extends JpaRepository<CargoRequest, Long> {
    // 입찰 가능한 글만 (상태로 조회)
    List<CargoRequest> findByStatus(CargoRequestStatus status);

    // 출발지+도착지+상태(OPEN)로 필터링 (검색/필터)
    List<CargoRequest> findByDepartureLocationAndArrivalLocationAndStatus(
            String departureLocation, String arrivalLocation, CargoRequestStatus status
    );

    // (확장) shipper(작성자) id로 내 글 목록
    List<CargoRequest> findByShipper_Id(Long shipperId);

    // (확장) 여러 필터를 동적쿼리로 하고 싶으면 QueryDSL/Specification 사용 가능

    List<CargoRequest> findByCarrier_Id(Long carrierId); // (carrier 검색 추가)

    // (추가) 검색
    List<CargoRequest> findByDepartureLocationAndStatus(String departure, CargoRequestStatus status);
    List<CargoRequest> findByArrivalLocationAndStatus(String arrival, CargoRequestStatus status);
}
