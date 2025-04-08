package com.example.project;

import com.example.project.database.DbConnection;
import com.example.project.api.BookApiService;
import com.example.project.api.BookApiServer;
import com.example.project.dao.BookDao;
import com.example.project.model.Book;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        try {
            // Connect to the H2 database
            //Connection conn = DriverManager.getConnection("jdbc:h2:./bookstore", "sa", "");
            Connection conn = DriverManager.getConnection("jdbc:h2:file:./bookstore", "sa", "");

            // Initialize the database from schema.sql
            DbConnection.initializeDatabase(conn);
            System.out.println("✅ Database initialized successfully.");

            // Create DAO instance
            BookDao bookDao = new BookDao(conn);

            // Fetch a book from Google Books API
            Book apiBook = BookApiService.fetchBookFromGoogle("Java Programming");

            // Save the fetched book to the database
            bookDao.add(apiBook);

            // Print confirmation
            System.out.println("📚 Book fetched from API and saved:");
            System.out.println("Title: " + apiBook.getTitle());
            System.out.println("Author: " + apiBook.getAuthor());

            // Print all books
            System.out.println("\n📘 All books in database:");
            List<Book> allBooks = bookDao.listAll();
            for (Book b : allBooks) {
                System.out.println("- " + b.getTitle() + " by " + b.getAuthor());
            }

            // ✅ Start the backend API server
            // Al final de tu main, agrega esto:
            BookApiServer.start(conn);

        } catch (Exception e) {
            System.err.println("❌ Error:");
            e.printStackTrace();
        }
    }
}
