package com.example.project.dao.impl;

import com.example.project.dao.BookDAO;
import com.example.project.model.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDaoimpl implements BookDAO {
    private final Connection conn;

    public BookDaoimpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public List<Book> listAll() {
        List<Book> books = new ArrayList<>();
        String bookSql = "SELECT * FROM Books";
        String genreSql = """
            SELECT g.genreName FROM Genre g
            JOIN Book_Genres bg ON g.genreId = bg.genreId
            WHERE bg.bookId = ?
            """;

        try (PreparedStatement bookStmt = conn.prepareStatement(bookSql);
             ResultSet rs = bookStmt.executeQuery()) {

            while (rs.next()) {
                int bookId = rs.getInt("bookId");

                List<String> genres = new ArrayList<>();
                try (PreparedStatement genreStmt = conn.prepareStatement(genreSql)) {
                    genreStmt.setInt(1, bookId);
                    try (ResultSet grs = genreStmt.executeQuery()) {
                        while (grs.next()) {
                            genres.add(grs.getString("genreName"));
                        }
                    }
                }

                Book book = new Book(
                        bookId,
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getDouble("bookPrice"),
                        rs.getInt("stock"),
                        rs.getBoolean("isAvailable"),
                        genres
                );
                books.add(book);
            }

        } catch (SQLException e) {
            System.err.println("Error listing books: " + e.getMessage());
            e.printStackTrace();
        }

        return books;
    }

    @Override
    public Book findByCode(String code) {
        try {
            int bookId = Integer.parseInt(code);
            String sql = "SELECT * FROM Books WHERE bookId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, bookId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        List<String> genres = new ArrayList<>();
                        String genreSql = """
                            SELECT g.genreName FROM Genre g
                            JOIN Book_Genres bg ON g.genreId = bg.genreId
                            WHERE bg.bookId = ?
                            """;
                        try (PreparedStatement genreStmt = conn.prepareStatement(genreSql)) {
                            genreStmt.setInt(1, bookId);
                            try (ResultSet grs = genreStmt.executeQuery()) {
                                while (grs.next()) {
                                    genres.add(grs.getString("genreName"));
                                }
                            }
                        }

                        return new Book(
                                bookId,
                                rs.getString("title"),
                                rs.getString("author"),
                                rs.getDouble("bookPrice"),
                                rs.getInt("stock"),
                                rs.getBoolean("isAvailable"),
                                genres
                        );
                    }
                }
            }
        } catch (NumberFormatException | SQLException e) {
            System.err.println("Error finding book by code: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean save(Book book) {
        if (findByCode(String.valueOf(book.getBookId())) != null) {
            updatePrice(book.getBookId(), book.getBookPrice());
            return true;
        } else {
            add(book);
            return true;
        }
    }

    @Override
    public boolean delete(String code) {
        try {
            int bookId = Integer.parseInt(code);
            delete(bookId);
            return true;
        } catch (NumberFormatException e) {
            System.err.println("Invalid book ID format: " + code);
            return false;
        }
    }

    public void delete(int bookId) {
        String sql = "DELETE FROM Books WHERE bookId = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error deleting book: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void updatePrice(int bookId, double newPrice) {
        String sql = "UPDATE Books SET bookPrice = ? WHERE bookId = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDouble(1, newPrice);
            stmt.setInt(2, bookId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error updating book price: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void add(Book book) {
        try {
            String sql = "INSERT INTO Books (bookId, title, author, bookPrice, stock, isAvailable) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, book.getBookId());
                stmt.setString(2, book.getTitle());
                stmt.setString(3, book.getAuthor());
                stmt.setDouble(4, book.getBookPrice());
                stmt.setInt(5, book.getStock());
                stmt.setBoolean(6, book.isAvailable());
                stmt.executeUpdate();
            }

            for (String genreName : book.getGenres()) {
                int genreId = getOrCreateGenreId(genreName);

                String relSql = "INSERT INTO Book_Genres (bookId, genreId) VALUES (?, ?)";
                try (PreparedStatement relStmt = conn.prepareStatement(relSql)) {
                    relStmt.setInt(1, book.getBookId());
                    relStmt.setInt(2, genreId);
                    relStmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            System.err.println("Error adding book: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private int getOrCreateGenreId(String genreName) {
        String selectSql = "SELECT genreId FROM Genre WHERE genreName = ?";
        try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
            selectStmt.setString(1, genreName);
            try (ResultSet rs = selectStmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("genreId");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error finding genre: " + e.getMessage());
            e.printStackTrace();
        }

        String insertSql = "INSERT INTO Genre (genreName) VALUES (?)";
        try (PreparedStatement insertStmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            insertStmt.setString(1, genreName);
            insertStmt.executeUpdate();

            try (ResultSet keys = insertStmt.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error inserting genre: " + e.getMessage());
            e.printStackTrace();
        }

        return -1;
    }
    public void update(Book book) {
        String sql = "UPDATE Books SET title = ?, author = ?, bookPrice = ?, stock = ?, isAvailable = ? WHERE bookId = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setDouble(3, book.getBookPrice());
            stmt.setInt(4, book.getStock());
            stmt.setBoolean(5, book.isAvailable());
            stmt.setInt(6, book.getBookId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
