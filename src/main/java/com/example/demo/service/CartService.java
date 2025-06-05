package com.example.demo.service;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.Cart;
import com.example.demo.entity.User;
//import com.example.demo.entity.CartItem;
import com.example.demo.entity.DTO.CartItemViewDTO;
import com.example.demo.repository.CartItemRepository;
import com.example.demo.repository.CartRepository;

@Service
public class CartService {
    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartItemRepository cartItemRepository;

    public boolean crateNewCart(User user) throws SQLException {
        // Check if a cart already exists for the user
        Cart existingCart = cartRepository.findByUserId(user.getId());
        if (existingCart != null) {
            return false; // Cart already exists, no need to create a new one
        }

        // Create a new cart for the user
        Cart newCart = new Cart();
        newCart.setUser(user);
        newCart.setCreatedAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))); 
        // Set other properties as needed, e.g., createdAt
        cartRepository.save(newCart); // Assuming save method exists in CartRepository
        return true;
    }

    public List<CartItemViewDTO> getCartItemsForUser(int userId) throws SQLException {
        Cart cart = cartRepository.findByUserId(userId);

        if (cart == null) return Collections.emptyList();

        return cartItemRepository.findAllByCartId(cart.getId());
    }

    public void addItemToCart(Long productId, int quantity, User user) {
        try {
           cartItemRepository.addItemToCart(productId, quantity, user.getId());
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception (e.g., log it, rethrow it, etc.)
        }
    }
    public void deleteCartItem(int cartItemId, int userId) {
        try {
            cartItemRepository.deleteCartItem(cartItemId);
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception (e.g., log it, rethrow it, etc.)
        }
    }
}
