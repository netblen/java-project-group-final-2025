package com.example.project.dao;

import com.example.project.model.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDao {
    private final Connection conn;

    public BookDao(Connection conn) {
        this.conn = conn;
    }

    public void add(Book book) throws SQLException {
        String sql = "INSERT INTO Books VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, book.getBookId());
        stmt.setString(2, book.getTitle());
        stmt.setString(3, book.getAuthor());
        stmt.setString(4, book.getGenre());
        stmt.setDouble(5, book.getBookPrice());
        stmt.setInt(6, book.getStock());
        stmt.setBoolean(7, book.isAvailable());
        stmt.executeUpdate();
        stmt.close();
    }

    public List<Book> listAll() throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM Books";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            books.add(new Book(
                    rs.getInt("bookId"),
                    rs.getString("title"),
                    rs.getString("author"),
                    rs.getString("genre"),
                    rs.getDouble("bookPrice"),
                    rs.getInt("stock"),
                    rs.getBoolean("isAvailable")
            ));
        }
        stmt.close();
        return books;
    }

    public void delete(int bookId) throws SQLException {
        String sql = "DELETE FROM Books WHERE bookId = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, bookId);
        stmt.executeUpdate();
        stmt.close();
    }

    public void updatePrice(int bookId, double newPrice) throws SQLException {
        String sql = "UPDATE Books SET bookPrice = ? WHERE bookId = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setDouble(1, newPrice);
        stmt.setInt(2, bookId);
        stmt.executeUpdate();
        stmt.close();
    }
}
