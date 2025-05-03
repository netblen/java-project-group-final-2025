package com.example.project.controller;

import com.example.project.dao.*;
import com.example.project.dao.impl.*;
import com.example.project.db.DbUtil;
import com.example.project.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/adminDashboard")
public class AdminServlet extends HttpServlet {
    private BookDAO bookDao;
    private CustomerDAO customerDao;
    private AdminDao adminDao;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DbUtil.getConnection();
            bookDao = new BookDaoimpl(conn);
            customerDao = new CustomerDaoimpl(conn);
            adminDao = new AdminDaoimpl(conn);
        } catch (Exception e) {
            throw new ServletException("❌ Failed to initialize AdminServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Book> books = bookDao.listAll();
            List<Customer> users = customerDao.listAll();

            int totalBooks = books.size();
            int inStock = (int) books.stream().filter(b -> b.getStock() > 5).count();
            int lowStock = (int) books.stream().filter(b -> b.getStock() > 0 && b.getStock() <= 5).count();
            int outOfStock = (int) books.stream().filter(b -> b.getStock() == 0).count();

            Map<String, Integer> inventoryStats = new HashMap<>();
            inventoryStats.put("totalBooks", totalBooks);
            inventoryStats.put("inStock", inStock);
            inventoryStats.put("lowStock", lowStock);
            inventoryStats.put("outOfStock", outOfStock);

            req.setAttribute("books", books);
            req.setAttribute("users", users);
            req.setAttribute("inventoryStats", inventoryStats);
            //req.setAttribute("recentOrders", recentOrders);

            Customer currentUser = (Customer) req.getSession().getAttribute("currentUser");
            req.setAttribute("currentUser", currentUser);

            req.getRequestDispatcher("adminDashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("❌ Error loading dashboard data", e);
        }
    }
}
