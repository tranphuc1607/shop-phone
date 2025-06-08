package com.example.demo.controller.client;

import java.sql.SQLException;
//import java.util.List;
import java.util.List;

//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
//import org.springframework.validation.BindingResult;
//import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.entity.Product;
import com.example.demo.entity.User;
//import com.example.demo.entity.User;
import com.example.demo.service.ProductService;
import com.example.demo.service.UserService;

//import jakarta.servlet.http.HttpSession;
//import jakarta.validation.Valid;


@Controller
public class HomepageController {
    private final UserService userService;
    private final ProductService productService;

    public HomepageController(UserService userService,ProductService productService ){
        this.userService = userService;
        this.productService = productService;
    }

    @GetMapping("/homepage")
    public String getHomePage(@RequestParam(defaultValue = "1") int page,
                                @RequestParam(defaultValue = "10") int size,
                            Model model) throws SQLException {
        List<Product> products = this.productService.getProductsByPage(page, size);
        long totalProducts = this.productService.getTotalProductCount();
        int totalPages = (int) Math.ceil((double) totalProducts / size);

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("size", size);
        return "client/home/interface";
    }
    @GetMapping("/")
    public String getHome(@RequestParam(defaultValue = "1") int page,
                                @RequestParam(defaultValue = "10") int size,
                            Model model) throws SQLException {
        List<Product> products = this.productService.getProductsByPage(page, size);
        long totalProducts = this.productService.getTotalProductCount();
        int totalPages = (int) Math.ceil((double) totalProducts / size);

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("size", size);
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
