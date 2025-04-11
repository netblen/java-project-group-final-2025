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

    // Add book and its genres
    public void add(Book book) throws SQLException {
        // Insert book
        String sql = "INSERT INTO Books (bookId, title, author, bookPrice, stock, isAvailable) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, book.getBookId());
        stmt.setString(2, book.getTitle());
        stmt.setString(3, book.getAuthor());
        stmt.setDouble(4, book.getBookPrice());
        stmt.setInt(5, book.getStock());
        stmt.setBoolean(6, book.isAvailable());
        stmt.executeUpdate();
        stmt.close();

        // Insert genres (if not exist) and link in Book_Genres
        for (String genreName : book.getGenres()) {
            int genreId = getOrCreateGenreId(genreName);

            String relSql = "INSERT INTO Book_Genres (bookId, genreId) VALUES (?, ?)";
            try (PreparedStatement relStmt = conn.prepareStatement(relSql)) {
                relStmt.setInt(1, book.getBookId());
                relStmt.setInt(2, genreId);
                relStmt.executeUpdate();
            }
        }
    }

    // List all books with genres
    public List<Book> listAll() throws SQLException {
        List<Book> books = new ArrayList<>();
        String bookSql = "SELECT * FROM Books";
        String genreSql = """
            SELECT g.genreName FROM Genre g
            JOIN Book_Genres bg ON g.genreId = bg.genreId
            WHERE bg.bookId = ?
            """;

        PreparedStatement bookStmt = conn.prepareStatement(bookSql);
        ResultSet rs = bookStmt.executeQuery();

        while (rs.next()) {
            int bookId = rs.getInt("bookId");

            // Fetch genres
            List<String> genres = new ArrayList<>();
            PreparedStatement genreStmt = conn.prepareStatement(genreSql);
            genreStmt.setInt(1, bookId);
            ResultSet grs = genreStmt.executeQuery();
            while (grs.next()) {
                genres.add(grs.getString("genreName"));
            }
            genreStmt.close();

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

        bookStmt.close();
        return books;
    }

    // Delete a book
    public void delete(int bookId) throws SQLException {
        String sql = "DELETE FROM Books WHERE bookId = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, bookId);
        stmt.executeUpdate();
        stmt.close();
    }

    // Update price
    public void updatePrice(int bookId, double newPrice) throws SQLException {
        String sql = "UPDATE Books SET bookPrice = ? WHERE bookId = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setDouble(1, newPrice);
        stmt.setInt(2, bookId);
        stmt.executeUpdate();
        stmt.close();
    }

    // Helper to get or insert genre
    private int getOrCreateGenreId(String genreName) throws SQLException {
        String selectSql = "SELECT genreId FROM Genre WHERE genreName = ?";
        PreparedStatement selectStmt = conn.prepareStatement(selectSql);
        selectStmt.setString(1, genreName);
        ResultSet rs = selectStmt.executeQuery();

        if (rs.next()) {
            int id = rs.getInt("genreId");
            selectStmt.close();
            return id;
        }
        selectStmt.close();

        String insertSql = "INSERT INTO Genre (genreName) VALUES (?)";
        PreparedStatement insertStmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
        insertStmt.setString(1, genreName);
        insertStmt.executeUpdate();

        ResultSet keys = insertStmt.getGeneratedKeys();
        int genreId = -1;
        if (keys.next()) {
            genreId = keys.getInt(1);
        }
        insertStmt.close();
        return genreId;
    }
}
