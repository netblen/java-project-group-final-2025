package com.example.project.dao.impl;

import com.example.project.dao.OrderDAO;
import com.example.project.model.Order;
import com.example.project.model.OrderDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDaoimpl implements OrderDAO {
    private final Connection conn;

    public OrderDaoimpl(Connection conn) {
        this.conn = conn;
    }

    public void placeOrder(Order order) {
        String orderSql = "INSERT INTO Orders (customerId, totalPrice, orderDate, orderStatus) VALUES (?, ?, ?, ?)";

        try (PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
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

            for (OrderDetail item : order.getDetails()) {
                createOrderDetail(item, orderId);
            }

            System.out.println("✅ Order placed with ID: " + orderId);

        } catch (SQLException e) {
            System.err.println("❌ Error placing order: " + e.getMessage());
        }
    }

    public List<Order> getOrdersByCustomerId(int customerId) {
        List<Order> orders = new ArrayList<>();

        String sql = "SELECT * FROM Orders WHERE customerId = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int orderId = rs.getInt("orderId");

                List<OrderDetail> details = new ArrayList<>();
                String detailSql = """
                            SELECT od.bookId, od.orderQuantity, od.orderPrice, b.title, b.author
                            FROM Order_Details od
                            JOIN Books b ON od.bookId = b.bookId
                            WHERE od.orderId = ?
                        """;

                try (PreparedStatement detailStmt = conn.prepareStatement(detailSql)) {
                    detailStmt.setInt(1, orderId);
                    ResultSet drs = detailStmt.executeQuery();

                    while (drs.next()) {
                        OrderDetail detail = new OrderDetail(
                                drs.getInt("bookId"),
                                drs.getInt("orderQuantity"),
                                drs.getDouble("orderPrice")
                        );

                        // 👇 Añade los nuevos campos
                        detail.setTitle(drs.getString("title"));
                        detail.setAuthor(drs.getString("author"));

                        details.add(detail);
                    }
                } catch (SQLException e) {
                    System.err.println("❌ Error fetching order details: " + e.getMessage());
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
            }

        } catch (SQLException e) {
            System.err.println("❌ Error fetching orders: " + e.getMessage());
        }

        return orders;
    }

    public void createOrderDetail(OrderDetail detail, int orderId) {
        String itemSql = "INSERT INTO Order_Details (orderId, bookId, orderQuantity, orderPrice) VALUES (?, ?, ?, ?)";
        try (PreparedStatement itemStmt = conn.prepareStatement(itemSql)) {
            itemStmt.setInt(1, orderId);
            itemStmt.setInt(2, detail.getBookId());
            itemStmt.setInt(3, detail.getOrderQuantity());
            itemStmt.setDouble(4, detail.getOrderPrice());
            itemStmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("❌ Error inserting order detail: " + e.getMessage());
        }
    }
}
