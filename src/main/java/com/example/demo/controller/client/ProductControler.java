package com.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductControler {
    @GetMapping("/product")
    public String getProduct() {
        return "client/product/interface";
    }

     @GetMapping("/product/detail")
     public String getProductDetail() {
        return "client/detailProduct/detailProduct";
     }
}
