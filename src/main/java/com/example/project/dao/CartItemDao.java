package com.example.project.dao;

import com.example.project.model.CartItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartItemDao {
    private final Connection conn;

    public CartItemDao(Connection conn) {
        this.conn = conn;
    }

    public void addItem(CartItem item) throws SQLException {
        String sql = "INSERT INTO ShoppingCart_Items (cartId, bookId, shoppingCartQuantity) VALUES (?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, item.getCartId());
        stmt.setInt(2, item.getBookId());
        stmt.setInt(3, item.getQuantity());
        stmt.executeUpdate();
        stmt.close();
    }

    public List<CartItem> getItemsInCart(int cartId) throws SQLException {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT * FROM ShoppingCart_Items WHERE cartId = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, cartId);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            items.add(new CartItem(
                    cartId,
                    rs.getInt("bookId"),
                    rs.getInt("shoppingCartQuantity")
            ));
        }
        stmt.close();
        return items;
    }

    public void removeItem(int cartId, int bookId) throws SQLException {
        String sql = "DELETE FROM ShoppingCart_Items WHERE cartId = ? AND bookId = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, cartId);
        stmt.setInt(2, bookId);
        stmt.executeUpdate();
        stmt.close();
    }

    public void updateQuantity(int cartId, int bookId, int newQty) throws SQLException {
        String sql = "UPDATE ShoppingCart_Items SET shoppingCartQuantity = ? WHERE cartId = ? AND bookId = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, newQty);
        stmt.setInt(2, cartId);
        stmt.setInt(3, bookId);
        stmt.executeUpdate();
        stmt.close();
    }
}
