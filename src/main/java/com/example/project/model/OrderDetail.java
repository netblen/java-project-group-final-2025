package com.example.project.model;

public class OrderDetail {
    private int bookId;
    private int orderQuantity;
    private double orderPrice;
    private String title;
    private String author;

    public OrderDetail() {
    }

    public OrderDetail(int bookId, int orderQuantity, double orderPrice) {
        this.bookId = bookId;
        this.orderQuantity = orderQuantity;
        this.orderPrice = orderPrice;
    }

    public int getBookId() { return bookId; }
    public int getOrderQuantity() { return orderQuantity; }
    public double getOrderPrice() { return orderPrice; }

    public void setBookId(int bookId) { this.bookId = bookId; }
    public void setOrderQuantity(int orderQuantity) { this.orderQuantity = orderQuantity; }
    public void setOrderPrice(double orderPrice) { this.orderPrice = orderPrice; }

    // getters/setters
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
}
