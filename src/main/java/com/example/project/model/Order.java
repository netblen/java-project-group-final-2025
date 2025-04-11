package com.example.project.model;

import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int orderId;
    private int customerId;
    private double totalPrice;
    private Timestamp orderDate;
    private String orderStatus;
    private List<OrderDetail> details;

    public Order(int orderId, int customerId, double totalPrice, Timestamp orderDate, String orderStatus, List<OrderDetail> details) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.details = details;
    }

    public int getOrderId() { return orderId; }
    public int getCustomerId() { return customerId; }
    public double getTotalPrice() { return totalPrice; }
    public Timestamp getOrderDate() { return orderDate; }
    public String getOrderStatus() { return orderStatus; }
    public List<OrderDetail> getDetails() { return details; }
}


