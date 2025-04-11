package com.example.project.model;

import java.sql.Timestamp;

public class Admin {
    private int adminId;
    private String actionType;
    private Timestamp actionDate;

    // Constructor
    public Admin(int adminId, String actionType, Timestamp actionDate) {
        this.adminId = adminId;
        this.actionType = actionType;
        this.actionDate = actionDate;
    }

    // Getters
    public int getAdminId() { return adminId; }
    public String getActionType() { return actionType; }
    public Timestamp getActionDate() { return actionDate; }

    // Setters
    public void setAdminId(int adminId) { this.adminId = adminId; }
    public void setActionType(String actionType) { this.actionType = actionType; }
    public void setActionDate(Timestamp actionDate) { this.actionDate = actionDate; }
}
