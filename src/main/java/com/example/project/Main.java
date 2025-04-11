package com.example.project;

import com.example.project.api.BookApiServer;
import com.example.project.api.BookApiService;
import com.example.project.dao.BookDao;
import com.example.project.dao.OrderDao;
import com.example.project.database.DbConnection;
import com.example.project.model.Book;
import com.example.project.model.Order;
import com.example.project.model.OrderDetail;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        try {
            // Connect to the H2 database
            Connection conn = DriverManager.getConnection("jdbc:h2:file:./bookstore", "sa", "");

            // Initialize the database from schema + data
            DbConnection.initializeDatabase(conn);
            System.out.println("✅ Database initialized successfully.");

            // ----------------- BOOKS ------------------
            BookDao bookDao = new BookDao(conn);

            // Fetch a book from Google Books API
            Book apiBook = BookApiService.fetchBookFromGoogle("Java Programming");

            // Save the fetched book to the database
            bookDao.add(apiBook);

            // Confirm book added
            System.out.println("📚 Book fetched from API and saved:");
            System.out.println("Title: " + apiBook.getTitle());
            System.out.println("Author: " + apiBook.getAuthor());

            // List all books
            System.out.println("\n📘 All books in database:");
            List<Book> allBooks = bookDao.listAll();
            for (Book b : allBooks) {
                System.out.println("- " + b.getTitle() + " by " + b.getAuthor() + " | Genres: " + String.join(", ", b.getGenres()));
            }

            // ----------------- ORDERS ------------------
            OrderDao orderDao = new OrderDao(conn);

            // Place an order using some of the books in the DB
            if (allBooks.size() >= 2) {
                List<OrderDetail> items = Arrays.asList(
                        new OrderDetail(allBooks.get(0).getBookId(), 1, allBooks.get(0).getBookPrice()),
                        new OrderDetail(allBooks.get(1).getBookId(), 2, allBooks.get(1).getBookPrice())
                );

                Order testOrder = new Order(
                        0,
                        1, // Assuming customerId 1 exists in your DB
                        allBooks.get(0).getBookPrice() + (2 * allBooks.get(1).getBookPrice()),
                        new Timestamp(System.currentTimeMillis()),
                        "Processing",
                        items
                );

                orderDao.placeOrder(testOrder);
            }

            // ✅ Start the backend API server
            BookApiServer.start(conn);

        } catch (Exception e) {
            System.err.println("❌ Error:");
            e.printStackTrace();
        }
    }
}
