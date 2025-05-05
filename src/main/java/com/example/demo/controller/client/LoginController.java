package com.example.demo.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
//import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
//import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.entity.User;
import com.example.demo.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
@Controller
public class LoginController {
    @Autowired
    private AuthenticationManager authenticationManager;
	@Autowired
	private UserService userService;
    @GetMapping("/login")
    public String showLoginForm() {
        return "client/auth/login"; 
    }
    
    @PostMapping("/login")
    public String processLogin(HttpServletRequest request,
                                @RequestParam("username") String email,
                                @RequestParam("password") String password,
                                Model model) {
        try {
            Authentication auth = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(email, password)
            );
            // Đăng nhập thành công -> lưu vào session
            SecurityContextHolder.getContext().setAuthentication(auth);
            request.getSession().setAttribute(
                HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY,
                SecurityContextHolder.getContext()
            );
            
            
            
            try {
            	User user = userService.getUserByEmail(email);
            	if (user != null ) {
            		if (user.getRole().equals("ADMIN")) {
            			return "redirect:/admin/dashboard";
            		} else {
                        return "redirect:/homepage";
            		}
            	} else {
            		model.addAttribute("EmailError", "Có lỗi xảy ra, không thể xác định tài khoản.");
            	}
            } catch (Exception e) {
            	model.addAttribute("SystemError", "Có lỗi hệ thống");
            }
            return "client/auth/login";
        } catch (AuthenticationException e) {
            model.addAttribute("AuthenError", "Email hoặc mật khẩu không đúng");
            return "client/auth/login";
        }
    }
}
