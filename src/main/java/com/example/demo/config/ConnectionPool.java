package com.example.demo.config;

import java.sql.Connection;
import java.sql.SQLException;

public interface ConnectionPool {
	Connection getConnection() throws SQLException;
    boolean releaseConnection(Connection connection);
    void shutdown();
}
