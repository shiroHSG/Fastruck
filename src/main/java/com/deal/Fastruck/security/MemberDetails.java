package com.deal.Fastruck.security;

import com.deal.Fastruck.entity.Member;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;

public class MemberDetails implements UserDetails {
    private final Member member;

    public MemberDetails(Member member) {
        this.member = member;
    }

    // 프로젝트 내에서 로그인 사용자의 id를 꺼낼 때 사용
    public Long getId() {
        return member.getId();
    }

    public Member getMember() {
        return member;
    }

    // 권한 정보 (추후 Role 기반으로 커스텀 가능)
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // 만약 권한이 필요하면 여기서 member.getRole()을 변환해서 넘기면 됨
        return null;
    }

    @Override
    public String getPassword() {
        return member.getPassword();
    }

    @Override
    public String getUsername() {
        return member.getEmail(); // 로그인 아이디(email) 기준
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
