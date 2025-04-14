package com.example.project.dao.impl;

import com.example.project.dao.ShoppingCartDao;
import com.example.project.model.ShoppingCart;
import java.sql.*;

public class ShoppingCartDaoimpl implements ShoppingCartDao {
    private final Connection conn;

    public ShoppingCartDaoimpl(Connection conn) {
        this.conn = conn;
    }

    public void createCart(int customerId) {
        try {
            String sql = "INSERT INTO ShoppingCart (customerId) VALUES (?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ShoppingCart getCartByCustomerId(int customerId) {
        ShoppingCart cart = null;
        try {
            String sql = "SELECT * FROM ShoppingCart WHERE customerId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                cart = new ShoppingCart(
                        rs.getInt("cartId"),
                        rs.getInt("customerId"),
                        rs.getTimestamp("createdAt")
                );
            }
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cart;
    }

    public int getCartIdByCustomerId(int customerId) {
        int cartId = -1;
        try {
            String sql = "SELECT cartId FROM ShoppingCart WHERE customerId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                cartId = rs.getInt("cartId");
            }
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartId;
    }

    public void deleteCart(int cartId) {
        try {
            String sql = "DELETE FROM ShoppingCart WHERE cartId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartId);
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
