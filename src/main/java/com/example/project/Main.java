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
import java.util.logging.Level;
import java.util.logging.Logger;

public class Main {

    // Logger instance for this class
    private static final Logger logger = Logger.getLogger(Main.class.getName());

    public static void main(String[] args) {
        try {
            // 1. Connect to the H2 database (persistent file)
            Connection conn = DriverManager.getConnection("jdbc:h2:file:./bookstore", "sa", "");

            // 2. Initialize schema if needed
            DbConnection.initializeSchema(conn);

            // 3. Set up Book DAO
            BookDao bookDao = new BookDao(conn);

            // 4. Load test data ONLY if DB is empty
            if (bookDao.listAll().isEmpty()) {
                DbConnection.loadTestData(conn);
                logger.info("📦 Data seeded because database was empty.");
            } else {
                logger.info("📦 Data already exists — skipping seed.");
            }

            // 5. Fetch a book from Google Books API and save it
            Book apiBook = BookApiService.fetchBookFromGoogle("Java Programming");
            bookDao.add(apiBook);
            logger.info("📚 Book fetched from API and saved:\nTitle: " + apiBook.getTitle() + "\nAuthor: " + apiBook.getAuthor());

            // 6. List all books
            logger.info("\n📘 All books in database:");
            List<Book> allBooks = bookDao.listAll();
            for (Book b : allBooks) {
                logger.info("- " + b.getTitle() + " by " + b.getAuthor() + " | Genres: " + String.join(", ", b.getGenres()));
            }

            // 7. Place a test order
            OrderDao orderDao = new OrderDao(conn);
            if (allBooks.size() >= 2) {
                List<OrderDetail> items = Arrays.asList(
                        new OrderDetail(allBooks.get(0).getBookId(), 1, allBooks.get(0).getBookPrice()),
                        new OrderDetail(allBooks.get(1).getBookId(), 2, allBooks.get(1).getBookPrice())
                );

                Order testOrder = new Order(
                        0,
                        1, // Assuming customerId 1 exists
                        allBooks.get(0).getBookPrice() + (2 * allBooks.get(1).getBookPrice()),
                        new Timestamp(System.currentTimeMillis()),
                        "Processing",
                        items
                );

                orderDao.placeOrder(testOrder);
            }

            // 8. Start backend API server
            BookApiServer.start(conn);

        } catch (Exception e) {
            logger.log(Level.SEVERE, "❌ Unexpected error occurred in Main:", e);
        }
    }
}
