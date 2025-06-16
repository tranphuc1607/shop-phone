package com.example.demo.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.RequestParam;

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
    
}
