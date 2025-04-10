package com.example.project.model;

public class Customer {
    private int customerId;
    private String customerName;
    private String customerEmail;
    private String customerPassword;
    private String userType;

    //Setters
    public Customer(int customerId, String customerName, String customerEmail, String customerPassword, String userType) {
        this.customerId = customerId;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.customerPassword = customerPassword;
        this.userType = userType;
    }

    //Getters
    public int getCustomerId() {return customerId;}
    public String getCustomerName() {return customerName;}
    public String getCustomerEmail() {return customerEmail;}
    public String getCustomerPassword() {return customerPassword;}
    public String getUserType() {return userType;}

}
