package com.example.demo.controller.admin;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RequestParam;
//iimport org.springframework.web.multipart.MultipartFile;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.entity.Product;
import com.example.demo.entity.User;
import com.example.demo.service.UserService;

import jakarta.validation.Valid;

@Controller
public class UserController {

	private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    
    
    public UserController(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/admin/user")
    public String getAllUser(@RequestParam(defaultValue = "1") int page,
                            @RequestParam(defaultValue = "5") int size,
                            Model model) throws SQLException {
    	List<User> users = this.userService.getUsersByPage(page, size);
        long totalUser = this.userService.getTotalUserCount();
        int totalPages = (int) Math.ceil((double) totalUser / size);

        model.addAttribute("users", users);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("size", size);
        return "admin/user/showInterface";
    }

        @GetMapping("/admin/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @PostMapping("/admin/user/create")
    public String getCCreateUser(Model model, @ModelAttribute(name = "newUser") @Valid User newUser,
            BindingResult newUserBindingResult) throws SQLException {
                // String hashPassword = this.passwordEncoder.encode(newUser.getPasswordHash());
        List<FieldError> errList = newUserBindingResult.getFieldErrors();
        for (FieldError err : errList) {
            System.out.println(err.getField() + " -- " + err.getDefaultMessage());
        }

        if (newUserBindingResult.hasErrors()) {
            return "admin/user/create";
        } else {
            String hashedPassword = this.passwordEncoder.encode(newUser.getPassword());
            newUser.setPassword(hashedPassword);
           LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedNow = now.format(formatter);
            newUser.setCreatedAt(formattedNow);
            this.userService.saveUser(newUser);
        }
        return "redirect:/admin/user";
    }
    @GetMapping("/admin/user/{id}")
    public String getDetailUser(Model model, @PathVariable int id) throws SQLException {
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        model.addAttribute("id", id);
        return "admin/user/detail";
    }

    @GetMapping("/admin/user/update/{id}")
    public String getUserUpdatePage(Model model, @PathVariable int id) throws SQLException {
        // Lấy thông tin người dùng từ ID
        User currentUser = userService.getUserById(id);
        
        // Thêm đối tượng user vào model để hiển thị trên trang update
        model.addAttribute("currentUser", currentUser);
        
        // Trả về trang cập nhật (update.jsp)
        return "admin/user/update";
    }

    // Cập nhật người dùng
    @PostMapping("/admin/user/update")
    public String updateUser(@ModelAttribute("currentUser") User currentUser, RedirectAttributes redirectAttributes) throws SQLException {
        try {
            // Kiểm tra xem email có bị trùng trong hệ thống không
            if (userService.isEmailExist(currentUser.getEmail(), currentUser.getId())) {
                // Nếu trùng email, trả về thông báo lỗi và quay lại trang update
                redirectAttributes.addFlashAttribute("errorMessage", "Email already exists.");
                return "redirect:/admin/user/update/" + currentUser.getId();
            }
            String encodedPassword = this.passwordEncoder.encode(currentUser.getPassword());
            currentUser.setPassword(encodedPassword);
            // Cập nhật thông tin người dùng
            userService.updateUser(currentUser);
            
            // Thêm thông báo thành công
            redirectAttributes.addFlashAttribute("successMessage", "User updated successfully!");
            
            // Chuyển hướng về trang danh sách người dùng sau khi cập nhật thành công
            return "redirect:/admin/user";
        } catch (SQLException e) {
            // Nếu có lỗi xảy ra, trả về thông báo lỗi
            redirectAttributes.addFlashAttribute("errorMessage", "An error occurred while updating user.");
            return "redirect:/admin/user/update/" + currentUser.getId();
        }
    }


    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(RedirectAttributes redirectAttributes, @PathVariable int id) throws SQLException {
        this.userService.deleteUser(id);
	    redirectAttributes.addFlashAttribute("success", "Xóa thành công!");
	    return "redirect:/admin/user";
    }
/*
    @PostMapping("/admin/user/delete")
    public String deleteUser(@ModelAttribute User currentUser) throws SQLException {
        this.userService.deleteUser(currentUser.getId());
        return "redirect:/admin/user";
    } */
}
