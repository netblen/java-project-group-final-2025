package com.example.project.dao;

import com.example.project.model.ShoppingCart;
import java.sql.*;

public class ShoppingCartDao {
    private final Connection conn;

    public ShoppingCartDao(Connection conn) {
        this.conn = conn;
    }

    public void createCart(int customerId) throws SQLException {
        String sql = "INSERT INTO ShoppingCart (customerId) VALUES (?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, customerId);
        stmt.executeUpdate();
        stmt.close();
    }

    public ShoppingCart getCartByCustomerId(int customerId) throws SQLException {
        String sql = "SELECT * FROM ShoppingCart WHERE customerId = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, customerId);
        ResultSet rs = stmt.executeQuery();
        ShoppingCart cart = null;
        if (rs.next()) {
            cart = new ShoppingCart(
                    rs.getInt("cartId"),
                    rs.getInt("customerId"),
                    rs.getTimestamp("createdAt")
            );
        }
        stmt.close();
        return cart;
    }

    public void deleteCart(int cartId) throws SQLException {
        String sql = "DELETE FROM ShoppingCart WHERE cartId = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, cartId);
        stmt.executeUpdate();
        stmt.close();
    }
}
