package com.example.project.api;

import com.example.project.dao.BookDao;
import com.example.project.database.DbConnection;
import com.example.project.model.Book;
import com.google.gson.Gson;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

import static spark.Spark.*;

public class BookApiServer {

    public static void start() {
        port(4567); // Runs on http://localhost:4567

        Gson gson = new Gson();

        try {
            // Connect and initialize the database
            Connection conn = DriverManager.getConnection("jdbc:h2:./bookstore", "sa", "");
            DbConnection.initializeDatabase(conn);

            BookDao dao = new BookDao(conn);

            // GET all books
            get("/books", (req, res) -> {
                List<Book> books = dao.listAll();
                res.type("application/json");
                return gson.toJson(books);
            });

            // POST new book (JSON body)
            post("/books", (req, res) -> {
                Book book = gson.fromJson(req.body(), Book.class);
                dao.add(book);
                res.status(201);
                return "✅ Book added!";
            });

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
