package com.example.demo.controller.admin;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.entity.User;
import com.example.demo.service.UserFindAllService;

@Controller
public class UserController {

	private final UserFindAllService userFindAllService;
    
    
    public UserController(UserFindAllService userFindAllService) {
        this.userFindAllService = userFindAllService;
    }

    @GetMapping("/admin/user")
    public String getAllUser(Model model) throws SQLException {
    	List<User> users = userFindAllService.getAllUser();
    	model.addAttribute("users", users);
        return "admin/user/users";
    }


    
}
