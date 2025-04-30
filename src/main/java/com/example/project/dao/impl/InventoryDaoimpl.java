package com.example.project.dao.impl;

import com.example.project.dao.InventoryDao;
import com.example.project.model.Inventory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class InventoryDaoimpl implements InventoryDao {
    private final Connection conn;

    public InventoryDaoimpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public void updateStock(int bookId, int newQuantity) throws SQLException {
        String sql = "UPDATE Inventory SET inventoryQuantity = ? WHERE bookId = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, newQuantity);
            stmt.setInt(2, bookId);
            stmt.executeUpdate();
        }
    }

    @Override
    public Inventory getInventory(int bookId) throws SQLException {
        String sql = "SELECT * FROM Inventory WHERE bookId = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Inventory(bookId, rs.getInt("inventoryQuantity"));
                }
            }
        }
        return null;
    }
}

