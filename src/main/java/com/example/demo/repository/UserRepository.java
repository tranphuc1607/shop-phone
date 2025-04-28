package com.example.demo.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.config.ConnectionPoolImlp;
import com.example.demo.entity.User;

@Repository
public class UserRepository { 
	// tìm tất cả người dungg
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
	// câp nhật người dùng
	public void updateUser(User user) throws SQLException {
		Connection connection = null;
		try {
			ConnectionPoolImlp pool = ConnectionPoolImlp.getInstance();
			connection = pool.getConnection();
	
			String sql = "UPDATE users SET name = ?, email = ?, password_hash = ?, phone = ?, address = ?, role = ? WHERE id = ?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPasswordHash());
			ps.setString(4, user.getPhone());
			ps.setString(5, user.getAddress());
			ps.setString(6, user.getRole());
			ps.setInt(7, user.getId());
	
			pool.releaseConnection(connection);
	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (connection != null) {
				ConnectionPoolImlp.getInstance().releaseConnection(connection);
			}
		}
	}
// tìm người dùng bằng id 
	public User findUserById(int id) throws SQLException {
		User user = null;
		Connection connection = null;
		try {
			ConnectionPoolImlp pool = ConnectionPoolImlp.getInstance();
			connection = pool.getConnection();
	
			String sql = "SELECT * FROM users WHERE id = ?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
	
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPasswordHash(rs.getString("password_hash"));
				user.setPhone(rs.getString("phone"));
				user.setAddress(rs.getString("address"));
				user.setRole(rs.getString("role"));
			}
			pool.releaseConnection(connection);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (connection != null) {
				ConnectionPoolImlp.getInstance().releaseConnection(connection);
			}
		}
		return user;
	}
	// lưu người dùng 
	public void saveUser(User user) throws SQLException {
		Connection connection = null;
		try {
			ConnectionPoolImlp pool = ConnectionPoolImlp.getInstance();
			connection = pool.getConnection();
	
			String sql = "INSERT INTO users (name, email, password_hash, phone, address, role) VALUES (?, ?, ?, ?, ?, ?)";
			
			PreparedStatement ps = connection.prepareStatement(sql);
			
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPasswordHash());
			ps.setString(4, user.getPhone());
			ps.setString(5, user.getAddress());
			ps.setString(6, user.getRole());
	
			pool.releaseConnection(connection);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (connection != null) {
				ConnectionPoolImlp.getInstance().releaseConnection(connection);
			}
		}
	}
	
}
