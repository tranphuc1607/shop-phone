package com.example.demo.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.config.ConnectionPoolImlp;
import com.example.demo.entity.Cart;
//import com.example.demo.entity.CartItem;
import com.example.demo.entity.User;
//import com.example.demo.entity.DTO.CartItemViewDTO;

@Repository
public class CartRepository {
    public Cart findByUserId(int userId) throws SQLException{
        // Simulate a database call to find a cart by user ID
        // In a real application, this would involve querying the database
        
        // For demonstration purposes, return a dummy Cart object
        Cart cart = new Cart();
        String sql_cart = "SELECT * FROM cart WHERE user_id = ?";
        String sql_user = "SELECT * FROM users WHERE id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            connection = ConnectionPoolImlp.getInstance().getConnection();
            // First, check if the user exists
            ps = connection.prepareStatement(sql_user);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            User user = new User();
            if (!rs.next()) {
                throw new SQLException("User not found with ID: " + userId);
            } else {
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                // Set other user properties as needed
            }
            ps = connection.prepareStatement(sql_cart);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                cart.setCreatedAt(rs.getString("created_at"));
                cart.setId(rs.getInt("id"));
                cart.setUser(user);
            }
            else {
                cart = null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error retrieving cart for user ID: " + userId, e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        return cart;
    }
     
    public Cart save(Cart cart) throws SQLException {
        // Simulate saving the cart to the database
        // In a real application, this would involve executing an INSERT or UPDATE SQL statement
        
        // For demonstration purposes, return the same Cart object
        String sql = "INSERT INTO cart (user_id, created_at) VALUES (?, ?)";
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = ConnectionPoolImlp.getInstance().getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, cart.getUser().getId());
            ps.setString(2, cart.getCreatedAt());
            ps.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error saving cart for user ID: " + cart.getUser().getId(), e);
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        return cart;
    }
}
