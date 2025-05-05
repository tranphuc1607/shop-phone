package com.example.demo.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class ProductImage {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(columnDefinition = "VARCHAR(1000)")
    private String url;
    private Boolean isPrimary;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;
    
    public Integer getId() {return this.id;}
    public String getUrl() {return this.url;}
    public Boolean getIsPrimary() {return this.isPrimary;}
    public void setId(Integer id) {this.id = id;}
    public void setUrl(String url) {this.url = url;}
    public void setIsPrimary(Boolean isPrimary) {this.isPrimary = isPrimary;}
    
    // Constructor
    public ProductImage() {}
    public ProductImage(String url, Boolean isPrimary, Product product) {
    	this.url = url;
    	this.isPrimary = isPrimary;
    	this.product = product;
    }
    public void setProduct(Product newProduct) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'setProduct'");
    }
}
