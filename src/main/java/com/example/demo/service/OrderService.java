package com.example.demo.service;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.demo.entity.User;
import com.example.demo.entity.Order;
//import com.example.demo.entity.Order;
import com.example.demo.entity.DTO.CartItemViewDTO;
import com.example.demo.repository.CartRepository;
import com.example.demo.repository.OrderRepository;

@Service
public class OrderService {

    @Autowired OrderRepository orderRepository;
    @Autowired CartRepository cartRepository;

    public boolean createOrder( int userId,  String userName, String userEmail, String userPhone, String userAddress, String paymentMethod, BigDecimal totalAmount , List<CartItemViewDTO> cartItems) {
        if (userId == 0 || cartItems.size() == 0) {
            throw new IllegalArgumentException("Invalid order details provided");
        } else if (cartItems.size() > 100) {
            throw new IllegalArgumentException("Too many items in the order");
        } else{
            // Create the order
            int orderId = orderRepository.createOrder(userId, userName, userEmail, userPhone, userAddress, paymentMethod, totalAmount);
            if (orderId <= 0) {
                throw new RuntimeException("Failed to create order");
            }
            // Create order items
            boolean itemsCreated = orderRepository.createOrderItems(orderId, cartItems);
            if (!itemsCreated) {
                throw new RuntimeException("Failed to create order items");
            } else {
                List<Integer> cartItemIds = new ArrayList<>();
                for (CartItemViewDTO item : cartItems) {
                    cartItemIds.add(item.getCartItemId());
                }
                try {
                    cartRepository.clearCart(cartItemIds); // Clear the cart items after successful order creation
                } catch (Exception e) {
                    throw new RuntimeException("Failed to clear cart: " + e.getMessage(), e);
                }
            }
        }
        return true; // Return true if order creation is successful
    }
    public List<Order> getOrder(String status,int page,int size) throws SQLException {
        return this.orderRepository.getOrders(status,page,size);
    }
    public Order getOrderById(int id) throws SQLException {
       return this.orderRepository.getOrder(id);
    }

     public long getTotalProductCount(String status) throws SQLException {
        return this.orderRepository.countOrders(status);
    }
    public List<Order> getOrdersByUser(User user) {
        if (user == null || user.getId() == null) {
            throw new IllegalArgumentException("Invalid user provided");
        }
        return orderRepository.getOrdersByUser(user);
    }
    public void cancelOrder(int orderId) throws SQLException {
        if (orderId <= 0) {
            throw new IllegalArgumentException("Invalid order ID provided");
        }
        orderRepository.cancelOrder(orderId);
    }
}
