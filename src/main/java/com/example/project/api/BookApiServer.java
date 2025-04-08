package com.example.project.api;

import com.example.project.dao.BookDao;
import com.example.project.model.Book;

import static spark.Spark.*;

import java.sql.Connection;
import java.util.List;

public class BookApiServer {

    public static void start(Connection conn) {
        BookDao bookDao = new BookDao(conn);

        // Endpoint: GET /books
        get("/books", (req, res) -> {
            res.type("application/json");
            List<Book> books = bookDao.listAll();
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < books.size(); i++) {
                Book b = books.get(i);
                json.append(String.format("{\"title\":\"%s\",\"author\":\"%s\"}", b.getTitle(), b.getAuthor()));
                if (i < books.size() - 1) json.append(",");
            }
            json.append("]");
            return json.toString();
        });

        System.out.println("🚀 API Server running at http://localhost:4567/books");
    }
}
