package com.deal.Fastruck.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BidProposalRequestDto {
    private Long cargoRequestId;
    private Long proposedPrice;
    private String message;
    // carrierId는 JWT에서 뽑거나, 테스트 땐 직접 전달
}
