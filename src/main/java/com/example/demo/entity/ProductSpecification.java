package com.example.demo.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;

@Entity
public class ProductSpecification {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(columnDefinition = "VARCHAR(200)")
    private String ram;
    @Column(columnDefinition = "VARCHAR(200)")
    private String storage;
    @Column(columnDefinition = "VARCHAR(200)")
    private String screen;
    @Column(columnDefinition = "VARCHAR(200)")
    private String battery;
    @Column(columnDefinition = "VARCHAR(200)")
    private String os;
    @Column(columnDefinition = "VARCHAR(200)")
    private String chipset;

    @OneToOne
    @JoinColumn(name = "product_id")
    private Product product;
    
    public Integer getId() {return this.id;}
    public String getRam() {return this.ram;}
    public String getStorage() {return this.storage;}
    public String getScreen() {return this.screen;}
    public String getBattery() {return this.battery;}
    public String getOs() {return this.os;}
    public String getChipset() {return this.chipset;}
    public Product getProduct() {return this.product;}
    
    
    public void setRam(String ram) {this.ram = ram;}
    public void setStorage(String storage) {this.storage = storage;}
    public void setScreen(String screen) {this.screen = screen;}
    public void setBattery(String battery)  {this.battery = battery;}
    public void setOs(String os) {this.os = os;}
    public void setChipset(String chipset) {this.chipset = chipset;}
    public void setProduct (Product product) {this.product = product;}
    // Constructor
    public ProductSpecification() {}
    public ProductSpecification(String ram, String storage, String screen, String battery, String os, String chipset, Product product) {
    	this.ram = ram;
    	this.storage = storage;
    	this.screen = screen;
    	this.battery = battery;
    	this.os = os;
    	this.chipset = chipset;
    	this.product = product;
    }
}
