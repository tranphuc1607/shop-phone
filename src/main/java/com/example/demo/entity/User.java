package com.example.demo.entity;

//import java.time.LocalDateTime;
import java.util.List;

import com.example.demo.service.validator.user.Valid.ValidEmailUser;
import com.example.demo.service.validator.user.Valid.ValidPasswordUser;
import com.example.demo.service.validator.user.Valid.ValidNameUser.ValidName;
import com.example.demo.service.validator.user.Valid.ValidPhoneUser.ValidPhone;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "users")
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
	
	@ValidName
    @Column(nullable = false, columnDefinition = "VARCHAR(100)")
    private String name;
    @Column(columnDefinition = "VARCHAR(150)")
	@ValidEmailUser
    private String email;
    @Column(columnDefinition = "VARCHAR(1000)", name = "password")
	@ValidPasswordUser
    private String password;
    @Column(columnDefinition = "VARCHAR(20)")
	@ValidPhone
    private String phone;
    @Column(columnDefinition = "TEXT(10000)")
    private String address;
    @Column(columnDefinition = "VARCHAR(20)")
    private String role;
    
    
    @Column(name = "created_at", columnDefinition = "VARCHAR(20)") 
    private String createdAt;

    @OneToMany(mappedBy = "user") private List<Cart> carts;
    @OneToMany(mappedBy = "user") private List<Order> orders;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {this.id = id;}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public List<Cart> getCarts() {
		return carts;
	}
	public void setCarts(List<Cart> carts) {
		this.carts = carts;
	}
	public List<Order> getOrders() {
		return orders;
	}
	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}
	
	public User() {}
	
	
    
    
}
