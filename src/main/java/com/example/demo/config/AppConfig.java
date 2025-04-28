package com.example.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import com.example.demo.repository.UserRepository;
import com.example.demo.service.UserService;


@Configuration
@ComponentScan(basePackages = "com.example.demo..config")
public class AppConfig {
    
}
