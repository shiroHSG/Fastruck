package com.deal.Fastruck.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EntityListeners(AuditingEntityListener.class)
public class CargoRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 작성자 (화주)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "shipper_id", nullable = false)
    private Member shipper;

    // 요구사항
    @Lob
    private String requestContent;

    // 출발지
    @Column(nullable = false, length = 100)
    private String departureLocation;

    // 도착지
    @Column(nullable = false, length = 100)
    private String arrivalLocation;

    // 화물 종류
    @Column(nullable = false, length = 50)
    private String cargoType;

    // 무게 (선택)
    @Column(length = 50)
    private Float weight;

    // 원하는 픽업 시간 (선택)
    private LocalDateTime pickupTime;

    // 원하는 도착 시간 (선택)
    private LocalDateTime deliveryTime;

    // 요청 상태: UNASSIGNED / ASSIGN / COMPLETE
    @Column(nullable = false, length = 20)
    private String status;

    @CreatedDate
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;
}
