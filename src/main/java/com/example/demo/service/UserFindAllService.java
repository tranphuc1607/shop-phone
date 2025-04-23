package com.example.demo.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.repository.UserResponsitory;
import com.example.demo.entity.User;

@Service
public class UserFindAllService {
	private final UserResponsitory userResponsitory;

    public UserFindAllService(UserResponsitory userResponsitory) {
        this.userResponsitory = userResponsitory;
    }

    public List<User> getAllUser() throws SQLException {
        return userResponsitory.findAll();
    }

    public void addUser() throws SQLException {
        
    }
}
