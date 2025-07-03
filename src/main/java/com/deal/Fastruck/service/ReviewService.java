package com.deal.Fastruck.service;

import com.deal.Fastruck.dto.ReviewRequestDto;
import com.deal.Fastruck.dto.ReviewResponseDto;
import com.deal.Fastruck.entity.Contract;
import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.entity.Review;
import com.deal.Fastruck.repository.ContractRepository;
import com.deal.Fastruck.repository.MemberRepository;
import com.deal.Fastruck.repository.ReviewRepository;
import jakarta.persistence.EntityNotFoundException;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ReviewService {


    private final ContractRepository contractRepository;
    private final MemberRepository memberRepository;
    private final ReviewRepository reviewRepository;

    @Transactional
    public void createReview(Long contractId, ReviewRequestDto dto, Member writer) {
        Contract contract = contractRepository.findById(contractId)
                .orElseThrow(() -> new EntityNotFoundException("계약이 존재하지 않습니다."));

        Member receiver = memberRepository.findById(dto.getReceiverId())
                .orElseThrow(() -> new EntityNotFoundException("리뷰 대상 회원이 존재하지 않습니다."));

        // 이미 작성된 리뷰인지 확인
        boolean alreadyReviewed = reviewRepository.existsByContractAndWriter(contract, writer);
        if (alreadyReviewed) {
            throw new IllegalStateException("이미 리뷰를 작성한 계약입니다.");
        }

        Review review = Review.builder()
                .contract(contract)
                .writer(writer)
                .receiver(receiver)
                .rating(dto.getRating())
                .comment(dto.getComment())
                .build();

        reviewRepository.save(review);
    }

    // 내가 작성한 리뷰리스트 조회
    @Transactional(readOnly = true)
    public List<ReviewResponseDto> getReviewsByWriter(Member writer) {
        List<Review> reviews = reviewRepository.findByWriter(writer);
        return reviews.stream()
                .map(ReviewResponseDto::from)
                .collect(Collectors.toList());
    }

    // 리뷰를 받은 대상 id를 기반으로 리뷰 리스트 조회
    @Transactional(readOnly = true)
    public List<ReviewResponseDto> getReviewsForMember(Long receiverId) {
        Member receiver = memberRepository.findById(receiverId)
                .orElseThrow(() -> new EntityNotFoundException("회원이 존재하지 않습니다."));

        List<Review> reviews = reviewRepository.findByReceiver(receiver);
        return reviews.stream()
                .map(ReviewResponseDto::from)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public ReviewResponseDto getReviewDetail(Long reviewId) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new EntityNotFoundException("리뷰를 찾을 수 없습니다."));
        return ReviewResponseDto.from(review);
    }
}
