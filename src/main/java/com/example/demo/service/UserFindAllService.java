package com.example.demo.service;

import java.sql.SQLException;
import java.util.List;

import com.example.demo.repository.UserResponsitory;
import com.example.demo.entity.User;

public class UserFindAllService {
	private final UserResponsitory repo = new UserResponsitory();

    public List<User> getAllUser() throws SQLException {
        return repo.findAll();
    }
}
