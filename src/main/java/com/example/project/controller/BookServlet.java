package com.example.project.controller;

import com.example.project.dao.impl.BookDaoimpl;
import com.example.project.database.DbConnection;
import com.example.project.model.Book;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

@WebServlet("/books")
public class BookServlet extends HttpServlet {
    private BookDaoimpl bookDao;
    private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        try {
            Class.forName("org.h2.Driver");
            // 1. Connect to the H2 database (persistent file)
            Connection conn = DriverManager.getConnection("jdbc:h2:file:./bookstore", "sa", "");

            // 2. Initialize schema if needed
            DbConnection.initializeSchema(conn);

            // 3. Set up Book DAO
            bookDao = new BookDaoimpl(conn);

            // 4. Load test data ONLY if DB is empty
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

    //GET
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Book> books = bookDao.listAll();
        resp.setContentType("application/json");
        objectMapper.writeValue(resp.getWriter(), books);
    }

    //POST
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Book book = objectMapper.readValue(req.getReader(), Book.class);
        bookDao.add(book);
        resp.setStatus(HttpServletResponse.SC_CREATED);
    }

    //DELETE
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

    //UPDATE
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Book book = objectMapper.readValue(req.getReader(), Book.class);
            bookDao.update(book);
            resp.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("⚠️ Error updating book: " + e.getMessage());
        }
    }

}
