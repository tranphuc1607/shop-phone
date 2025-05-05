package com.example.demo.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.TimeUnit;

public class ConnectionPoolImlp implements ConnectionPool {
    private String url;
    private String user;
    private String password;
    private LinkedBlockingDeque<Connection> connectionPool;
    private final int INITIAL_POOL_SIZE = 10;
    private static volatile ConnectionPoolImlp INSTANCE;

    // Constructor
    private ConnectionPoolImlp(String user, String password, String url) throws SQLException {
        this.user = user;
        this.password = password;
        this.url = url;
        this.connectionPool = new LinkedBlockingDeque<>(this.INITIAL_POOL_SIZE);
        this.initializePool();
    }

    // Hàm khởi tạo Pool kết nối
    private void initializePool() throws SQLException {
        for (int i = 0; i < this.INITIAL_POOL_SIZE; i++) {
            Connection connection = this.createConnection();
            connection.setAutoCommit(false);
            this.connectionPool.offerFirst(connection);
        }
    }

    // Hàm tạo một kết nối mới
    private Connection createConnection() throws SQLException {
        return DriverManager.getConnection(this.url, this.user, this.password);
    }

    // Lấy kết nối từ pool
    @Override
    public Connection getConnection() throws SQLException {
        try {
            // Nếu không có kết nối nào trong 3 giây thì báo lỗi
            Connection connection = this.connectionPool.pollFirst(3, TimeUnit.SECONDS);
            if (connection == null) {
                throw new SQLException("Pool is empty! Could not fetch connection.");
            }
            if (connection.isClosed() || !connection.isValid(1)) {
                if (!connection.isClosed()) {
                    connection.close();  // Đảm bảo đóng kết nối cũ nếu nó không hợp lệ
                }
                // Tạo một kết nối mới nếu kết nối cũ không hợp lệ
                connection = this.createConnection();
                connection.setAutoCommit(false);
            }
            connection.clearWarnings();
            return connection;
        } catch (InterruptedException e) {
            throw new SQLException("Thread was interrupted while waiting for a connection", e);
        }
    }

    // Trả kết nối về pool
    @Override
    public boolean releaseConnection(Connection connection) {
        if (connection != null) {
            try {
                // Kiểm tra xem kết nối có đóng hay không, nếu không thì trả về pool
                if (!connection.isClosed() && connection.isValid(1)) {
                    this.connectionPool.offerFirst(connection);
                    return true;
                } else {
                    // Nếu kết nối không hợp lệ, đóng nó và không thêm vào pool
                    connection.close();
                }
            } catch (SQLException e) {
                System.err.println("Error while releasing connection: " + e.getMessage());
            }
        }
        return false;
    }

    // Đảm bảo singleton chỉ có một instance duy nhất
    public static synchronized ConnectionPoolImlp getInstance() throws SQLException {
        if (INSTANCE == null) {
            synchronized (ConnectionPoolImlp.class) {
                if (INSTANCE == null) {
                    INSTANCE = new ConnectionPoolImlp(
                            "root",
                            "123456",
                            "jdbc:mysql://localhost:3306/shopPhone?useSSL=false&serverTimezone=UTC"
                    );
                }
            }
        }
        return INSTANCE;
    }

    // Đóng toàn bộ kết nối trong pool
    @Override
    public void shutdown() {
        for (Connection connection : connectionPool) {
            try {
                if (!connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
