package com.example.demo.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.example.demo.config.ConnectionPoolImlp;
import com.example.demo.entity.User;

public class UserResponsitory { 
	public List<User> findAll() throws SQLException{
		List<User> users = new ArrayList<>();
		Connection connection = null;
		try {
			ConnectionPoolImlp pool = ConnectionPoolImlp.getInstance();
			connection = pool.getConnection();
			String sql = "SELECT * FROM users";
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPasswordHash(rs.getString("password_hash"));
				user.setPhone(rs.getString("phone"));
				user.setAddress(rs.getString("address"));
				user.setRole(rs.getString("role"));
				users.add(user);
			}
			pool.releaseConnection(connection);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (connection != null) {
				ConnectionPoolImlp.getInstance().releaseConnection(connection);
			}
		}
		return users;
	}
}
