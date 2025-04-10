package com.example.project.model;

import java.util.Date;

public class Order {
    private int orderId;
    private int customerId;
    private Double totalPrice;
    private Date orderDate;
    private boolean orderStatus;

    //Getters
    public Order(int orderId, int customerId, Double totalPrice, Date orderDate, boolean orderStatus){

        this.orderId = orderId;
        this.customerId = customerId;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
    }

    //Setters
    public int getOrderId() {return orderId;}
    public int getCustomerId() {return customerId;}
    public Double getTotalPrice() {return totalPrice;}
    public Date getOrderDate() {return orderDate;}
    public boolean isOrderStatus() {return orderStatus;}



}


