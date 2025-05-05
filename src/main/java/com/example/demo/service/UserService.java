package com.example.demo.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.repository.UserRepository;
import com.example.demo.entity.User;

@Service
public class UserService {
	private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    public User getUserByEmail (String Email) throws SQLException {
    	User user = userRepository.findByEmail(Email);
    	return user;
    }
    public List<User> getAllUser() throws SQLException {
        return this.userRepository.findAll();
    }

    public void saveUser(User user) throws SQLException {
        this.userRepository.saveUser(user);
    }
  // Kiểm tra xem email đã tồn tại trong hệ thống chưa
  public boolean isEmailExist(String email, int userId) throws SQLException {
    User existingUser = userRepository.getUserByEmail(email);
    if (existingUser != null && existingUser.getId() != userId) {
        return true; // Nếu email đã tồn tại và không phải của người dùng hiện tại
    }
    return false; // Nếu email chưa tồn tại
}

// Cập nhật thông tin người dùng
public void updateUser(User user) throws SQLException {
    userRepository.updateUser(user);
}
   public User getUserById(int id) throws SQLException {
        return this.userRepository.findUserById(id);
   }
   public void deleteUser(int id) throws SQLException {
    this.userRepository.deleteUser(id);
   }

   public int getTotalUsers() {
    return this.userRepository.getTotalUsers();
    }

    public int getTotalUsersLastSunday() {
        return this.userRepository.getTotalUsersLastSunday();
        }
}
