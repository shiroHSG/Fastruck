package com.deal.Fastruck.repository;

import com.deal.Fastruck.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long> {
    Optional<Member> findByEmail(String email);
    // 회원가입/로그인/권한체크 등에 사용
}
