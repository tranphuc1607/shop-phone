package com.example.demo.controller.admin;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.example.demo.entity.Order;
import com.example.demo.service.OrderService;


@Controller
public class OrderController {
    private OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }
    @GetMapping("admin/order/all")
    public String getOrder(Model model) throws SQLException {
        List<Order> allOrder = this.orderService.getAllOrder();
        
        model.addAttribute("orders",allOrder);
        return "admin/order/AllOrder/allOrder";
    }

    @GetMapping("/admin/order/{id}")
    public String getDetailOrder(Model model ,@PathVariable("id") int id) throws SQLException {
        Order order  = this.orderService.getOrderById(id);
        model.addAttribute("order", order);
        System.out.println(order);
        return "admin/order/AllOrder/view";
    
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
