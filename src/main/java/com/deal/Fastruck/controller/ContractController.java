package com.deal.Fastruck.controller;

import com.deal.Fastruck.annotation.CurrentMember;
import com.deal.Fastruck.dto.ContractResponseDto;
import com.deal.Fastruck.dto.ContractUpdateDto;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.service.ContractService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/bid-proposals/{bidProposalId}/contract")
@RequiredArgsConstructor
public class ContractController {

    private final ContractService contractService;

    // 계약 생성
    @PostMapping
    public ResponseEntity<?> createContract(
            @PathVariable Long bidProposalId,
            @CurrentMember Member member) {

        contractService.createContract(bidProposalId, member);
        return ResponseEntity.ok(Map.of("message", "계약이 생성되었습니다."));
    }

    // 계약 조회
    @GetMapping
    public ResponseEntity<ContractResponseDto> getContractDetail(
            @CurrentMember Member member,
            @PathVariable Long bidProposalId) {
        ContractResponseDto responseDto = contractService.getContractDetail(bidProposalId);
        return ResponseEntity.ok(responseDto);
    }

    // 계약 상태 수정
    @PatchMapping
    public ResponseEntity<?> updateContractStatus(
            @PathVariable Long bidProposalId,
            @RequestBody ContractUpdateDto dto,
            @CurrentMember Member member) {

        contractService.updateContractStatus(bidProposalId, dto, member);
        return ResponseEntity.ok(Map.of("message", "운송 상태가 변경되었습니다."));
    }
}
