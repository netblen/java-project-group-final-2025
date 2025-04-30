package com.example.project.dao.impl;

import com.example.project.dao.AdminDao;
import com.example.project.model.Admin;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDaoimpl implements AdminDao {
    private final Connection conn;

    public AdminDaoimpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public void logAction(String actionType) throws SQLException {
        String sql = "INSERT INTO Admin (actionType) VALUES (?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, actionType);
            stmt.executeUpdate();
        }
    }

    @Override
    public List<Admin> getAllLogs() throws SQLException {
        List<Admin> logs = new ArrayList<>();
        String sql = "SELECT * FROM Admin ORDER BY actionDate DESC";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                logs.add(new Admin(
                        rs.getInt("adminId"),
                        rs.getString("actionType"),
                        rs.getTimestamp("actionDate")
                ));
            }
        }
        return logs;
    }
}

