package com.example.project.dao;

import com.example.project.model.Inventory;

import java.sql.*;

public class InventoryDao {
    private final Connection conn;

    public InventoryDao(Connection conn) {
        this.conn = conn;
    }

    public void updateStock(int bookId, int newQuantity) throws SQLException {
        String sql = "UPDATE Inventory SET inventoryQuantity = ? WHERE bookId = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, newQuantity);
        stmt.setInt(2, bookId);
        stmt.executeUpdate();
        stmt.close();
    }

    public Inventory getInventory(int bookId) throws SQLException {
        String sql = "SELECT * FROM Inventory WHERE bookId = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, bookId);
        ResultSet rs = stmt.executeQuery();
        Inventory inv = null;
        if (rs.next()) {
            inv = new Inventory(bookId, rs.getInt("inventoryQuantity"));
        }
        stmt.close();
        return inv;
    }
}
