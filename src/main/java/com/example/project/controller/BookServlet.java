package com.example.project.controller;

import com.example.project.dao.BookDAO;
import com.example.project.dao.impl.BookDaoimpl;
import com.example.project.dao.impl.CustomerDaoimpl;
import com.example.project.database.DbConnection;
import com.example.project.database.DbUtil;
import com.example.project.model.Book;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
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
            Connection conn = DbUtil.getConnection();
            bookDao = new BookDaoimpl(conn);
            objectMapper = new ObjectMapper();
        } catch (Exception e) {
            throw new ServletException("❌ Error initializing CustomerServlet", e);
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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String title = req.getParameter("title");
        String author = req.getParameter("author");
        double price = Double.parseDouble(req.getParameter("price"));
        int stock = Integer.parseInt(req.getParameter("stock"));
//        String genreId = req.getParameter("genre");
        boolean isAvailable = req.getParameter("isAvailable") != null;

        Book book = new Book();
        book.setTitle(title);
        book.setAuthor(author);
        book.setBookPrice(price);
        book.setStock(stock);
        book.setAvailable(isAvailable);
        //book.setGenres(List.of(genreId));

        bookDao.save(book);
        resp.sendRedirect("books.jsp");
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
