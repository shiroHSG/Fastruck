package com.deal.Fastruck.repository;

import com.deal.Fastruck.entity.Contract;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.entity.Review;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Long> {
    boolean existsByContractAndWriter(Contract contract, Member writer);

    List<Review> findByWriter(Member writer);

    List<Review> findByReceiver(Member receiver);

    List<Review> findByReceiverId(Long receiverId);
}
