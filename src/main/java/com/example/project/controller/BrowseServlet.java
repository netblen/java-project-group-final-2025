package com.example.project.controller;

import com.example.project.dao.BookDAO;
import com.example.project.dao.impl.BookDaoimpl;
import com.example.project.model.Book;
import com.example.project.db.DbUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/browse")
public class BrowseServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DbUtil.getConnection()) {
            BookDAO bookDAO = new BookDaoimpl(conn);
            List<Book> books = bookDAO.listAll();

            request.setAttribute("books", books);
            request.getRequestDispatcher("/browse.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Database error loading books.");
        }
    }
}
