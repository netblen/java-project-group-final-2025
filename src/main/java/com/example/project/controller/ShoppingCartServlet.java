package com.example.project.controller;

import com.example.project.dao.impl.CartItemDaoimpl;
import com.example.project.dao.impl.ShoppingCartDaoimpl;
import com.example.project.database.DbConnection;
import com.example.project.database.DbUtil;
import com.example.project.model.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/cart")
public class ShoppingCartServlet extends HttpServlet {

    private ShoppingCartDaoimpl cartDao;
    private CartItemDaoimpl cartItemDao;
    private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DbUtil.getConnection();
            cartDao = new ShoppingCartDaoimpl(conn);
            cartItemDao = new CartItemDaoimpl(conn);
        } catch (Exception e) {
            throw new ServletException("❌ Error initializing CustomerServlet", e);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");

        try {
            CartRequestData requestData = objectMapper.readValue(req.getReader(), CartRequestData.class);

            int customerId = requestData.getCustomerId();
            int bookId = requestData.getBookId();
            int quantity = requestData.getQuantity();
            int availableStock = cartItemDao.getAvailableStock(bookId);

            if (quantity > availableStock) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                objectMapper.writeValue(resp.getWriter(),
                        new ErrorResponse("Not enough stock. Only " + availableStock + " available."));
                return;
            }

            if (quantity <= 0) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                objectMapper.writeValue(resp.getWriter(), new ErrorResponse("Invalid quantity"));
                return;
            }

            ShoppingCart cart = cartDao.getCartByCustomerId(customerId);
            if (cart == null) {
                cartDao.createCart(customerId);
                cart = cartDao.getCartByCustomerId(customerId);
            }

            int cartId = cart.getCartId();

            if (cartItemDao.itemExists(cartId, bookId)) {
                int currentQty = cartItemDao.getQuantity(cartId, bookId);
                cartItemDao.updateQuantity(cartId, bookId, currentQty + quantity);
            } else {
                CartItem item = new CartItem(cartId, bookId, quantity);
                cartItemDao.addItem(item);
            }

            resp.setStatus(HttpServletResponse.SC_OK);
            objectMapper.writeValue(resp.getWriter(), new SuccessResponse("Book added successfully."));

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            objectMapper.writeValue(resp.getWriter(), new ErrorResponse("Error to add book: " + e.getMessage()));
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
            ShoppingCart cart = cartDao.getCartByCustomerId(customerId);

            if (cart == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                objectMapper.writeValue(resp.getWriter(), new ErrorResponse("No cart found for customer"));
                return;
            }

            int cartId = cart.getCartId();
            List<CartItemDetails> items = cartItemDao.getDetailedItemsInCart(cartId);

            CartResponse cartResponse = new CartResponse(items);
            objectMapper.writeValue(resp.getWriter(), cartResponse);
            resp.setStatus(HttpServletResponse.SC_OK);

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            objectMapper.writeValue(resp.getWriter(), new ErrorResponse("Error retrieving cart items"));
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");

        try {
            CartRequestData data = objectMapper.readValue(req.getReader(), CartRequestData.class);
            int customerId = data.getCustomerId();
            int bookId = data.getBookId();
            int newQuantity = data.getQuantity();

            if (newQuantity <= 0) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                objectMapper.writeValue(resp.getWriter(), new ErrorResponse("Invalid quantity"));
                return;
            }

            ShoppingCart cart = cartDao.getCartByCustomerId(customerId);
            if (cart == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                objectMapper.writeValue(resp.getWriter(), new ErrorResponse("Cart not found"));
                return;
            }

            int cartId = cart.getCartId();

            int availableStock = cartItemDao.getAvailableStock(bookId);
            if (newQuantity > availableStock) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                objectMapper.writeValue(resp.getWriter(), new ErrorResponse("Not enough stock. Only " + availableStock + " available."));
                return;
            }

            cartItemDao.updateQuantity(cartId, bookId, newQuantity);
            objectMapper.writeValue(resp.getWriter(), new SuccessResponse("Quantity updated"));

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            objectMapper.writeValue(resp.getWriter(), new ErrorResponse("Error updating cart"));
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
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
                objectMapper.writeValue(resp.getWriter(), new ErrorResponse("Cart not found"));
                return;
            }

            cartItemDao.clearCart(cart.getCartId());
            resp.setStatus(HttpServletResponse.SC_NO_CONTENT);

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            objectMapper.writeValue(resp.getWriter(), new ErrorResponse("Error deleting cart"));
        }
    }

    static class CartRequestData {
        private int customerId;
        private int bookId;
        private int quantity;

        public int getCustomerId() { return customerId; }
        public void setCustomerId(int customerId) { this.customerId = customerId; }

        public int getBookId() { return bookId; }
        public void setBookId(int bookId) { this.bookId = bookId; }

        public int getQuantity() { return quantity; }
        public void setQuantity(int quantity) { this.quantity = quantity; }
    }

    static class ErrorResponse {
        private final String error;
        public ErrorResponse(String error) { this.error = error; }
        public String getError() { return error; }
    }

    static class SuccessResponse {
        private final String message;
        public SuccessResponse(String message) { this.message = message; }
        public String getMessage() { return message; }
    }
}
