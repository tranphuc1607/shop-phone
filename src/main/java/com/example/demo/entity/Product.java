package com.example.demo.entity;

import java.math.BigDecimal;
//import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;

@Entity
public class Product {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(columnDefinition = "VARCHAR(1000)")
    private String name;
    private String description;
    private BigDecimal price;
    private Integer stockQuantity;

    @Column(name = "created_at", columnDefinition = "VARCHAR(20)")
    private String createdAt;

    @ManyToOne
    @JoinColumn(name = "brand_id")
    private Brand brand;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true) private List<ProductImage> images;
    @OneToOne(mappedBy = "product", cascade = CascadeType.ALL)
    private ProductSpecification specification;

    @OneToMany(mappedBy = "product") private List<CartItem> cartItems;
    @OneToMany(mappedBy = "product") private List<OrderItem> orderItems;
    
    
	public Integer getId() {
		return id;
	}

	public void setId(int id) {
		this.id =id; 
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public Integer getStockQuantity() {
		return stockQuantity;
	}
	public void setStockQuantity(Integer stockQuantity) {
		this.stockQuantity = stockQuantity;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public Brand getBrand() {
		return brand;
	}
	public void setBrand(Brand brand) {
		this.brand = brand;
	}
	public List<ProductImage> getImages() {
		return images;
	}
	public void setImages(List<ProductImage> images) {
		this.images = images;
	}
	public ProductSpecification getSpecification() {
		return specification;
	}
	public void setSpecification(ProductSpecification specification) {
		this.specification = specification;
	}
	public List<CartItem> getCartItems() {
		return cartItems;
	}
	public void setCartItems(List<CartItem> cartItems) {
		this.cartItems = cartItems;
	}
	public List<OrderItem> getOrderItems() {
		return orderItems;
	}
	public void setOrderItems(List<OrderItem> orderItems) {
		this.orderItems = orderItems;
	}
	
	//Constructor
	
	public Product(String name, String description, BigDecimal price, Integer stockQuantity, String createdAt,
			Brand brand, List<ProductImage> images, ProductSpecification specification, List<CartItem> cartItems,
			List<OrderItem> orderItems) {
		super();
		this.name = name;
		this.description = description;
		this.price = price;
		this.stockQuantity = stockQuantity;
		this.createdAt = createdAt;
		this.brand = brand;
		this.images = images;
		this.specification = specification;
		this.cartItems = cartItems;
		this.orderItems = orderItems;
	}
    
	public Product() {}
	
    
}
