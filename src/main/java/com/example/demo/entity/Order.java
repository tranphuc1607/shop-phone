package com.example.demo.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.Date;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "orders") 
public class Order {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    private LocalDateTime orderDate;
    @Column(columnDefinition = "VARCHAR(20)")
    private String status;
    private BigDecimal totalAmount;
    @Column(columnDefinition = "VARCHAR(20)")
    private String paymentMethod;

    @Column(columnDefinition = "TEXT(10000)")
    private String shippingAddress;

    @OneToMany(mappedBy = "order")
    private List<OrderItem> items;

	public Integer getId() {
		return id;
	}

	public Date getOrderDateAsDate() {
		return Date.from(orderDate.atZone(ZoneId.systemDefault()).toInstant());
	}

	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	

	@Override
	public String toString() {
		return "Order [id=" + id + ", user=" + user + ", orderDate=" + orderDate + ", status=" + status
				+ ", totalAmount=" + totalAmount + ", paymentMethod=" + paymentMethod + ", shippingAddress="
				+ shippingAddress + ", items=" + items + "]";
	}




	public LocalDateTime getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(LocalDateTime orderDate) {
		this.orderDate = orderDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public BigDecimal getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getShippingAddress() {
		return shippingAddress;
	}

	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}

	public List<OrderItem> getItems() {
		return items;
	}

	public void setItems(List<OrderItem> items) {
		this.items = items;
	}

	//Constructor
	public Order(User user, LocalDateTime orderDate, String status, BigDecimal totalAmount, String paymentMethod,
			String shippingAddress, List<OrderItem> items) {
		super();
		this.user = user;
		this.orderDate = orderDate;
		this.status = status;
		this.totalAmount = totalAmount;
		this.paymentMethod = paymentMethod;
		this.shippingAddress = shippingAddress;
		this.items = items;
	}
	

	public Order() {}




    public void setId(Integer id) {
        this.id = id;
    }
	
    
    
}
