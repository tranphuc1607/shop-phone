package com.example.demo.controller.client;

//import java.util.List;

//import org.hibernate.annotations.Check;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.entity.User;
//import com.example.demo.entity.DTO.CartItemViewDTO;
import com.example.demo.entity.DTO.CheckoutDTO;
import com.example.demo.service.CheckoutService;

import org.springframework.ui.Model;


@Controller
public class CheckoutController {

    @Autowired
    private CheckoutService checkoutService;

    @PostMapping("cart/checkout")
    public String getMethodName(@ModelAttribute("currentUser") User user,
                                //@RequestParam List<CartItemViewDTO> cartItems,
                                Model model
                                )
    {
        CheckoutDTO checkoutDTO = checkoutService.createCheckoutDTO(user);
        if (checkoutDTO == null || checkoutDTO.getCartItems().isEmpty()) {
            model.addAttribute("error", "Giỏ hàng trống hoặc không thể tạo thông tin đặt hàng.");
            return "client/cart/checkout"; // Redirect to the checkout page with an error message
        }
        model.addAttribute("checkoutDTO", checkoutDTO);
        
        return "client/cart/checkout";
    }
    
    @PostMapping("cart/checkout/confirm")
    public String confirmCheckout(@ModelAttribute CheckoutDTO checkoutDTO, Model model) {
        boolean isSuccess = checkoutService.processCheckout(checkoutDTO);
        if (isSuccess) {
            model.addAttribute("successMessage", "Đặt hàng thành công!");
            return "client/cart/success"; // Redirect to a success page
        } else {
            model.addAttribute("errorMessage", "Đặt hàng không thành công. Vui lòng thử lại.");
            return "client/cart/checkout"; // Redirect back to the checkout page with an error message
        }
        /* 
        System.out.println("==> CHECKOUT DTO: " + checkoutDTO.getUserId()
                + ", " + checkoutDTO.getUserName()
                + ", " + checkoutDTO.getUserEmail()
                + ", " + checkoutDTO.getUserPhone()
                + ", " + checkoutDTO.getUserAddress()
                + ", " + checkoutDTO.getPaymentMethod()
                + ", " + checkoutDTO.getTotalAmount()
                + ", " + checkoutDTO.getCartItems().size());

        return "client/cart/checkout";*/
    }

}
