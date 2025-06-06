package com.example.demo.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

//import com.example.demo.entity.Order;
import com.example.demo.entity.User;
import com.example.demo.entity.DTO.CartItemViewDTO;
import com.example.demo.entity.DTO.CheckoutDTO;

@Service
public class CheckoutService {
    
    @Autowired
    private CartService cartService;
    @Autowired OrderService orderService;
    @Autowired ProductService productService;

    public CheckoutDTO createCheckoutDTO(User user){
        try {
            List<CartItemViewDTO> cartItems = cartService.getCartItemsForUser(user.getId());
            return new CheckoutDTO(user, cartItems);
        } catch (Exception e) {
            throw new RuntimeException("Không thể tạo thông tin đặt hàng: " + e.getMessage(), e);
        }
    };
    public boolean processCheckout(CheckoutDTO checkoutDTO) {
        orderService.createOrder(
            checkoutDTO.getUserId(),
            checkoutDTO.getUserName(),
            checkoutDTO.getUserEmail(),
            checkoutDTO.getUserPhone(),
            checkoutDTO.getUserAddress(),
            checkoutDTO.getPaymentMethod(),
            checkoutDTO.getTotalAmount(),
            checkoutDTO.getCartItems()
        );
        for (CartItemViewDTO item : checkoutDTO.getCartItems()) {
            if (item.getQuantity() <= 0) {
                throw new IllegalArgumentException("Số lượng sản phẩm phải lớn hơn 0");
            } else{
                // Kiểm tra xem sản phẩm có tồn tại trong kho không
                try{
                    productService.handleUpdateProductQuantity(item.getProductId(), item.getQuantity());
                } catch (Exception e) {
                    throw new RuntimeException("Không thể cập nhật số lượng sản phẩm: " + e.getMessage(), e);
                }
            }
        }
        return true;
    }

    
}
