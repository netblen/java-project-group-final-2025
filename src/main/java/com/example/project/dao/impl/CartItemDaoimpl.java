package com.example.project.dao.impl;

import com.example.project.model.CartItem;
import com.example.project.dao.CartItemDao;
import com.example.project.model.CartItemDetails;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartItemDaoimpl implements CartItemDao {
    private final Connection conn;

    public CartItemDaoimpl(Connection conn) {
        this.conn = conn;
    }

    public void addItem(CartItem item) {
        try {
            String sql = "INSERT INTO ShoppingCart_Items (cartId, bookId, shoppingCartQuantity) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, item.getCartId());
            stmt.setInt(2, item.getBookId());
            stmt.setInt(3, item.getQuantity());
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<CartItem> getItemsInCart(int cartId) {
        List<CartItem> items = new ArrayList<>();
        try {
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    public void removeItem(int cartId, int bookId) {
        try {
            String sql = "DELETE FROM ShoppingCart_Items WHERE cartId = ? AND bookId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartId);
            stmt.setInt(2, bookId);
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateQuantity(int cartId, int bookId, int newQty) {
        try {
            String sql = "UPDATE ShoppingCart_Items SET shoppingCartQuantity = ? WHERE cartId = ? AND bookId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, newQty);
            stmt.setInt(2, cartId);
            stmt.setInt(3, bookId);
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete entire cart
    public void clearCart(int cartId) {
        try {
            String sql = "DELETE FROM ShoppingCart_Items WHERE cartId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartId);
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Check if an item already exists in the cart
    public boolean itemExists(int cartId, int bookId) {
        boolean exists = false;
        try {
            String sql = "SELECT COUNT(*) FROM ShoppingCart_Items WHERE cartId = ? AND bookId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartId);
            stmt.setInt(2, bookId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exists;
    }

    // Get current quantity of a book in cart
    public int getQuantity(int cartId, int bookId) {
        int qty = 0;
        try {
            String sql = "SELECT shoppingCartQuantity FROM ShoppingCart_Items WHERE cartId = ? AND bookId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartId);
            stmt.setInt(2, bookId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                qty = rs.getInt("shoppingCartQuantity");
            }
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return qty;
    }

    public List<CartItemDetails> getDetailedItemsInCart(int cartId) {
        List<CartItemDetails> items = new ArrayList<>();
        String sql = """
                    SELECT sci.bookId, b.title, b.author, b.bookprice, sci.shoppingCartQuantity
                    FROM ShoppingCart_Items sci
                    JOIN Books b ON sci.bookId = b.bookid
                    WHERE sci.cartId = ?
                """;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                items.add(new CartItemDetails(
                        rs.getInt("bookId"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getInt("shoppingCartQuantity"),
                        rs.getDouble("bookprice")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    public int getAvailableStock(int bookId) {
        int stock = 0;
        try {
            String sql = "SELECT INVENTORYQUANTITY FROM Inventory WHERE bookId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                stock = rs.getInt("INVENTORYQUANTITY");
            }
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stock;
    }
}