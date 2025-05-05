package com.example.demo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class OrderController {
    @GetMapping("admin/order/all")
    public String getOrder() {
        return "admin/order/allOrder";
    }

    @GetMapping("admin/order/unconfirmed")
    public String getOrderUnconfirmed () {
        return "admin/order/unconfirmedOrder";
    }
    @GetMapping("admin/order/comfirmed")
    public String getOrderconfirmeded () {
        return "admin/order/orderConfirmed";
    }
    @GetMapping("admin/order/processed")
    public String getOrderProcessed () {
        return "admin/order/unconfirmedOrder";
    }
    @GetMapping("admin/order/complete")
    public String  getOrderComplete () {
        return "admin/order/orderComplete";
    }
}
