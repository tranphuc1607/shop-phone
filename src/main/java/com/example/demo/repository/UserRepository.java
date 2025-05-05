package com.example.demo.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.example.demo.config.ConnectionPoolImlp;
import com.example.demo.entity.User;
// import com.mysql.cj.jdbc.exceptions.MySQLTransactionRollbackException;

@Repository
public class UserRepository {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    private static final Logger logger = LoggerFactory.getLogger(UserRepository.class);

    // Tìm tất cả người dùng
    public List<User> findAll() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = ConnectionPoolImlp.getInstance().getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                users.add(user);
            }

        } catch (SQLException e) {
            logger.error("Error while fetching all users: {}", e.getMessage(), e);
            throw e;
        } finally {
            // Đảm bảo giải phóng tài nguyên
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
            if (connection != null) ConnectionPoolImlp.getInstance().releaseConnection(connection);
        }

        return users;
    }

    // Tìm người dùng theo ID
    public User findUserById(int id) throws SQLException {
        User user = null;
        String sql = "SELECT * FROM users WHERE id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = ConnectionPoolImlp.getInstance().getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
            }

        } catch (SQLException e) {
            logger.error("Error while fetching user by id: {}", e.getMessage(), e);
            throw e;
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
            if (connection != null) ConnectionPoolImlp.getInstance().releaseConnection(connection);
        }

        return user;
    }

    // Lưu người dùng
    public void saveUser(User user) throws SQLException {
        Connection connection = null;
        PreparedStatement ps = null;

        try {
            connection = ConnectionPoolImlp.getInstance().getConnection();
            String sql = "INSERT INTO users (name, email, password, phone, address, role) VALUES (?, ?, ?, ?, ?, ?)";
            ps = connection.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getRole());

            ps.executeUpdate();
            connection.commit(); 

        } catch (SQLException e) {
            if (connection != null) connection.rollback();
            logger.error("Error while saving user: {}", e.getMessage(), e);
            throw e;
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
            if (connection != null) ConnectionPoolImlp.getInstance().releaseConnection(connection);
        }
    }

    public void deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";
        Connection connection = null;
        PreparedStatement ps = null;

        try {
            connection = ConnectionPoolImlp.getInstance().getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);

            ps.executeUpdate();
            connection.commit(); 

        } catch (SQLException e) {
            logger.error("Error while deleting user: {}", e.getMessage(), e);
            throw e;
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
            if (connection != null) ConnectionPoolImlp.getInstance().releaseConnection(connection);
        }
    }

    public boolean existsByEmail(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        try (
            Connection conn = ConnectionPoolImlp.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, email);
            
            // Thực thi truy vấn và lấy kết quả
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
        return false;
    }
    
    // Kiểm tra email đã tồn tại hay chưa
    public User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
    
        try {
            connection = ConnectionPoolImlp.getInstance().getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapRowToUser(rs);
            }
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
            if (connection != null) ConnectionPoolImlp.getInstance().releaseConnection(connection);
        }
    
        return null;
    }

    private boolean isEmailExist(String email, int excludeUserId, Connection connection) throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ? AND id <> ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setInt(2, excludeUserId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
    

    // Cập nhật thông tin người dùng
    public void updateUser(User user) throws SQLException {
        Connection connection = null;
        PreparedStatement ps = null;
    
        try {
            connection = ConnectionPoolImlp.getInstance().getConnection();
    
            // Kiểm tra xem email đã tồn tại cho user khác chưa
            if (isEmailExist(user.getEmail(), user.getId(), connection)) {
                throw new SQLException("Email already exists.");
            }
    
            String sql = "UPDATE users SET name = ?, address = ?, phone = ? WHERE id = ?";
            ps = connection.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getAddress());
            ps.setString(3, user.getPhone());
            ps.setInt(4, user.getId());
    
            ps.executeUpdate();
            connection.commit(); // Nếu bạn dùng setAutoCommit(false)
    
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            throw e;
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
            if (connection != null) ConnectionPoolImlp.getInstance().releaseConnection(connection);
        }
    }
    

    private User mapRowToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setEmail(rs.getString("email"));
        user.setName(rs.getString("name"));
        user.setAddress(rs.getString("address"));
        user.setPhone(rs.getString("phone"));
        return user;
    }

    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM users";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

     public int getTotalUsersLastSunday() {
        String sql = "SELECT COUNT(*) FROM users WHERE created_at >= ? AND created_at < ?";

        LocalDate lastSunday = LocalDate.now().minusWeeks(1).with(DayOfWeek.SUNDAY);
        
        java.sql.Date startDate = java.sql.Date.valueOf(lastSunday);
        java.sql.Date endDate = java.sql.Date.valueOf(lastSunday.plusDays(1));

        return jdbcTemplate.queryForObject(sql, Integer.class, startDate, endDate);
    }
    
}
