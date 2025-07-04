package com.deal.Fastruck.repository;

import com.deal.Fastruck.entity.Contract;
import com.deal.Fastruck.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ContractRepository extends JpaRepository<Contract, Long> {

    Optional<Contract> findByBidProposalId(Long bidProposalId);
}
