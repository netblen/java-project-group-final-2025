package com.example.project.model;

public class CartItemDetails {
    private int bookId;
    private String title;
    private String author;
    private int quantity;
    private double price;

    public CartItemDetails(int bookId, String title, String author, int quantity, double price) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.quantity = quantity;
        this.price = price;
    }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPrice() {
        return price;
    }
}
