package com.example.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.repository.VisitLogRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class VisitLoggerInterceptor implements HandlerInterceptor {
    @Autowired
    private VisitLogRepository visitLogRepository;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        String ip = request.getRemoteAddr();
        String userAgent = request.getHeader("User-Agent");
        visitLogRepository.saveVisit(ip, userAgent);
        return true;
    }
}
