package com.example.project.db;

import java.sql.*;
import java.time.LocalDateTime;

public class DbTest {

    public static void main(String[] args) {
        // 1. Initialize schema and insert sample data
        SchemaInitializer.initializeSchema();
        SchemaInitializer.insertSampleData();

        // 2. Insert test customer
        insertTestCustomer();

        // 3. Create a test order with books
        createTestOrder();

        // 4. Verify test data
        verifyTestData();
    }

    private static void insertTestCustomer() {
        Connection conn = null;
        try {
            conn = DbUtil.getConnection();
            PreparedStatement checkStmt = conn.prepareStatement(
                    "SELECT COUNT(*) FROM Customer WHERE email = ?");
            checkStmt.setString(1, "test@bookstore.com");
            ResultSet rs = checkStmt.executeQuery();
            rs.next();

            if (rs.getInt(1) == 0) {
                PreparedStatement insertStmt = conn.prepareStatement(
                        "INSERT INTO Customer (name, email, password, userType) VALUES (?, ?, ?, ?)");
                insertStmt.setString(1, "Test Customer");
                insertStmt.setString(2, "test@bookstore.com");
                insertStmt.setString(3, "testpass123");
                insertStmt.setString(4, "user");
                insertStmt.executeUpdate();

                System.out.println("Test customer inserted.");
            } else {
                System.out.println("Test customer already exists.");
            }

        } catch (SQLException e) {
            System.err.println("Error inserting test customer: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbUtil.closeQuietly(conn);
        }
    }

    private static void createTestOrder() {
        Connection conn = null;
        try {
            conn = DbUtil.getConnection();

            // Get customerId
            PreparedStatement getCustomer = conn.prepareStatement(
                    "SELECT customerId FROM Customer WHERE email = ?");
            getCustomer.setString(1, "test@bookstore.com");
            ResultSet custRs = getCustomer.executeQuery();

            if (!custRs.next()) {
                System.out.println("Test customer not found.");
                return;
            }
            int customerId = custRs.getInt("customerId");

            // Create order
            PreparedStatement insertOrder = conn.prepareStatement(
                    "INSERT INTO Orders (customerId, totalPrice, orderStatus, orderDate) VALUES (?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS);
            insertOrder.setInt(1, customerId);
            insertOrder.setDouble(2, 0.0); // initial
            insertOrder.setString(3, "PLACED");
            insertOrder.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
            insertOrder.executeUpdate();

            ResultSet orderKeys = insertOrder.getGeneratedKeys();
            if (!orderKeys.next()) throw new SQLException("Failed to retrieve order ID.");
            int orderId = orderKeys.getInt(1);

            // Add books
            PreparedStatement selectBooks = conn.prepareStatement(
                    "SELECT bookId, bookPrice FROM Books WHERE isAvailable = true LIMIT 2");
            ResultSet books = selectBooks.executeQuery();

            double total = 0.0;
            while (books.next()) {
                int bookId = books.getInt("bookId");
                double price = books.getDouble("bookPrice");
                int qty = 2;

                PreparedStatement orderItem = conn.prepareStatement(
                        "INSERT INTO Order_Details (orderId, bookId, orderQuantity, orderPrice) VALUES (?, ?, ?, ?)");
                orderItem.setInt(1, orderId);
                orderItem.setInt(2, bookId);
                orderItem.setInt(3, qty);
                orderItem.setDouble(4, price * qty);
                orderItem.executeUpdate();

                total += price * qty;
            }

            // Update order total
            PreparedStatement updateTotal = conn.prepareStatement(
                    "UPDATE Orders SET totalPrice = ? WHERE orderId = ?");
            updateTotal.setDouble(1, total);
            updateTotal.setInt(2, orderId);
            updateTotal.executeUpdate();

            System.out.println("Test order created. ID: " + orderId + " | Total: $" + total);

        } catch (SQLException e) {
            System.err.println("Error creating test order: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbUtil.closeQuietly(conn);
        }
    }

    private static void verifyTestData() {
        Connection conn = null;
        try {
            conn = DbUtil.getConnection();

            // Verify customer
            PreparedStatement userStmt = conn.prepareStatement(
                    "SELECT name FROM Customer WHERE email = ?");
            userStmt.setString(1, "test@bookstore.com");
            ResultSet rs = userStmt.executeQuery();

            if (rs.next()) {
                System.out.println("Verified customer: " + rs.getString("name"));
            } else {
                System.out.println("Test customer not found.");
            }

            // Verify latest order
            PreparedStatement orderStmt = conn.prepareStatement("""
                SELECT o.orderId, o.totalPrice, COUNT(od.bookId) AS items
                FROM Orders o
                JOIN Order_Details od ON o.orderId = od.orderId
                GROUP BY o.orderId, o.totalPrice
                ORDER BY o.orderId DESC LIMIT 1
            """);

            ResultSet orderRs = orderStmt.executeQuery();
            if (orderRs.next()) {
                System.out.println("\nLatest Order Summary:");
                System.out.println("Order ID: " + orderRs.getInt("orderId"));
                System.out.println("Total Price: $" + orderRs.getDouble("totalPrice"));
                System.out.println("Items: " + orderRs.getInt("items"));
            } else {
                System.out.println("No orders found.");
            }

        } catch (SQLException e) {
            System.err.println("Error verifying test data: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbUtil.closeQuietly(conn);
        }
    }
}
