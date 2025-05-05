package com.example.demo.entity;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

@Entity
public class Brand {

    public Brand(int id, String name) {
        this.id = id;
        this.name = name;
    }
    
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(columnDefinition = "VARCHAR(1000)")
    private String name;

    @OneToMany(mappedBy = "brand") private List<Product> products;
    
    public Integer getId() {return id;}
    public String getName() {return name;}
    public List<Product> getProduct() {return this.products;}
    
    
    public void setId(Integer id) {this.id = id;}
    public void setName(String name) {this.name = name;}
    public void setProduct (List<Product> product) {this.products = product;}
    
    //Constructor
    public Brand() {};
    public Brand(String name, List<Product> product) {
    	this.name = name;
    	this.products = product;
    }
    
}
