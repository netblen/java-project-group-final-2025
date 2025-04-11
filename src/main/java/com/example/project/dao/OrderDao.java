package com.example.project.dao;

import com.example.project.model.Order;
import com.example.project.model.OrderDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {
    private final Connection conn;

    public OrderDao(Connection conn) {
        this.conn = conn;
    }

    public void placeOrder(Order order) throws SQLException {
        String orderSql = "INSERT INTO Orders (customerId, totalPrice, orderDate, orderStatus) VALUES (?, ?, ?, ?)";
        PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
        orderStmt.setInt(1, order.getCustomerId());
        orderStmt.setDouble(2, order.getTotalPrice());
        orderStmt.setTimestamp(3, order.getOrderDate());
        orderStmt.setString(4, order.getOrderStatus());
        orderStmt.executeUpdate();

        ResultSet keys = orderStmt.getGeneratedKeys();
        int orderId = -1;
        if (keys.next()) {
            orderId = keys.getInt(1);
        }
        orderStmt.close();

        // Insert each book in the order
        for (OrderDetail item : order.getDetails()) {
            String itemSql = "INSERT INTO Order_Details (orderId, bookId, orderQuantity, orderPrice) VALUES (?, ?, ?, ?)";
            try (PreparedStatement itemStmt = conn.prepareStatement(itemSql)) {
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, item.getBookId());
                itemStmt.setInt(3, item.getOrderQuantity());
                itemStmt.setDouble(4, item.getOrderPrice());
                itemStmt.executeUpdate();
            }
        }

        System.out.println("✅ Order placed with ID: " + orderId);
    }

    public List<Order> getOrdersByCustomerId(int customerId) throws SQLException {
        List<Order> orders = new ArrayList<>();

        String sql = "SELECT * FROM Orders WHERE customerId = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, customerId);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            int orderId = rs.getInt("orderId");

            List<OrderDetail> details = new ArrayList<>();
            String detailSql = "SELECT * FROM Order_Details WHERE orderId = ?";
            PreparedStatement detailStmt = conn.prepareStatement(detailSql);
            detailStmt.setInt(1, orderId);
            ResultSet drs = detailStmt.executeQuery();
            while (drs.next()) {
                details.add(new OrderDetail(
                        drs.getInt("bookId"),
                        drs.getInt("orderQuantity"),
                        drs.getDouble("orderPrice")
                ));
            }

            Order order = new Order(
                    orderId,
                    rs.getInt("customerId"),
                    rs.getDouble("totalPrice"),
                    rs.getTimestamp("orderDate"),
                    rs.getString("orderStatus"),
                    details
            );

            orders.add(order);
            detailStmt.close();
        }

        stmt.close();
        return orders;
    }
}
