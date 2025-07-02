package com.deal.Fastruck.service;

import com.deal.Fastruck.dto.ContractRequestDto;
import com.deal.Fastruck.dto.ContractResponseDto;
import com.deal.Fastruck.entity.BidProposal;
import com.deal.Fastruck.entity.CargoRequest;
import com.deal.Fastruck.entity.Contract;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.entity.enums.ContractStatus;
import com.deal.Fastruck.repository.BidProposalRepository;
import com.deal.Fastruck.repository.ContractRepository;
import com.deal.Fastruck.repository.MemberRepository;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractService {

    private final BidProposalRepository bidProposalRepository;
    private final ContractRepository contractRepository;

    private final MemberRepository memberRepository;

    @Transactional
    public ContractResponseDto createContract(ContractRequestDto dto, Member shipper) {
        // BidProposal 조회
        BidProposal bidProposal = bidProposalRepository.findById(dto.getBidProposalId())
                .orElseThrow(() -> new EntityNotFoundException("입찰 제안이 존재하지 않습니다."));

        // 화물 요청, 운송인 추출
        CargoRequest cargoRequest = bidProposal.getCargoRequest();
        Member carrier = bidProposal.getCarrier();

        // Contract 생성
        Contract contract = Contract.builder()
                .cargoRequest(cargoRequest)
                .bidProposal(bidProposal)
                .shipper(shipper)
                .carrier(carrier)
                .status(ContractStatus.MOVING_TO_HUB)
                .build();

        contractRepository.save(contract);

        return new ContractResponseDto(contract);
    }
}
