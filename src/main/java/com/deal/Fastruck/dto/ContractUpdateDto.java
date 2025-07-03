package com.deal.Fastruck.dto;

import com.deal.Fastruck.entity.enums.ContractStatus;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ContractUpdateDto {
    private ContractStatus status;
}
