package com.example.demo.controller.client;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
// import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
//import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.demo.entity.User;
import com.example.demo.service.UserService;

@Controller
public class RegisterController {
    @Autowired
	private UserService userService;

	@GetMapping("/register")
	public String showRegisterUserForm(Model model) {
		model.addAttribute("user", new User());
		return "client/auth/register";
	}
	
	@PostMapping("/register")
	public String registerUser(@ModelAttribute("user") User user, Model model) {
		user.setCreatedAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		user.setRole("USER");
		String encodedPassword = new BCryptPasswordEncoder().encode(user.getPassword());
        user.setPassword(encodedPassword);
        try {
        	userService.saveUser(user);
        } catch (SQLException e) {
        	model.addAttribute("error", "Đã xảy ra lỗi khi tạo tài khoản. Vui lòng thử lại!");
        	model.addAttribute("user", user); // giữ lại dữ liệu người dùng đã nhập
    		return "client/Authen/userRegister"; // quay lại form với thông báo
        }
		return "redirect:/login";
	}
}
