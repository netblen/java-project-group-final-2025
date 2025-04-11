package com.example.project.model;

public class Inventory {
    private int bookId;
    private int inventoryQuantity;

    // Constructor
    public Inventory(int bookId, int inventoryQuantity) {
        this.bookId = bookId;
        this.inventoryQuantity = inventoryQuantity;
    }

    // Getters
    public int getBookId() { return bookId; }
    public int getInventoryQuantity() { return inventoryQuantity; }

    // Setters
    public void setBookId(int bookId) { this.bookId = bookId; }
    public void setInventoryQuantity(int inventoryQuantity) {
        this.inventoryQuantity = inventoryQuantity;
    }
}
