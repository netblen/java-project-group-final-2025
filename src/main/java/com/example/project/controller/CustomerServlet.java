package com.example.project.controller;

import com.example.project.dao.impl.CustomerDaoimpl;
import com.example.project.database.DbConnection;
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
import java.util.List;

@WebServlet("/customers")
public class CustomerServlet extends HttpServlet {
    private CustomerDaoimpl customerDao;
    private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        try {
            Class.forName("org.h2.Driver");
            Connection conn = DriverManager.getConnection("jdbc:h2:file:./bookstore", "sa", "");

            DbConnection.initializeSchema(conn); // optional for customers

            customerDao = new CustomerDaoimpl(conn);
            objectMapper = new ObjectMapper();
        } catch (Exception e) {
            throw new ServletException("❌ Error initializing CustomerServlet", e);
        }
    }

    // GET all customers
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        resp.setContentType("application/json");

        try {
            if (idParam != null) {
                int id = Integer.parseInt(idParam);
                Customer customer = customerDao.getById(id);
                if (customer != null) {
                    objectMapper.writeValue(resp.getWriter(), customer);
                } else {
                    resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    resp.getWriter().write("{\"error\":\"Customer not found\"}");
                }
            } else {
                List<Customer> customers = customerDao.listAll();
                objectMapper.writeValue(resp.getWriter(), customers);
            }
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("⚠️ Error: " + e.getMessage());
        }
    }

    // POST: Add new customer
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Customer customer = objectMapper.readValue(req.getReader(), Customer.class);
            customerDao.add(customer);
            resp.setStatus(HttpServletResponse.SC_CREATED);
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("⚠️ Error adding customer: " + e.getMessage());
        }
    }

    // PUT: Update email
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Customer customer = objectMapper.readValue(req.getReader(), Customer.class);
            if (customer.getCustomerId() != 0 && customer.getEmail() != null)
            {
                customerDao.updateCustomer(customer.getCustomerId(), customer.getName(),customer.getPassword());
                resp.setStatus(HttpServletResponse.SC_OK);
            } else {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("Missing customerId or email in request body");
            }
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("⚠️ Error updating email: " + e.getMessage());
        }
    }

    // DELETE: by ID
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        try {
            if (idParam != null) {
                int id = Integer.parseInt(idParam);
                customerDao.delete(id);
                resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
            } else {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("Missing 'id' parameter");
            }
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("⚠️ Error deleting customer: " + e.getMessage());
        }
    }
}
