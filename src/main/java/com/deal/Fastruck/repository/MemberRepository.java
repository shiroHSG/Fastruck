package com.deal.Fastruck.repository;

import com.deal.Fastruck.entity.Member;
import com.deal.Fastruck.entity.enums.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long> {
    Optional<Member> findByEmail(String email);
    boolean existsByEmail(String email);

    @Query("SELECT COUNT(m) FROM Member m WHERE m.role = :role AND YEAR(m.createdAt) = :year")
    long countByRoleAndYear(@Param("role") Role role, @Param("year") int year);
}
