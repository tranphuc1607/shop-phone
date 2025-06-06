package com.example.demo.entity.DTO;

import java.math.BigDecimal;
import java.util.List;

import com.example.demo.entity.User;

public class CheckoutDTO {
    private int userId;
    private String userName;
    private String userEmail;
    private String userPhone;
    private String userAddress;
    private String paymentMethod = "Cash"; // Default payment method
    private List<CartItemViewDTO> cartItems;
    private BigDecimal totalAmount;
    private BigDecimal calculateTotalAmount(List<CartItemViewDTO> cartItems) {
        BigDecimal total = BigDecimal.ZERO;

        for (CartItemViewDTO item : cartItems) {
            String priceStr = item.getProductPrice();
            BigDecimal price;

            try {
                // Loại bỏ ký tự không hợp lệ như "₫", ",", "VNĐ", v.v.
                price = new BigDecimal(priceStr.replaceAll("[^\\d.]", ""));
            } catch (NumberFormatException e) {
                price = BigDecimal.ZERO; // fallback nếu lỗi định dạng
            }

            total = total.add(price.multiply(BigDecimal.valueOf(item.getQuantity())));
        }

        return total;
    }
    public CheckoutDTO() {}

    public CheckoutDTO(int userId, String userName, String userEmail, String userPhone, String userAddress, List<CartItemViewDTO> cartItems) {
        this.userId = userId;
        this.userName = userName;
        this.userEmail = userEmail;
        this.userPhone = userPhone;
        this.userAddress = userAddress;
        this.cartItems = cartItems;
        this.totalAmount = calculateTotalAmount(cartItems);
    }
    public CheckoutDTO(User user, List<CartItemViewDTO> cartItems) {
        this.userId = user.getId();
        this.userName = user.getName();
        this.userEmail = user.getEmail();
        this.userPhone = user.getPhone();
        this.userAddress = user.getAddress();
        this.cartItems = cartItems;
        this.totalAmount = calculateTotalAmount(cartItems);
    }
    public int getUserId() {
        return userId;
    }
    public String getUserName() {
        return userName;
    }
    public String getUserEmail() {
        return userEmail;
    }
    public String getUserPhone() {
        return userPhone;
    }
    public String getUserAddress() {
        return userAddress;
    }
    public String getPaymentMethod() {
        return paymentMethod;
    }
    public List<CartItemViewDTO> getCartItems() {
        return cartItems;
    }
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }   
    public void setCartItems(List<CartItemViewDTO> cartItems) {
    this.cartItems = cartItems;
    }
    // Setters
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }
    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
    

}
