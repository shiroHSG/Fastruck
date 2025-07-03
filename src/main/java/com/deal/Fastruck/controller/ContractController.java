package com.deal.Fastruck.controller;

import com.deal.Fastruck.annotation.CurrentMember;
import com.deal.Fastruck.dto.ContractRequestDto;
import com.deal.Fastruck.dto.ContractResponseDto;
import com.deal.Fastruck.dto.ContractUpdateDto;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.service.ContractService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/contract")
@RequiredArgsConstructor
public class ContractController {

    private final ContractService contractService;

    // 계약 생성
    @PostMapping
    public ResponseEntity<?> createContract(
            @RequestBody ContractRequestDto dto,
            @CurrentMember Member member) {

        contractService.createContract(dto, member);
        return ResponseEntity.ok(Map.of("message", "계약이 생성되었습니다."));
    }

    // 계약 리스트 조회
    @GetMapping
    public ResponseEntity<List<ContractResponseDto>> getContractList(@CurrentMember Member member) {
        List<ContractResponseDto> contracts = contractService.getContractList(member);
        return ResponseEntity.ok(contracts);
    }

    // 계약 상세 조회
    @GetMapping("/{id}")
    public ResponseEntity<ContractResponseDto> getContractDetail(@CurrentMember Member member, @PathVariable Long id) {
        ContractResponseDto responseDto = contractService.getContractDetail(id);
        return ResponseEntity.ok(responseDto);
    }

    // 계약 상태 수정
    @PatchMapping("/{id}")
    public ResponseEntity<?> updateContractStatus(
            @PathVariable Long id,
            @RequestBody ContractUpdateDto dto,
            @CurrentMember Member member) {

        contractService.updateContractStatus(id, dto, member);
        return ResponseEntity.ok(Map.of("message", "운송 상태가 변경되었습니다."));
    }

    // 계약 삭제
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteContract(
            @PathVariable Long id,
            @CurrentMember Member member) {

        contractService.deleteContract(id, member);
        return ResponseEntity.ok(Map.of("message", "계약이 삭제되었습니다."));
    }
}
