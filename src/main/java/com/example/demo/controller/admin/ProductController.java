package com.example.demo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class ProductController {
    @GetMapping("")
    public String getMethodName(@RequestParam String param) {
        return new String();
    }
    
}
