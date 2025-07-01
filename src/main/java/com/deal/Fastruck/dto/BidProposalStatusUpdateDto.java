package com.deal.Fastruck.dto;

import com.deal.Fastruck.entity.BidStatus;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BidProposalStatusUpdateDto {
    private BidStatus status;
}
