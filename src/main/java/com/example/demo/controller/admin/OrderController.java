package com.example.demo.controller.admin;

import java.sql.SQLException;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.entity.Order;
import com.example.demo.entity.Product;
import com.example.demo.service.OrderService;


@Controller
public class OrderController {
    private OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }
    @GetMapping("admin/order/all")
    public String getOrder( @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "4") int size,
            Model model) throws SQLException {
        List<Order> allOrder = this.orderService.getOrder(null,page,size);
        
        model.addAttribute("orders",allOrder);

        long totalProducts = this.orderService.getTotalProductCount("");
        int totalPages = (int) Math.ceil((double) totalProducts / size);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("size", size);
        return "admin/order/allOrder";
    }

    @GetMapping("/admin/order/{id}")
    public String getDetailOrder(Model model ,@PathVariable("id") int id) throws SQLException {
        Order order  = this.orderService.getOrderById(id);
        Date createdAtDate = Date.from(order.getOrderDate().atZone(ZoneId.systemDefault()).toInstant());

    model.addAttribute("order", order);
    model.addAttribute("createdAtDate", createdAtDate); // truyền biến mới
    return "admin/order/view";
    
    
    }

    @GetMapping("admin/order/unconfirmed")
    public String getOrderUnconfirmed (@RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "5") int size,
            Model model) throws SQLException {
        List<Order> allOrderUnconfirmed = this.orderService.getOrder("Chưa xác nhận",page,size);
        
        model.addAttribute("orders",allOrderUnconfirmed);

        long totalProducts = this.orderService.getTotalProductCount("Chưa xác nhận");
        int totalPages = (int) Math.ceil((double) totalProducts / size);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("size", size);
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
