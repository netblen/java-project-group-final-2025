package com.example.project.db;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class SchemaInitializer {

    public static void initializeSchema() {
        Connection conn = null;
        try {
            conn = DbUtil.getConnection();
            Statement stmt = conn.createStatement();

            // CUSTOMER
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS Customer (
                    customerId INT PRIMARY KEY AUTO_INCREMENT,
                    name VARCHAR(100) NOT NULL,
                    email VARCHAR(100) UNIQUE NOT NULL,
                    password VARCHAR(255) NOT NULL,
                    userType VARCHAR(50) NOT NULL
                )
            """);

            // BOOKS
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS Books (
                    bookId INT PRIMARY KEY AUTO_INCREMENT,
                    title VARCHAR(255) NOT NULL,
                    author VARCHAR(255) NOT NULL,
                    bookPrice DECIMAL(10,2) NOT NULL,
                    stock INT NOT NULL DEFAULT 0,
                    isAvailable BOOLEAN DEFAULT TRUE
                )
            """);

            // GENRE
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS Genre (
                    genreId INT PRIMARY KEY AUTO_INCREMENT,
                    genreName VARCHAR(100) NOT NULL
                )
            """);

            // BOOK-GENRES
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS Book_Genres (
                    bookId INT,
                    genreId INT,
                    PRIMARY KEY (bookId, genreId),
                    FOREIGN KEY (bookId) REFERENCES Books(bookId) ON DELETE CASCADE,
                    FOREIGN KEY (genreId) REFERENCES Genre(genreId) ON DELETE CASCADE
                )
            """);

            // INVENTORY
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS Inventory (
                    bookId INT PRIMARY KEY,
                    inventoryQuantity INT NOT NULL,
                    FOREIGN KEY (bookId) REFERENCES Books(bookId) ON DELETE CASCADE
                )
            """);

            // ADMIN ACTION LOG
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS Admin (
                    adminId INT PRIMARY KEY AUTO_INCREMENT,
                    actionType VARCHAR(100) NOT NULL,
                    actionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            """);

            // ORDERS
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS Orders (
                    orderId INT PRIMARY KEY AUTO_INCREMENT,
                    customerId INT,
                    totalPrice DECIMAL(10,2),
                    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    orderStatus ENUM('PLACED', 'PREPARING', 'COMPLETED', 'CANCELLED') NOT NULL,
                    FOREIGN KEY (customerId) REFERENCES Customer(customerId) ON DELETE SET NULL
                )
            """);

            // ORDER DETAILS
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS Order_Details (
                    orderId INT,
                    bookId INT,
                    orderQuantity INT NOT NULL,
                    orderPrice DECIMAL(10,2),
                    PRIMARY KEY (orderId, bookId),
                    FOREIGN KEY (orderId) REFERENCES Orders(orderId) ON DELETE CASCADE,
                    FOREIGN KEY (bookId) REFERENCES Books(bookId) ON DELETE CASCADE
                )
            """);

            // SHOPPING CART
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS ShoppingCart (
                    cartId INT PRIMARY KEY AUTO_INCREMENT,
                    customerId INT,
                    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (customerId) REFERENCES Customer(customerId) ON DELETE CASCADE
                )
            """);

            // SHOPPING CART ITEMS
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS ShoppingCart_Items (
                    cartId INT,
                    bookId INT,
                    shoppingCartQuantity INT NOT NULL,
                    PRIMARY KEY (cartId, bookId),
                    FOREIGN KEY (cartId) REFERENCES ShoppingCart(cartId) ON DELETE CASCADE,
                    FOREIGN KEY (bookId) REFERENCES Books(bookId) ON DELETE CASCADE
                )
            """);

            System.out.println("Schema initialized successfully.");

        } catch (SQLException e) {
            System.err.println("Schema initialization error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbUtil.closeQuietly(conn);
        }
    }

    public static void insertSampleData() {
        Connection conn = null;
        try {
            conn = DbUtil.getConnection();
            Statement stmt = conn.createStatement();

            // Sample Customers
            stmt.execute("""
                MERGE INTO Customer (name, email, password, userType)
                KEY(email) VALUES
                ('Alice Johnson', 'alice@example.com', 'alice123', 'user'),
                ('Bob Brown', 'bob@example.com', 'bob123', 'user'),
                ('Main Admin', 'admin@bookmaster.com', 'admin123', 'admin')
            """);

            // Sample Books
            stmt.execute("""
                MERGE INTO Books (title, author, bookPrice, stock, isAvailable)
                KEY(title) VALUES
                ('1984', 'George Orwell', 12.99, 10, TRUE),
                ('Brave New World', 'Aldous Huxley', 11.50, 5, TRUE),
                ('The Great Gatsby', 'F. Scott Fitzgerald', 10.75, 8, TRUE)
            """);

            // Sample Genres
            stmt.execute("""
                MERGE INTO Genre (genreName)
                KEY(genreName) VALUES
                ('Science Fiction'),
                ('Classic'),
                ('Horror')
            """);

            // Book-Genre associations
            stmt.execute("""
                MERGE INTO Book_Genres (bookId, genreId)
                KEY(bookId, genreId) VALUES
                (1, 3),
                (1, 2),
                (2, 1),
                (3, 2)
            """);

            // Inventory entries
            stmt.execute("""
                MERGE INTO Inventory (bookId, inventoryQuantity)
                KEY(bookId) VALUES
                (1, 10),
                (2, 5),
                (3, 8)
            """);

            // Sample Orders
            stmt.execute("""
                INSERT INTO Orders (customerId, totalPrice, orderStatus)
                VALUES
                (1, 27.49, 'PLACED'),
                (2, 12.50, 'PREPARING')
            """);

            // Shopping Carts
            stmt.execute("""
                INSERT INTO ShoppingCart (customerId)
                VALUES
                (1),
                (2)
            """);

            // Shopping Cart Items
            stmt.execute("""
                MERGE INTO ShoppingCart_Items (cartId, bookId, shoppingCartQuantity)
                VALUES
                (1, 2, 1),
                (2, 1, 2)
            """);

            System.out.println("Sample data inserted successfully.");

        } catch (SQLException e) {
            System.err.println("Sample data insertion error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbUtil.closeQuietly(conn);
        }
    }

    public static void dropTables() {
        Connection conn = null;
        try {
            conn = DbUtil.getConnection();
            Statement stmt = conn.createStatement();

            System.out.println("Dropping existing tables...");

            stmt.execute("DROP TABLE IF EXISTS ShoppingCart_Items");
            stmt.execute("DROP TABLE IF EXISTS ShoppingCart");
            stmt.execute("DROP TABLE IF EXISTS Order_Details");
            stmt.execute("DROP TABLE IF EXISTS Orders");
            stmt.execute("DROP TABLE IF EXISTS Admin");
            stmt.execute("DROP TABLE IF EXISTS Inventory");
            stmt.execute("DROP TABLE IF EXISTS Book_Genres");
            stmt.execute("DROP TABLE IF EXISTS Genre");
            stmt.execute("DROP TABLE IF EXISTS Books");
            stmt.execute("DROP TABLE IF EXISTS Customer");

            System.out.println("All tables dropped successfully.");

        } catch (SQLException e) {
            System.err.println("Error dropping tables: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbUtil.closeQuietly(conn);
        }
    }

    public static void main(String[] args) {
        dropTables();
        initializeSchema();
        insertSampleData();
    }
}
