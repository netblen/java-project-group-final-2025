package com.example.project.dao;

import com.example.project.model.Inventory;

import java.sql.SQLException;

public interface InventoryDao {
    void updateStock(int bookId, int newQuantity) throws SQLException;
    Inventory getInventory(int bookId) throws SQLException;
}
