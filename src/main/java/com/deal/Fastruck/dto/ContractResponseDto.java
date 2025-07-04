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

    public static ContractResponseDto from(Contract contract) {
        return ContractResponseDto.builder()
                .id(contract.getId())
                .cargoRequestId(contract.getCargoRequest().getId())
                .bidProposalId(contract.getBidProposal().getId())
                .shipperId(contract.getShipper().getId())
                .carrierId(contract.getCarrier().getId())
                .status(contract.getStatus())
                .createdAt(contract.getCreatedAt())
                .build();
    }
}
