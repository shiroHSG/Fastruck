package com.deal.Fastruck.dto;

import com.deal.Fastruck.entity.Contract;
import com.deal.Fastruck.entity.enums.ContractStatus;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ContractResponseDto {

    private Long id;
    private Long cargoRequestId;
    private Long bidProposalId;
    private Long shipperId;
    private Long carrierId;
    private ContractStatus status;
    private LocalDateTime createdAt;

    public ContractResponseDto(Contract contract) {
        this.id = contract.getId();
        this.cargoRequestId = contract.getCargoRequest().getId();
        this.bidProposalId = contract.getBidProposal().getId();
        this.shipperId = contract.getShipper().getId();
        this.carrierId = contract.getCarrier().getId();
        this.status = contract.getStatus();
        this.createdAt = contract.getCreatedAt();
    }
}
