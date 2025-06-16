package com.example.demo.controller.client;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestParam;

//import com.example.demo.entity.Order;
import com.example.demo.entity.User;
import com.example.demo.service.OrderService;


@Controller
public class ClientOrderController {

    @Autowired OrderService orderService;

    @GetMapping("order/order-list")
    public String getMethodName(@ModelAttribute("currentUser") User user,
                                Model model) {
        if (user == null || user.getId() == null) {
            model.addAttribute("error", "User not found or not logged in.");
            return "client/error"; // Redirect to an error page
        } else {
            // Fetch orders for the user
            model.addAttribute("orders", orderService.getOrdersByUser(user));
            return "client/order/list"; // Redirect to the order list page
        }
    }
    @GetMapping("/order_his/detail")
    public String getOrderDetail(@ModelAttribute("currentUser") User user,
                                @RequestParam("id") int orderId,
                                Model model) {
        if (user == null || user.getId() == null) {
            model.addAttribute("error", "User not found or not logged in.");
            return "client/error";
        } else {
            try {
                model.addAttribute("order", orderService.getOrderById(orderId));
            } catch (SQLException e) {
                e.printStackTrace();
                model.addAttribute("error", "Có lỗi xảy ra khi lấy thông tin đơn hàng.");
                return "client/error";
            }
            return "client/order/detail";
        }
    }
    @PostMapping("/order_his/cancel")
    public String cancelOrder(@ModelAttribute("currentUser") User user,
                              @RequestParam("orderId") int orderId,
                              Model model) {
        if (user == null || user.getId() == null) {
            model.addAttribute("error", "User not found or not logged in.");
            return "client/error";
        } else {
            try {
                orderService.cancelOrder(orderId);
                model.addAttribute("message", "Đơn hàng đã được hủy thành công.");
            } catch (SQLException e) {
                e.printStackTrace();
                model.addAttribute("error", "Có lỗi xảy ra khi hủy đơn hàng.");
                return "client/error";
            }
            return "redirect:/order/order-list"; // Redirect to the order list page
        }
    }
    
}
