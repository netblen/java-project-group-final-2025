package com.example.project.model;

import java.sql.Timestamp;

public class ShoppingCart {
    private int cartId;
    private int customerId;
    private Timestamp createdAt;

    // Constructor
    public ShoppingCart(int cartId, int customerId, Timestamp createdAt) {
        this.cartId = cartId;
        this.customerId = customerId;
        this.createdAt = createdAt;
    }

    // Getters
    public int getCartId() { return cartId; }
    public int getCustomerId() { return customerId; }
    public Timestamp getCreatedAt() { return createdAt; }

    // Setters
    public void setCartId(int cartId) { this.cartId = cartId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
