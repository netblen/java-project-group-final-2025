package com.example.project.model;

public class CartItem {
    private int cartId;
    private int bookId;
    private int quantity;

    // Constructor
    public CartItem(int cartId, int bookId, int quantity) {
        this.cartId = cartId;
        this.bookId = bookId;
        this.quantity = quantity;
    }

    // Getters
    public int getCartId() { return cartId; }
    public int getBookId() { return bookId; }
    public int getQuantity() { return quantity; }

    // Setters
    public void setCartId(int cartId) { this.cartId = cartId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}
