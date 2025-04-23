package com.example.project.controller;

import com.example.project.dao.impl.CustomerDaoimpl;
import com.example.project.model.Customer;
import com.fasterxml.jackson.databind.ObjectMapper;

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
    private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        try {
            Class.forName("org.h2.Driver");
            Connection conn = DriverManager.getConnection("jdbc:h2:file:./bookstore", "sa", "");
            customerDao = new CustomerDaoimpl(conn);
            objectMapper = new ObjectMapper();
        } catch (Exception e) {
            throw new ServletException("Error initializing LoginServlet", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        System.out.println("🔑 Login attempt: " + email);

        Customer customer = customerDao.getByEmail(email);

        if (customer != null && customer.getPassword().equals(password)) {
            req.getSession().setAttribute("currentUser", customer);
            resp.sendRedirect("index.jsp");
        } else {
            resp.setContentType("text/html");
            resp.getWriter().write("<p style='color:red;'>Invalid email or password</p>");

        }
    }
}