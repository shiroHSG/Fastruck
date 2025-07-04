package com.deal.Fastruck.controller;

import com.deal.Fastruck.annotation.CurrentMember;
import com.deal.Fastruck.dto.BidProposalDto;
import com.deal.Fastruck.dto.BidProposalRequestDto;
import com.deal.Fastruck.dto.BidProposalStatusUpdateDto;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.service.BidProposalService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/bid-proposals")
@RequiredArgsConstructor
public class BidProposalController {

    private final BidProposalService bidProposalService;

    // (1) 입찰 등록 (RequestDto로 받고, carrierId는 param으로 받음)
    @PostMapping
    public BidProposalDto submitBid(@RequestBody BidProposalRequestDto requestDto,
                                    @CurrentMember Member member) {
        return bidProposalService.submitBid(requestDto, member);
    }

    // (2) 내 입찰 내역(차주 입장에서) - carrierId는 param(나중에 JWT에서 추출!)
    @GetMapping("/my")
    public List<BidProposalDto> getMyBids(@RequestParam Long carrierId) {
        return bidProposalService.getMyBids(carrierId);
    }

    // (3) 특정 화물요청글에 들어온 모든 입찰 (입찰 현황)
    @GetMapping("/by-cargo")
    public List<BidProposalDto> getBidsByCargo(@RequestParam Long cargoRequestId) {
        return bidProposalService.getBidsByCargoRequest(cargoRequestId);
    }

    // (4) 입찰 상세조회
    @GetMapping("/{id}")
    public BidProposalDto getBidDetail(@PathVariable Long id) {
        return bidProposalService.getBidDetail(id);
    }

    // (5) 입찰 상태변경 (대기→수락/거절 등)
    @PatchMapping("/{id}/status")
    public BidProposalDto updateBidStatus(@PathVariable Long id,
                                          @RequestBody BidProposalStatusUpdateDto dto) {
        return bidProposalService.updateBidStatus(id, dto.getStatus());
    }

    // (6) 입찰 삭제 (대기상태만)
    @DeleteMapping("/{id}")
    public void deleteBid(@PathVariable Long id) {
        bidProposalService.deleteBid(id);
    }
}
