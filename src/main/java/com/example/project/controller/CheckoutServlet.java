package com.example.project.controller;

import com.example.project.dao.impl.CartItemDaoimpl;
import com.example.project.dao.impl.OrderDaoimpl;
import com.example.project.dao.impl.ShoppingCartDaoimpl;
import com.example.project.database.DbConnection;
import com.example.project.model.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart/checkout")
public class CheckoutServlet extends HttpServlet {

    private ShoppingCartDaoimpl cartDao;
    private CartItemDaoimpl cartItemDao;
    private OrderDaoimpl orderDao;
    private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        try {
            Class.forName("org.h2.Driver");
            Connection conn = DriverManager.getConnection("jdbc:h2:file:./bookstore", "sa", "");

            DbConnection.initializeSchema(conn);

            cartDao = new ShoppingCartDaoimpl(conn);
            cartItemDao = new CartItemDaoimpl(conn);
            orderDao = new OrderDaoimpl(conn);
            objectMapper = new ObjectMapper();

        } catch (Exception e) {
            throw new ServletException("❌ Error initializing CheckoutServlet", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");

        try {
            String customerIdParam = req.getParameter("customerId");
            if (customerIdParam == null) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                objectMapper.writeValue(resp.getWriter(), new ErrorResponse("Missing 'customerId' parameter"));
                return;
            }

            int customerId = Integer.parseInt(customerIdParam);
            ShoppingCart cart = cartDao.getCartByCustomerId(customerId);
            if (cart == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                objectMapper.writeValue(resp.getWriter(), new ErrorResponse("No cart found for customer."));
                return;
            }

            int cartId = cart.getCartId();
            List<CartItemDetails> items = cartItemDao.getDetailedItemsInCart(cartId);
            if (items.isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                objectMapper.writeValue(resp.getWriter(), new ErrorResponse("Cart is empty."));
                return;
            }

            List<OrderDetail> orderDetails = new ArrayList<>();

            for (CartItemDetails item : items) {
                OrderDetail detail = new OrderDetail();
                detail.setBookId(item.getBookId());
                detail.setOrderQuantity(item.getQuantity());
                detail.setOrderPrice(item.getPrice());
                orderDetails.add(detail);
            }

            double total = orderDetails.stream()
                    .mapToDouble(d -> d.getOrderPrice() * d.getOrderQuantity())
                    .sum();

            Order order = new Order();
            order.setCustomerId(customerId);
            order.setOrderDate(new java.sql.Timestamp(System.currentTimeMillis()));
            order.setOrderStatus("PENDING");
            order.setDetails(orderDetails);
            order.setTotalPrice(total);

            orderDao.placeOrder(order);
            cartItemDao.clearCart(cartId);

            resp.setStatus(HttpServletResponse.SC_OK);
            objectMapper.writeValue(resp.getWriter(), new SuccessResponse("✅ Order placed successfully."));

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            objectMapper.writeValue(resp.getWriter(), new ErrorResponse("❌ Checkout failed: " + e.getMessage()));
        }
    }

    static class ErrorResponse {
        private String error;
        public ErrorResponse(String error) { this.error = error; }
        public String getError() { return error; }
    }

    static class SuccessResponse {
        private String message;
        public SuccessResponse(String message) { this.message = message; }
        public String getMessage() { return message; }
    }
}
