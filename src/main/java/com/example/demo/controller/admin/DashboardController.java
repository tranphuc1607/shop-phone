package com.example.demo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {
    @GetMapping("admin/dashboard")
    public String getOrder() {
        return "admin/dashboard/showInterface";
    }
}
