package com.example.demo.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class CartItem {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private Integer quantity;

    @ManyToOne
    @JoinColumn(name = "cart_id")
    private Cart cart;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;
    
    public Integer getId() {return this.id;}
    public Integer getQuantity() {return this.quantity;}
    public Cart getCart() {return this.cart;}
    public Product getProduct() {return this.product;}
    
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public void setCart(Cart cart) {
		this.cart = cart;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	
	public CartItem() {}
	public CartItem(Integer quantity, Cart cart, Product product) {
		super();
		this.quantity = quantity;
		this.cart = cart;
		this.product = product;
	}
    
	
}
