package com.example.demo.controller.client;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.entity.Product;
//import com.example.demo.entity.CartItem;
import com.example.demo.entity.User;
import com.example.demo.entity.DTO.CartItemViewDTO;
import com.example.demo.service.CartService;
import com.example.demo.service.ProductService;

import org.springframework.ui.Model;

@Controller
public class CartController {
     @Autowired
    private CartService cartService;
    @Autowired
    private ProductService productService;
    
    @GetMapping("/homepage/cart")
    public String viewCart(@ModelAttribute("currentUser") User user,Model model) {
        if (user == null) {
            return "redirect:/login"; // Redirect to login if user is not authenticated
        }
         try {
            List<CartItemViewDTO> cartItems = cartService.getCartItemsForUser(user.getId());
            model.addAttribute("cartItems", cartItems);
        } catch (Exception e) {
            model.addAttribute("error", "Không thể lấy giỏ hàng.");
        }

        return "client/cart/interface";
    }

    @PostMapping("/cart/add/{productId}")
    public String addToCart(@PathVariable Long productId,
                            @RequestParam int quantity,
                            Model model,
                            @ModelAttribute("currentUser") User user) {
        // Lấy user, thêm vào giỏ hàng
        cartService.addItemToCart(productId, quantity, user);
        return "redirect:/product"; // Redirect to products page after adding to cart
    }
    @PostMapping("/cart/delete/{cartItemId}")
    public String deleteCartItem(@PathVariable int cartItemId, Model model) {
        // Logic to delete the cart item by cartItemId
        // You would typically call a service method to handle this
        // cartService.deleteCartItem(cartItemId, user.getId());
        cartService.deleteCartItem(cartItemId, 1); // Assuming user ID is 1 for demonstration purposes
        model.addAttribute("message", "Item deleted successfully");
        return "redirect:/homepage/cart"; // Redirect back to the cart page after deletion
    }
    @PostMapping("/cart/cartItem/detail/{cartItemId}")
    public String viewCartItemDetail(@PathVariable int cartItemId,
                                     @RequestParam int quantity,
                                     Model model) {
        try {
            Product product = cartService.getProductByCartItemID(cartItemId);
            if (product == null) {
                model.addAttribute("error", "Không tìm thấy sản phẩm");
                return "redirect:/homepage/cart"; // Redirect to cart if product not found
            } else {
                model.addAttribute("product", product);
                model.addAttribute("quantityBeforeUpdate", quantity);
                model.addAttribute("cartItemId", cartItemId);
            }
            
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi lấy thông tin sản phẩm: " + e.getMessage());
            return "redirect:/homepage/cart";
        }

        return "client/detailProduct/addToCart";
    }
    @PostMapping("/cart/updateItemCart/{cartItemId}")
    public String updateCartItem(@PathVariable int cartItemId,
                                 @RequestParam int quantity,
                                 Model model) {
        cartService.updateCartItem(cartItemId, quantity);
        model.addAttribute("message", "Item updated successfully");
        return "redirect:/homepage/cart"; // Redirect back to the cart page after updating
    }
}
