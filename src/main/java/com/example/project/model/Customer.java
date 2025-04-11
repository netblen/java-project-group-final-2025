package com.example.project.model;

public class Customer {
    private int customerId;
    private String name;
    private String email;
    private String password;
    private String userType;

    // Constructor
    public Customer(int customerId, String name, String email, String password, String userType) {
        this.customerId = customerId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.userType = userType;
    }

    // Getters
    public int getCustomerId() { return customerId; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public String getUserType() { return userType; }

    // Setters
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }
    public void setUserType(String userType) { this.userType = userType; }
}
