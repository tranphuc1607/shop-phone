package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;


@Service
public class CustomUserDetailsService implements UserDetailsService {
	 	@Autowired
	    private UserRepository userRepository; // 
	    @Override
	    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
	    	User user = null;
	    	try {
	    		user = userRepository.findByEmail(email); 
	    	} catch (Exception e) {
	    		throw new UsernameNotFoundException("Lỗi truy cập cơ sở dữ liệu!");
	    	}
	        

	        if (user == null) {
	            throw new UsernameNotFoundException("Email không tồn tại: " + email);
	        }

	        return org.springframework.security.core.userdetails.User
	                .withUsername(user.getEmail())
	                .password(user.getPassword())
	                .roles(user.getRole()) // 
	                .build();
	    }
}
