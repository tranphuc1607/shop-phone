package com.example.demo.repository;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

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

  public List<Order> getAllOrders() throws SQLException {
    List<Order> orders = new ArrayList<>();
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Kết nối cơ sở dữ liệu (sử dụng ConnectionPoolImlp của bạn)
        conn = ConnectionPoolImlp.getInstance().getConnection();

        // Câu lệnh SQL để lấy tất cả đơn hàng và thông tin người dùng
        String sql = "SELECT o.id AS order_id, o.order_date, o.status, o.total_amount, " +
                     "o.payment_method, o.shipping_address, u.id AS user_id, u.name, u.email " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.id";
                     
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();

        // Duyệt qua kết quả và tạo đối tượng Order
        while (rs.next()) {
            Order order = new Order();
            order.setId(rs.getInt("order_id"));
            order.setOrderDate(rs.getTimestamp("order_date").toLocalDateTime());
            order.setStatus(rs.getString("status"));
            order.setTotalAmount(rs.getBigDecimal("total_amount"));
            order.setPaymentMethod(rs.getString("payment_method"));
            order.setShippingAddress(rs.getString("shipping_address"));

            // Tạo đối tượng User và gán vào Order
            User user = new User();
            user.setId(rs.getInt("user_id"));
            user.setName(rs.getString("name"));
            user.setEmail(rs.getString("email"));

            // Gán user vào order
            order.setUser(user);

            // Thêm đơn hàng vào danh sách
            orders.add(order);
        }

    } catch (SQLException e) {
        e.printStackTrace();
        throw e;  // Ném lại ngoại lệ nếu có lỗi
    } finally {
        // Đảm bảo đóng tài nguyên khi xong
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
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

}
