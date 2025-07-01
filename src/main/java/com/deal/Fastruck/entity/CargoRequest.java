package com.deal.Fastruck.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Entity
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor @Builder
@EntityListeners(AuditingEntityListener.class)
public class CargoRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 글 작성자 (화주)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "shipper_id", nullable = false)
    private Member shipper;

    @Column(nullable = false, length = 100)
    private String title;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String content;

    @Column(nullable = false, length = 50)
    private String departureLocation;

    @Column(nullable = false, length = 50)
    private String arrivalLocation;

    @Column(nullable = false, length = 50)
    private String cargoType;

    @Column(nullable = false, length = 30)
    private String weight; // 예: "1000kg"

    @Column(length = 30)
    private String volume; // 선택

    @Column
    private LocalDateTime pickupTime;

    @Column
    private LocalDateTime deliveryTime;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private CargoRequestStatus status; // OPEN, CLOSED, COMPLETE, CANCELLED

    @CreatedDate
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(nullable = false)
    private LocalDateTime updatedAt;
}
// 화물 요청글