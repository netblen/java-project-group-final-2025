package com.example.project.dao;

import com.example.project.model.Admin;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDao {
    private final Connection conn;

    public AdminDao(Connection conn) {
        this.conn = conn;
    }

    public void logAction(String actionType) throws SQLException {
        String sql = "INSERT INTO Admin (actionType) VALUES (?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, actionType);
        stmt.executeUpdate();
        stmt.close();
    }

    public List<Admin> getAllLogs() throws SQLException {
        List<Admin> logs = new ArrayList<>();
        String sql = "SELECT * FROM Admin ORDER BY actionDate DESC";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            logs.add(new Admin(
                    rs.getInt("adminId"),
                    rs.getString("actionType"),
                    rs.getTimestamp("actionDate")
            ));
        }
        stmt.close();
        return logs;
    }
}
