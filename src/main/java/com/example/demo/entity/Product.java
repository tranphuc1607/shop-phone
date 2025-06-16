package com.example.demo.entity;

//import java.math.BigDecimal;
//import java.time.LocalDateTime;
import java.util.List;

//import org.springframework.web.multipart.MultipartFile;

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
//import jakarta.persistence.Transient;

@Entity
public class Product {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(columnDefinition = "VARCHAR(1000)")
    private String name;
    private String description;
    private String price;
    private String stockQuantity;

    @Column(name = "created_at", columnDefinition = "VARCHAR(1000)")
    private String createdAt;

    @ManyToOne
    @JoinColumn(name = "brand_id")
    private Brand brand;

	private String image;

	private boolean is_deleted = false;


	
	@OneToOne(mappedBy = "product", cascade = CascadeType.ALL)
    private ProductSpecification specification;
	
    @OneToMany(mappedBy = "product") private List<CartItem> cartItems;
    @OneToMany(mappedBy = "product") private List<OrderItem> orderItems;
    
    
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
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
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getStockQuantity() {
		return stockQuantity;
	}
	public void setStockQuantity(String stockQuantity) {
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
	public boolean getIs_deleted() {
		return is_deleted;
	}
	public void setIs_deleted(boolean is_deleted) {
		this.is_deleted = is_deleted;
	}
	//Constructor
	
	public Product(String name, String description, String price, String stockQuantity, String createdAt,
			Brand brand,String image, ProductSpecification specification, List<CartItem> cartItems,
			List<OrderItem> orderItems) {
		super();
		this.name = name;
		this.description = description;
		this.price = price;
		this.stockQuantity = stockQuantity;
		this.createdAt = createdAt;
		this.brand = brand;
		this.image = image;
		this.specification = specification;
		this.cartItems = cartItems;
		this.orderItems = orderItems;
	}

	
    
	

	

	public Product(int id, String name, String price, String stockQuantity, Brand brand,String image,boolean is_deleted) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.stockQuantity = stockQuantity;
    this.brand = brand;
	this.image = image;
	this.is_deleted = is_deleted;
}

    @Override
    public String toString() {
        return "Product [id=" + id + ", name=" + name + ", description=" + description + ", price=" + price
                + ", stockQuantity=" + stockQuantity + ", createdAt=" + createdAt + ", brand=" + brand + ", image="
                + image + ", specification=" + specification + ", cartItems=" + cartItems + ", orderItems=" + orderItems
                + "]";
    }

    public Product() {}
	
    
}
