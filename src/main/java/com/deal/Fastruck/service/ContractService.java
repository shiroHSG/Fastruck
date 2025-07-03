package com.deal.Fastruck.service;

import com.deal.Fastruck.dto.ContractResponseDto;
import com.deal.Fastruck.dto.ContractUpdateDto;
import com.deal.Fastruck.entity.BidProposal;
import com.deal.Fastruck.entity.CargoRequest;
import com.deal.Fastruck.entity.Contract;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.entity.enums.ContractStatus;
import com.deal.Fastruck.repository.BidProposalRepository;
import com.deal.Fastruck.repository.ContractRepository;
import com.deal.Fastruck.repository.MemberRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ContractService {

    private final BidProposalRepository bidProposalRepository;
    private final ContractRepository contractRepository;

    private final MemberRepository memberRepository;

    @Transactional
    public void createContract(Long bidProposalId, Member shipper) {
        // BidProposal 조회
        BidProposal bidProposal = bidProposalRepository.findById(bidProposalId)
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
    }

    @Transactional(readOnly = true)
    public ContractResponseDto getContractDetail(Long bidProposalId) {
        Contract contract = contractRepository.findByBidProposalId(bidProposalId)
                .orElseThrow(() -> new EntityNotFoundException("해당 입찰에 대한 계약이 존재하지 않습니다."));
        return ContractResponseDto.from(contract);
    }

    @Transactional
    public void updateContractStatus(Long bidProposalId, ContractUpdateDto dto, Member currentMember) {
        Contract contract = contractRepository.findByBidProposalId(bidProposalId)
                .orElseThrow(() -> new EntityNotFoundException("해당 입찰에 대한 계약이 존재하지 않습니다."));

        // 인증된 사용자가 화주 or 운송인인지 검증 (권한 체크)
        if (!contract.getCarrier().getId().equals(currentMember.getId())) {
            throw new AccessDeniedException("계약 상태를 변경할 권한이 없습니다.");
        }

        contract.setStatus(dto.getStatus());
    }

}
