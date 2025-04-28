package com.example.demo.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
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
// show user
    public List<User> getAllUser() throws SQLException {
        return userRepository.findAll();
    }
// thêm user 
    public void addUser(User user) throws SQLException {
        userRepository.saveUser(user);
    }
// update userr
   public void updateUser(User user) throws SQLException {
    try {
        if (user.getName() == null || user.getEmail() == null) {
        }

        userRepository.updateUser(user);
    } catch (Exception e) {
        e.printStackTrace();
    }
   }
}
