package com.example.demo.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.config.ConnectionPoolImlp;
import com.example.demo.entity.DTO.CartItemViewDTO;

@Repository
public class CartItemRepository {
    public List<CartItemViewDTO> findAllByCartId(int cartId) throws SQLException{
        List<CartItemViewDTO> items = new ArrayList<>();

        String sql = "SELECT ci.id cartItem_id, p.id AS product_id, p.name AS product_name, p.image AS product_image, p.price AS product_price, ci.quantity " +
                     "FROM cart_item ci " +
                     "JOIN product p ON ci.product_id = p.id " +
                     "WHERE ci.cart_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            connection = ConnectionPoolImlp.getInstance().getConnection();
            // First, check if the user exists
            ps = connection.prepareStatement(sql);
            ps.setInt(1, cartId);
            rs = ps.executeQuery();
            while (rs.next()) {
                    int cartItemId = rs.getInt("cartItem_id");
                    int productId = rs.getInt("product_id");
                    String name = rs.getString("product_name");
                    String image = rs.getString("product_image");
                    String price = rs.getString("product_price");
                    int quantity = rs.getInt("quantity");

                    items.add(new CartItemViewDTO(cartItemId,productId, name, image, price, quantity));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error retrieving cart items for cart ID: " + cartId, e);
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
        return items;
    }    
    public void addItemToCart(Long productId, int quantity, int userId) throws SQLException {
        String sql = "INSERT INTO cart_item (cart_id, product_id, quantity) " +
                     "VALUES ((SELECT id FROM cart WHERE user_id = ?), ?, ?)";
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = ConnectionPoolImlp.getInstance().getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setLong(2, productId);
            ps.setInt(3, quantity);
            ps.executeUpdate();
            connection.commit(); // Commit the transaction
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error adding item to cart for user ID: " + userId, e);
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    }
    public void deleteCartItem(int cartItemId) throws SQLException {
        String sql = "DELETE FROM cart_item WHERE id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = ConnectionPoolImlp.getInstance().getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, cartItemId);
            ps.executeUpdate();
            connection.commit(); // Commit the transaction
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error deleting cart item with ID: " + cartItemId, e);
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    }
}
