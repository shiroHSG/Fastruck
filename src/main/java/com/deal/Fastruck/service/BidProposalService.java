package com.deal.Fastruck.service;

import com.deal.Fastruck.dto.BidProposalDto;
import com.deal.Fastruck.dto.BidProposalRequestDto;
import com.deal.Fastruck.entity.BidProposal;
import com.deal.Fastruck.entity.CargoRequest;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.entity.enums.BidStatus;
import com.deal.Fastruck.repository.BidProposalRepository;
import com.deal.Fastruck.repository.CargoRequestRepository;
import com.deal.Fastruck.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BidProposalService {

    private final BidProposalRepository bidProposalRepository;
    private final CargoRequestRepository cargoRequestRepository;
    private final MemberRepository memberRepository;

    // 1. 입찰 등록
    @Transactional
    public BidProposalDto submitBid(BidProposalRequestDto dto, Long carrierId) {
        // 중복 입찰 방지 (한 차주가 한 글에 여러번 입찰 금지)
        if (bidProposalRepository.existsByCargoRequest_IdAndCarrier_Id(dto.getCargoRequestId(), carrierId)) {
            throw new RuntimeException("이미 해당 화물요청에 입찰하셨습니다.");
        }

        CargoRequest cargoRequest = cargoRequestRepository.findById(dto.getCargoRequestId())
                .orElseThrow(() -> new RuntimeException("화물요청글이 존재하지 않습니다."));
        Member carrier = memberRepository.findById(carrierId)
                .orElseThrow(() -> new RuntimeException("차주 정보가 없습니다."));

        BidProposal bid = BidProposal.builder()
                .cargoRequest(cargoRequest)
                .carrier(carrier)
                .proposedPrice(dto.getProposedPrice())
                .message(dto.getMessage())
                .status(BidStatus.PENDING)
                .build();

        BidProposal saved = bidProposalRepository.save(bid);
        return toDto(saved);
    }

    // 2. 내 입찰 내역(차주 기준)
    @Transactional(readOnly = true)
    public List<BidProposalDto> getMyBids(Long carrierId) {
        List<BidProposal> list = bidProposalRepository.findByCarrier_Id(carrierId);
        return list.stream().map(this::toDto).collect(Collectors.toList());
    }

    // 3. 특정 화물요청글의 입찰 현황(모든 입찰)
    @Transactional(readOnly = true)
    public List<BidProposalDto> getBidsByCargoRequest(Long cargoRequestId) {
        List<BidProposal> list = bidProposalRepository.findByCargoRequest_Id(cargoRequestId);
        return list.stream().map(this::toDto).collect(Collectors.toList());
    }

    // 4. 입찰 상세 조회
    @Transactional(readOnly = true)
    public BidProposalDto getBidDetail(Long id) {
        BidProposal entity = bidProposalRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("입찰 정보가 없습니다."));
        return toDto(entity);
    }

    // 5. 입찰 상태 변경 (수정/취소/수락/거절 등)
    @Transactional
    public BidProposalDto updateBidStatus(Long bidId, BidStatus status) {
        BidProposal bid = bidProposalRepository.findById(bidId)
                .orElseThrow(() -> new RuntimeException("입찰 정보가 없습니다."));
        // 실제 권한/상태 검증 로직은 상황에 맞게 추가
        bid.setStatus(status);
        return toDto(bid);
    }

    // 6. 입찰 삭제 (PENDING 상태만)
    @Transactional
    public void deleteBid(Long bidId) {
        BidProposal bid = bidProposalRepository.findById(bidId)
                .orElseThrow(() -> new RuntimeException("입찰 정보가 없습니다."));
        if (bid.getStatus() != BidStatus.PENDING) {
            throw new RuntimeException("대기(PENDING) 상태에서만 입찰 삭제가 가능합니다.");
        }
        bidProposalRepository.delete(bid);
    }

    // Entity → DTO 변환
    private BidProposalDto toDto(BidProposal entity) {
        return BidProposalDto.builder()
                .id(entity.getId())
                .cargoRequestId(entity.getCargoRequest().getId())
                .carrierId(entity.getCarrier().getId())
                .carrierName(entity.getCarrier().getName())
                .proposedPrice(entity.getProposedPrice())
                .message(entity.getMessage())
                .status(entity.getStatus())
                .createdAt(entity.getCreatedAt())
                .build();
    }
}
