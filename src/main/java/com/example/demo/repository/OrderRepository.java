package com.example.demo.repository;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.example.demo.config.ConnectionPoolImlp;
import com.example.demo.entity.Order;
import com.example.demo.entity.OrderItem;
import com.example.demo.entity.Product;
import com.example.demo.entity.User;
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
            ps.setString(4, "PENDDING"); // Default status
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

  public List<Order> getOrders(String status, int page, int size) throws SQLException {
    List<Order> orders = new ArrayList<>();
    Map<Integer, Order> orderMap = new HashMap<>();

    StringBuilder sql = new StringBuilder(
        "SELECT o.id AS order_id, o.order_date, o.status, o.total_amount, " +
        "o.payment_method, o.shipping_address, u.id AS user_id, u.name, u.email, " +
        "oi.id AS item_id, oi.quantity, oi.price, " +
        "p.id AS product_id, p.name AS product_name, p.price AS product_price " +
        "FROM orders o " +
        "JOIN users u ON o.user_id = u.id " +
        "JOIN order_item oi ON o.id = oi.order_id " +
        "JOIN product p ON oi.product_id = p.id "
    );

    // Thêm điều kiện WHERE nếu có status
    if (status != null && !status.trim().isEmpty()) {
        sql.append("WHERE o.status = ? ");
    }

    sql.append("ORDER BY o.id DESC LIMIT ? OFFSET ?");

    try (Connection conn = ConnectionPoolImlp.getInstance().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {

        int paramIndex = 1;

        if (status != null && !status.trim().isEmpty()) {
            ps.setString(paramIndex++, status);
        }

        ps.setInt(paramIndex++, size);
        ps.setInt(paramIndex, (page - 1) * size);

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                Order order = orderMap.get(orderId);
                if (order == null) {
                    order = new Order();
                    order.setId(orderId);
                    order.setOrderDate(rs.getTimestamp("order_date").toLocalDateTime());
                    order.setStatus(rs.getString("status"));
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setPaymentMethod(rs.getString("payment_method"));
                    order.setShippingAddress(rs.getString("shipping_address"));

                    User user = new User();
                    user.setId(rs.getInt("user_id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    order.setUser(user);

                    order.setItems(new ArrayList<>());
                    orderMap.put(orderId, order);
                }

                OrderItem item = new OrderItem();
                item.setId(rs.getInt("item_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getBigDecimal("price"));

                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setPrice(rs.getString("product_price"));

                item.setProduct(product);
                order.getItems().add(item);
            }

            orders.addAll(orderMap.values());
        }
    } catch (SQLException e) {
        e.printStackTrace();
        throw e;
    }

    return orders;
}

public Order getOrder(int orderId) throws SQLException {
        Order order = null;
        String sql = "SELECT o.id AS order_id, o.order_date, o.status, o.total_amount, " +
                     "o.payment_method, o.shipping_address, u.id AS user_id, u.name, u.email, " +
                     "oi.id AS item_id, oi.quantity, oi.price, " +
                     "p.id AS product_id, p.name AS product_name, p.price AS product_price " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.id " +
                     "JOIN order_item oi ON o.id = oi.order_id " +
                     "JOIN product p ON oi.product_id = p.id " +
                     "WHERE o.id = ?";

        // Sử dụng connection pool để lấy kết nối
        try (Connection conn = ConnectionPoolImlp.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Set giá trị orderId vào PreparedStatement
            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Tạo đối tượng Order
                    order = new Order();
                    order.setId(rs.getInt("order_id"));
                    order.setOrderDate(rs.getTimestamp("order_date").toLocalDateTime());
                    order.setStatus(rs.getString("status"));
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setPaymentMethod(rs.getString("payment_method"));
                    order.setShippingAddress(rs.getString("shipping_address"));

                    // Tạo đối tượng User từ thông tin người dùng trong đơn hàng
                    User user = new User();
                    user.setId(rs.getInt("user_id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));

                    // Gán thông tin người dùng vào đơn hàng
                    order.setUser(user);

                    // Danh sách các mục trong đơn hàng
                    List<OrderItem> orderItems = new ArrayList<>();

                    // Lặp qua các dòng kết quả để lấy thông tin từng mục trong đơn hàng
                    do {
                        // Tạo đối tượng OrderItem
                        OrderItem item = new OrderItem();
                        item.setId(rs.getInt("item_id"));
                        item.setQuantity(rs.getInt("quantity"));
                        item.setPrice(rs.getBigDecimal("price"));

                        // Tạo đối tượng Product và gán vào OrderItem
                        Product product = new Product();
                        product.setId(rs.getInt("product_id"));
                        product.setName(rs.getString("product_name"));
                        product.setPrice(rs.getString("product_price"));

                        // Gán sản phẩm vào mục đơn hàng
                        item.setProduct(product);

                        // Thêm item vào danh sách các mục trong đơn hàng
                        orderItems.add(item);
                    } while (rs.next());  // Tiếp tục lặp qua các kết quả nếu có nhiều item

                    // Gán danh sách mục vào đơn hàng
                    order.setItems(orderItems);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Log lỗi hoặc xử lý lỗi theo nhu cầu
            throw e;  // Ném lại ngoại lệ nếu có lỗi
        }

        return order;  // Trả về đơn hàng với chi tiết đầy đủ
    }

    public long countOrders(String status) throws SQLException {
    long count = 0;
    String sql = "SELECT COUNT(DISTINCT o.id) AS total FROM orders o";

    // Nếu có status thì thêm điều kiện WHERE
    if (status != null && !status.trim().isEmpty()) {
        sql += " WHERE o.status = ?";
    }

    try (Connection conn = ConnectionPoolImlp.getInstance().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        if (status != null && !status.trim().isEmpty()) {
            ps.setString(1, status);
        }

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getLong("total");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        throw e;
    }

    return count;
}

    public List<Order> getOrdersByUser(User user) {
        String sql = "SELECT * FROM orders WHERE user_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            connection = ConnectionPoolImlp.getInstance().getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1,user.getId());
            rs = ps.executeQuery();
            List<Order> orders = new java.util.ArrayList<>();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setOrderDate(rs.getTimestamp("order_date").toLocalDateTime());
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setShippingAddress(rs.getString("shipping_address"));
                order.setStatus(rs.getString("status"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setUser(user);
                orders.add(order);
            }
            return orders;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error retrieving orders: " + e.getMessage(), e);
        } finally {
            // Close resources if necessary
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
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
