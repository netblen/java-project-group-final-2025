package com.example.project.controller;

import com.example.project.dao.impl.CustomerDaoimpl;
import com.example.project.db.DbUtil;
import com.example.project.model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private CustomerDaoimpl customerDao;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DbUtil.getConnection();
            customerDao = new CustomerDaoimpl(conn);
        } catch (Exception e) {
            throw new ServletException("❌ Error initializing CustomerServlet", e);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        Customer customer = customerDao.getByEmail(email);

        if (customer != null && customer.getPassword().equals(password)) {
            String storedType = customer.getUserType(); // "regular" o "admin"

            req.getSession().setAttribute("currentUser", customer);

            if ("admin".equalsIgnoreCase(storedType)) {
                resp.sendRedirect("admin-dashboard.jsp");
            } else {
                resp.sendRedirect("index.jsp");
            }
        } else {
            resp.setContentType("text/html");
            resp.getWriter().write("<p style='color:red;'>❌ Invalid email or password</p>");
        }
    }
}
