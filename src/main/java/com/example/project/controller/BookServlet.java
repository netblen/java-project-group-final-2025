//package com.example.project.controller;
//
//import com.example.project.dao.impl.BookDaoimpl;
//import com.example.project.database.DbConnection;
//import com.example.project.model.Book;
//import com.fasterxml.jackson.databind.ObjectMapper;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.*;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.util.List;
//
//@WebServlet("/books")
//public class BookServlet extends HttpServlet {
//    private BookDaoimpl bookDao;
//    private ObjectMapper objectMapper;
//
//    @Override
//    public void init() throws ServletException {
//        try {
//            Class.forName("org.h2.Driver");
//            // 1. Connect to the H2 database (persistent file)
//            Connection conn = DriverManager.getConnection("jdbc:h2:file:./bookstore", "sa", "");
//
//            // 2. Initialize schema if needed
//            DbConnection.initializeSchema(conn);
//
//            // 3. Set up Book DAO
//            bookDao = new BookDaoimpl(conn);
//
//            // 4. Load test data ONLY if DB is empty
//            if (bookDao.listAll().isEmpty()) {
//                DbConnection.loadTestData(conn);
//                System.out.println("📦 Data seeded because database was empty.");
//            } else {
//                System.out.println("📦 Data already exists — skipping seed.");
//            }
//
//            objectMapper = new ObjectMapper();
//        } catch (Exception e) {
//            throw new ServletException("❌ Error initializing BookServlet", e);
//        }
//    }
//
//    //GET
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
//        List<Book> books = bookDao.listAll();
//        resp.setContentType("application/json");
//        objectMapper.writeValue(resp.getWriter(), books);
//    }
//
//    //POST
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
//        Book book = objectMapper.readValue(req.getReader(), Book.class);
//        bookDao.add(book);
//        resp.setStatus(HttpServletResponse.SC_CREATED);
//    }
//
//    //DELETE
//    @Override
//    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
//        String code = req.getParameter("code");
//        if (code != null) {
//            bookDao.delete(code);
//            resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
//        } else {
//            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
//            resp.getWriter().write("Missing 'code' parameter");
//        }
//    }
//
//    //UPDATE
//    @Override
//    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
//        try {
//            Book book = objectMapper.readValue(req.getReader(), Book.class);
//            bookDao.update(book);
//            resp.setStatus(HttpServletResponse.SC_OK);
//        } catch (Exception e) {
//            e.printStackTrace();
//            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
//            resp.getWriter().write("⚠️ Error updating book: " + e.getMessage());
//        }
//    }
//
//}
package com.example.project.controller;

import com.example.project.dao.BookDAO;
import com.example.project.dao.impl.BookDaoimpl;
import com.example.project.database.DbConnection;
import com.example.project.model.Book;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/books")
public class BookServlet extends HttpServlet {
    private BookDAO bookDao;
    private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        try {
            Class.forName("org.h2.Driver");
            Connection conn = DriverManager.getConnection("jdbc:h2:file:./bookstore", "sa", "");

            DbConnection.initializeSchema(conn);

            bookDao = new BookDaoimpl(conn);

            if (bookDao.listAll().isEmpty()) {
                DbConnection.loadTestData(conn);
                System.out.println("📦 Data seeded because database was empty.");
            } else {
                System.out.println("📦 Data already exists — skipping seed.");
            }

            objectMapper = new ObjectMapper();
        } catch (Exception e) {
            throw new ServletException("❌ Error initializing BookServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");

        try {
            // Step 1: Extract filter/sort parameters from request
            String[] genresArr = req.getParameterValues("genres"); // e.g., ?genres=Fiction&genres=Fantasy
            String maxPriceParam = req.getParameter("maxPrice");
            String inStockParam = req.getParameter("onlyInStock");
            String sortBy = req.getParameter("sortBy");

            // Step 2: Prepare filter values
            List<String> genres = genresArr != null ? Arrays.asList(genresArr) : new ArrayList<>();
            double maxPrice = (maxPriceParam != null && !maxPriceParam.isEmpty()) ? Double.parseDouble(maxPriceParam) : 1000.0;
            boolean onlyInStock = (inStockParam != null && inStockParam.equalsIgnoreCase("true"));

            if (sortBy == null || sortBy.isEmpty()) {
                sortBy = "default"; // fallback if no sortBy
            }

            // Step 3: Fetch filtered and sorted books
            List<Book> books = bookDao.filterAndSortBooks(genres, maxPrice, onlyInStock, sortBy);

            // Step 4: Send as JSON
            objectMapper.writeValue(resp.getWriter(), books);

        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            objectMapper.writeValue(resp.getWriter(), "Error loading books: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Book book = objectMapper.readValue(req.getReader(), Book.class);
        bookDao.save(book);
        resp.setStatus(HttpServletResponse.SC_CREATED);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String code = req.getParameter("code");
        if (code != null) {
            bookDao.delete(code);
            resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
        } else {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("Missing 'code' parameter");
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Book book = objectMapper.readValue(req.getReader(), Book.class);
            bookDao.save(book);
            resp.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("⚠️ Error updating book: " + e.getMessage());
        }
    }
}


