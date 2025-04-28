package com.example.demo.controller.admin;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.example.demo.entity.User;
import com.example.demo.service.UserService;

@Controller
public class UserController {

	private final UserService userService;
    
    
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/admin/showUsers")
    public String getAllUser(Model model) throws SQLException {
    	List<User> users = userService.getAllUser();
    	model.addAttribute("users", users);
        return "admin/user/users";
    }
    @GetMapping("admin/user")
    public String getSaveUser(Model model) {
        model.addAttribute("user",new User());
        return "hdhfhdhdhfhd";
    }

    // @PostMapping("/admin/user/add") {
    //     public String getAddUser(@ModelAttribute User user, Model model) {
    //         try {
    //             userService.addUser(user);
    //             model.addAttribute("message", "User saved successfully.");
    //             return "redirect:/users/form";
    //         } catch (Exception e) {
    //             model.addAttribute("message", "Error saving user.");
    //             return "";
    //         }
    //     }
    // }

    
    
}
