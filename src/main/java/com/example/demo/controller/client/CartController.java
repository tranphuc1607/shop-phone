package com.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CartController {
    @GetMapping("/homepage/order")
    public String getOrder() {
        return "client/order/interface";
    }
}
