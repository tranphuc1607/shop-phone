package com.example.demo.entity.DTO;

public class CartItemViewDTO {
    private int cartItemId; 
    private int productId;
    private String productName;
    private String productImage;
    private String productPrice; // String vì hệ thống bạn đang dùng chuỗi giá tiền
    private int quantity;

    public CartItemViewDTO(int cartItemId,int productId, String productName, String productImage, String productPrice, int quantity) {
        this.cartItemId = cartItemId; 
        this.productId = productId;
        this.productName = productName;
        this.productImage = productImage;
        this.productPrice = productPrice;
        this.quantity = quantity;
    }
    public CartItemViewDTO() {
        // cần constructor rỗng để Spring có thể tự động khởi tạo object khi bind cartItems[0]
    }
    // Getters
    public int getCartItemId() { return cartItemId; }
    public int getProductId() { return productId; }
    public String getProductName() { return productName; }
    public String getProductImage() { return productImage; }
    public String getProductPrice() { return productPrice; }
    public int getQuantity() { return quantity; }
    //setters
    public void setCartItemId(int cartItemId) { this.cartItemId = cartItemId; }
    public void setProductId(int productId) { this.productId = productId; }
    public void setProductName(String productName) { this.productName = productName; }
    public void setProductImage(String productImage) { this.productImage = productImage; }
    public void setProductPrice(String productPrice) { this.productPrice = productPrice; }
    public void setQuantity(int quantity) { this.quantity = quantity;}

}
