package com.deal.Fastruck.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Entity
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor @Builder
@EntityListeners(AuditingEntityListener.class)
public class BidProposal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 어떤 화물 요청글에 입찰했는지
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cargo_request_id", nullable = false)
    private CargoRequest cargoRequest;

    // 입찰한 차주(운송사)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "carrier_id", nullable = false)
    private Member carrier;

    @Column(nullable = false)
    private Long proposedPrice;

    @Column(length = 255)
    private String message; // 전달 메시지(선택)

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private BidStatus status; // PENDING, ACCEPTED, REJECTED

    @CreatedDate
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;
}
// 입찰 제안