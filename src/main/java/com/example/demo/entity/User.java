package com.example.demo.entity;

//import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "users")
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(nullable = false, columnDefinition = "VARCHAR(100)")
    private String name;
    @Column(unique = true, nullable = false, columnDefinition = "VARCHAR(150)")
    private String email;
    @Column(columnDefinition = "VARCHAR(1000)", name = "password_hash")
    private String passwordHash;
    @Column(columnDefinition = "VARCHAR(20)")
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
	public String getPasswordHash() {
		return passwordHash;
	}
	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
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
	
	//Constructor
	public User(String name, String email, String passwordHash, String phone, String address, String role,
			String createdAt, List<Cart> carts, List<Order> orders) {
		super();
		this.name = name;
		this.email = email;
		this.passwordHash = passwordHash;
		this.phone = phone;
		this.address = address;
		this.role = role;
		this.createdAt = createdAt;
		this.carts = carts;
		this.orders = orders;
	}
	
	public User() {}
	
	
    
    
}
