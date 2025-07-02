package com.deal.Fastruck.config;

import java.util.List;

public class SecurityConstants {

    public static final List<String> ALLOWED_URLS = List.of(
            "/api/member/login",
            "/api/member/register"
    );
}