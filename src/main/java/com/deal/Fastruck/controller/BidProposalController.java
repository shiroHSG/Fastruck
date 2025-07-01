package com.deal.Fastruck.controller;

import com.deal.Fastruck.entity.BidProposal;
import com.deal.Fastruck.entity.BidStatus;
import com.deal.Fastruck.service.BidProposalService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/bid-proposals")
@RequiredArgsConstructor
public class BidProposalController {

    private final BidProposalService bidProposalService;

    // (1) 입찰 등록
    @PostMapping
    public BidProposal submitBid(@RequestBody BidProposal bidProposal) {
        // 실전에서는 DTO로 받고, carrierId는 JWT에서 추출!
        return bidProposalService.submitBid(bidProposal);
    }

    // (2) 내 입찰 내역(차주 입장에서)
    @GetMapping("/my")
    public List<BidProposal> getMyBids(@RequestParam Long carrierId) {
        // 실전에서는 carrierId를 JWT에서 추출!
        return bidProposalService.getMyBids(carrierId);
    }

    // (3) 특정 글에 들어온 입찰 현황(화주가 본다면, 차주는 본인 입찰도 볼 수 있음)
    @GetMapping("/by-cargo")
    public List<BidProposal> getBidsByCargo(@RequestParam Long cargoRequestId) {
        return bidProposalService.getBidsByCargoRequest(cargoRequestId);
    }

    // (4) 입찰 상세조회
    @GetMapping("/{id}")
    public BidProposal getBidDetail(@PathVariable Long id) {
        return bidProposalService.getBidDetail(id);
    }

    // (5) 입찰 상태 변경 (수정/취소/상태변경 등)
    @PatchMapping("/{id}/status")
    public BidProposal updateBidStatus(
            @PathVariable Long id,
            @RequestParam BidStatus status
    ) {
        return bidProposalService.updateBidStatus(id, status);
    }

    // (6) 입찰 삭제 (PENDING 상태만)
    @DeleteMapping("/{id}")
    public void deleteBid(@PathVariable Long id) {
        bidProposalService.deleteBid(id);
    }
}
