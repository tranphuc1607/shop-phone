package com.example.demo.repository;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.config.ConnectionPoolImlp;
import com.example.demo.entity.DTO.CartItemViewDTO;

@Repository
public class OrderRepository {
    public int createOrder(int userId, String userName, String userEmail, String userPhone, String userAddress, String paymentMethod, BigDecimal totalAmount) {
        String sql = "INSERT INTO orders (order_date, payment_method, shipping_address, status, total_amount, user_id) VALUES (?, ?, ?, ?, ?, ?)";
        Connection connection = null;
        PreparedStatement ps = null;
        try{
            connection = ConnectionPoolImlp.getInstance().getConnection();
            // First, check if the user exists
            ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, java.time.LocalDateTime.now().toString()); // Assuming order_date is a timestamp
            ps.setString(2, paymentMethod);
            ps.setString(3, userAddress);
            ps.setString(4, "Pending"); // Default status
            ps.setBigDecimal(5, totalAmount);
            ps.setInt(6, userId);
            ps.executeUpdate();
            connection.commit(); // Commit the transaction
            ResultSet generatedKeys = ps.getGeneratedKeys();
            
            int orderId = 0;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            } else {
                throw new RuntimeException("Failed to create order, no ID obtained.");
            }
            return orderId;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error creating order: " + e.getMessage(), e);
        } finally {
            // Close resources if necessary
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
    public boolean createOrderItems(int orderId, List<CartItemViewDTO> cartItems) {
        String sql = "INSERT INTO order_item (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        Connection connection = null;
        PreparedStatement ps = null;
        try{
            connection = ConnectionPoolImlp.getInstance().getConnection();
            ps = connection.prepareStatement(sql);
            for (CartItemViewDTO item : cartItems) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getProductId());
                ps.setInt(3, item.getQuantity());
                BigDecimal price = new BigDecimal(item.getProductPrice().replaceAll("[^\\d.]", ""));
                ps.setBigDecimal(4, price);
                ps.addBatch(); // Add to batch for efficiency
            }
            ps.executeBatch(); // Execute all inserts in one go
            connection.commit(); // Commit the transaction
            return true; // Return true if order items creation is successful
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error creating order items: " + e.getMessage(), e);
        } finally {
            // Close resources if necessary
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
