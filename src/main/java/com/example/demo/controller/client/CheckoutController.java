package com.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class CheckoutController {
    @GetMapping("cart/checkout")
    public String getMethodName() {
        return "client/cart/checkout";
    }
    
}
