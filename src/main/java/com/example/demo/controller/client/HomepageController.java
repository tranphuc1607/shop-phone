package com.example.demo.controller.client;

import java.sql.SQLException;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.entity.User;
import com.example.demo.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;


@Controller
public class HomepageController {
    private final UserService userService;

    public HomepageController(UserService userService ){
        this.userService = userService;
    }

    @GetMapping("/homepage")
    public String getHomePage() {
        return "client/home/interface";
    }
    @GetMapping("/")
    public String getHome() {
        return "client/home/interface";
    }

   
    @GetMapping("/account/change-password")
    public String showChangePasswordForm() {
        return "client/home/changePassword"; // trả về trang đổi mật khẩu
    }

    @PostMapping("/account/change-password")
    public String changePassword(@RequestParam("oldPassword") String oldPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmNewPassword") String confirmNewPassword,
                                 Model model) {
        // Kiểm tra nếu mật khẩu mới và xác nhận mật khẩu không khớp
        if (!newPassword.equals(confirmNewPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp.");
            return "client/home/changePassword"; // trả lại trang đổi mật khẩu
        }

        // Gọi service để xử lý việc đổi mật khẩu
        try {
            boolean isChanged = this.userService.changePassword(oldPassword, newPassword);
            // System.out.println(isChanged);       
            if (isChanged) {
                return "redirect:/";
            } else {
                model.addAttribute("error1", "Mật khẩu cũ không chính xác.");
                return "client/home/changePassword";
            }
        } catch (Exception e) {
            model.addAttribute("error2", "Đã có lỗi xảy ra. Vui lòng thử lại.");
            return "client/home/changePassword";
        }
    }

}
