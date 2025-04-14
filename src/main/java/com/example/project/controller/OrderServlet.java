package com.example.project.controller;

import com.example.project.dao.impl.OrderDaoimpl;
import com.example.project.database.DbConnection;
import com.example.project.model.Order;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    private OrderDaoimpl orderDao;
    private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        try {
            Class.forName("org.h2.Driver");
            Connection conn = DriverManager.getConnection("jdbc:h2:file:./bookstore", "sa", "");
            DbConnection.initializeSchema(conn);
            orderDao = new OrderDaoimpl(conn);
            objectMapper = new ObjectMapper();
        } catch (Exception e) {
            throw new ServletException("❌ Error initializing OrderServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");

        try {
            String customerIdParam = req.getParameter("customerId");
            if (customerIdParam == null) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                objectMapper.writeValue(resp.getWriter(), new ErrorResponse("Missing 'customerId' parameter"));
                return;
            }

            int customerId = Integer.parseInt(customerIdParam);
            List<Order> orders = orderDao.getOrdersByCustomerId(customerId);

            objectMapper.writeValue(resp.getWriter(), orders);
            resp.setStatus(HttpServletResponse.SC_OK);

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            objectMapper.writeValue(resp.getWriter(), new ErrorResponse("❌ Failed to fetch orders."));
        }
    }

    static class ErrorResponse {
        private String error;
        public ErrorResponse(String error) { this.error = error; }
        public String getError() { return error; }
    }
}
