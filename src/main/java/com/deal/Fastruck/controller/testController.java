package com.deal.Fastruck.controller;

import org.apache.coyote.Response;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/test")
public class testController {
    @GetMapping
    public ResponseEntity<?> test() {
        return ResponseEntity.ok(Map.of("message", "api 연결"));
    }
}
