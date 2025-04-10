package com.example.project.model;

public class Inventory {
    private int bookId;
    private int inventoryQuantity;

    //Getters
    public Inventory(int bookId, int inventoryQuantity) {
        this.bookId = bookId;
        this.inventoryQuantity = inventoryQuantity;
    }


    //Setters
    public int getInventoryQuantity() {return inventoryQuantity;}
}
