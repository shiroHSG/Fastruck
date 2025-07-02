package com.deal.Fastruck.controller;

import com.deal.Fastruck.annotation.CurrentMember;
import com.deal.Fastruck.dto.ContractRequestDto;
import com.deal.Fastruck.dto.ContractResponseDto;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.service.ContractService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/contract")
@RequiredArgsConstructor
public class ContractController {

    private final ContractService contractService;

    // 게시글 생성
    @PostMapping
    public ResponseEntity<ContractResponseDto> createContract(
            @RequestBody ContractRequestDto dto,
            @CurrentMember Member member) {

        ContractResponseDto responseDto = contractService.createContract(dto, member);
        return ResponseEntity.ok(responseDto);
    }
}
