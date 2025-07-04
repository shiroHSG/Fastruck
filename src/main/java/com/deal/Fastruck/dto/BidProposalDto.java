package com.deal.Fastruck.dto;

import com.deal.Fastruck.entity.enums.BidStatus;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BidProposalDto {
    private Long id;
    private Long cargoRequestId;
    private Long carrierId;
    private String carrierName;
    private Long proposedPrice;
    private String expectedTime;
    private String message;
    private BidStatus status;
    private LocalDateTime createdAt;
}
