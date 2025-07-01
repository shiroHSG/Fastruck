package com.deal.Fastruck.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    // 정적 리소스 매핑 추가
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/uploads/**")  // 사용자가 url로 접근했을때
                .addResourceLocations("file:" + System.getProperty("user.dir") + "/uploads/");  // 실제 서버의 파일 경로에서 파일을 찾도록 설정함
    }
}
