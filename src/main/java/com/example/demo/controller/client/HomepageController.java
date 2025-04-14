package com.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomepageController {
    @GetMapping("/homepage")
    public String getHomePage() {
        return "client/home/interface";
    }
}
