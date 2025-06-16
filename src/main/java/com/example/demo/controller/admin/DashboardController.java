package com.example.demo.controller.admin;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.entity.Order;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.OrderService;
import com.example.demo.service.UserService;


@Controller
public class DashboardController {
    	private UserService userService;
        private OrderService orderService;
        private UserRepository  userRepository;

        public DashboardController(UserService userService,OrderService orderService,UserRepository  userRepository) {
            this.userService = userService;
            this.orderService =orderService;
            this.userRepository = userRepository;
        }

   @GetMapping("admin/dashboard")
public String getDashboard(@RequestParam(defaultValue = "1") int page,
                           @RequestParam(defaultValue = "5") int size,
                           Model model) {
    try {
        List<Order> allOrder = this.orderService.getOrder(null, page, size);
        model.addAttribute("orders", allOrder);

        long totalOrder = this.orderService.getTotalProductCount("");
        int totalPages = (int) Math.ceil((double) totalOrder / size);

        BigDecimal sum = this.orderService.sum();
        int countVisit = this.orderService.getVisitCountLast30Days();

        model.addAttribute("sum", sum);
        model.addAttribute("countVisit", countVisit);
        model.addAttribute("totalOrder", totalOrder);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("size", size);
    } catch (SQLException e) {
        e.printStackTrace();
        model.addAttribute("orders", Collections.emptyList());
        model.addAttribute("sum", BigDecimal.ZERO);
        model.addAttribute("countVisit", 0);
        model.addAttribute("totalOrder", 0);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", 0);
        model.addAttribute("size", size);
    }

    int totalCurrentUser = this.userService.getTotalUsers();
    int totalUsersLastSunday = this.userService.getTotalUsersLastSunday();
    model.addAttribute("totalCurrentUser", totalCurrentUser);

    // Tránh chia 0
    double growthRate = totalCurrentUser == 0 ? 0 : ((double)(totalCurrentUser - totalUsersLastSunday) / totalCurrentUser) * 100;
    model.addAttribute("getTotalUsersLastSunday", growthRate);

    return "admin/dashboard/showInterface";
}




}
