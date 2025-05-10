package com.example.demo.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.example.demo.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

import com.example.demo.entity.User;

@Service
public class UserService {
	private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;


    public UserService(UserRepository userRepository,PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
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
    
        public boolean changePassword(String oldPassword, String newPassword) throws SQLException {
            // Lấy thông tin người dùng từ Authentication
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            String username = auth.getName(); // Thường là email của người dùng
            User user = this.userRepository.getUserByEmail(username);
        
            if (user == null) {
                return false;
            } else {
                if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
                    return false; // Mật khẩu cũ không đúng
                }
            
                // Kiểm tra mật khẩu mới không trùng với mật khẩu cũ (optional, tránh người dùng đặt lại mật khẩu giống cũ)
                if (passwordEncoder.matches(newPassword, user.getPassword())) {
                    return false; // Mật khẩu mới giống mật khẩu cũ
                }
            
                // Cập nhật mật khẩu mới (đã mã hóa)
                String encodedNewPassword = passwordEncoder.encode(newPassword);
            
                // Cập nhật vào cơ sở dữ liệu
                this.userRepository.updatePassword(user,encodedNewPassword); // Giả sử method updateUser đã thực hiện lưu lại thay đổi
            
                return true; // Thao tác thành công
            }
        
            // Kiểm tra mật khẩu cũ
           
        }
        
        
    
    }
