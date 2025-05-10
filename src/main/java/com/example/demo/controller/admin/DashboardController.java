package com.example.demo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.service.UserService;


@Controller
public class DashboardController {
    	private UserService userService = null;

        public DashboardController(UserService userService) {
            this.userService = userService;
        }

    @GetMapping("admin/dashboard")
    public String getDashboard(Model model) {
        int totalCurrentUser = this.userService.getTotalUsers();
        int totalUsersLastSunday =this.userService.getTotalUsersLastSunday();
        model.addAttribute("totalCurrentUser",totalCurrentUser);
        model.addAttribute("getTotalUsersLastSunday",((totalCurrentUser-totalUsersLastSunday)/totalCurrentUser)*(100));
        return "admin/dashboard/showInterface";
    }

    @GetMapping("admin")
    public String getDashBoardPage(Model model) {
        int totalCurrentUser = this.userService.getTotalUsers();
        int totalUsersLastSunday =this.userService.getTotalUsersLastSunday();
        model.addAttribute("totalCurrentUser",totalCurrentUser);
        model.addAttribute("getTotalUsersLastSunday",((totalCurrentUser-totalUsersLastSunday)/totalCurrentUser)*(100));
        return "admin/dashboard/showInterface";
    }
}
