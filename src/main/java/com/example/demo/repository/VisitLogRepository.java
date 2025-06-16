package com.example.demo.repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;

import org.springframework.stereotype.Repository;

import com.example.demo.config.ConnectionPoolImlp;

@Repository
public class VisitLogRepository {
    public void saveVisit(String ipAddress, String userAgent) {
    String sql = "INSERT INTO visit_logs (ip_address, user_agent) VALUES (?, ?)";
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        conn = ConnectionPoolImlp.getInstance().getConnection();
        ps = conn.prepareStatement(sql);
        ps.setString(1, ipAddress);
        ps.setString(2, userAgent);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Đóng PreparedStatement
        try {
            if (ps != null) ps.close();
        } catch (SQLException ignored) {}

        // Trả lại Connection vào ConnectionPool
        try {
            if (conn != null) {
                ConnectionPoolImlp.getInstance().releaseConnection(conn);
            }
        } catch (Exception ignored) {}
    }
}


    public int countVisitsInLast30Days() {
    String sql = "SELECT COUNT(*) FROM visit_logs WHERE visit_time >= NOW() - INTERVAL 30 DAY";
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = ConnectionPoolImlp.getInstance().getConnection();
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Đóng ResultSet
        try {
            if (rs != null) rs.close();
        } catch (SQLException ignored) {}

        // Đóng PreparedStatement
        try {
            if (ps != null) ps.close();
        } catch (SQLException ignored) {}

        // Trả lại Connection vào ConnectionPool
        try {
            if (conn != null) {
                ConnectionPoolImlp.getInstance().releaseConnection(conn);
            }
        } catch (Exception ignored) {}
    }

    return 0;
}

}

