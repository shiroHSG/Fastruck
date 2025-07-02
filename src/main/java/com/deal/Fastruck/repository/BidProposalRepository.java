package com.deal.Fastruck.repository;

import com.deal.Fastruck.entity.BidProposal;
import com.deal.Fastruck.entity.BidStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BidProposalRepository extends JpaRepository<BidProposal, Long> {
    // 특정 화물요청글의 입찰 리스트 (화주가 입찰 현황 볼 때)
    List<BidProposal> findByCargoRequest_Id(Long cargoRequestId);

    // 내가(차주) 입찰한 모든 입찰 (내 입찰 내역/관리)
    List<BidProposal> findByCarrier_Id(Long carrierId);

    // 내가 입찰한 것 중 상태별(대기/수락/거절)
    List<BidProposal> findByCarrier_IdAndStatus(Long carrierId, BidStatus status);

    // (확장) 한 사람이 한 요청글에 여러 번 입찰하는 걸 막고 싶으면
    boolean existsByCargoRequest_IdAndCarrier_Id(Long cargoRequestId, Long carrierId);
}
