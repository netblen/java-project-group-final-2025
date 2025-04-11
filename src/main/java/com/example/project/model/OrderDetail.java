package com.example.project.model;

public class OrderDetail {
    private int bookId;
    private int orderQuantity;
    private double orderPrice;

    public OrderDetail(int bookId, int orderQuantity, double orderPrice) {
        this.bookId = bookId;
        this.orderQuantity = orderQuantity;
        this.orderPrice = orderPrice;
    }

    public int getBookId() { return bookId; }
    public int getOrderQuantity() { return orderQuantity; }
    public double getOrderPrice() { return orderPrice; }
}
