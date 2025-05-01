package com.example.project.controller;

import com.example.project.dao.impl.CartItemDaoimpl;
import com.example.project.dao.impl.ShoppingCartDaoimpl;
import com.example.project.database.DbConnection;
import com.example.project.database.DbUtil;
import com.example.project.model.ShoppingCart;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import javax.servlet.ServletContext;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

@WebServlet("/cart/item")
public class CartItemServlet extends HttpServlet {

    private ShoppingCartDaoimpl cartDao;
    private CartItemDaoimpl cartItemDao;
    private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DbUtil.getConnection();
            cartDao = new ShoppingCartDaoimpl(conn);
            cartItemDao = new CartItemDaoimpl(conn);
            objectMapper = new ObjectMapper();
        } catch (Exception e) {
            throw new ServletException("❌ Error initializing CartItemServlet", e);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");

        try {
            ShoppingCartServlet.CartRequestData data = objectMapper.readValue(req.getReader(), ShoppingCartServlet.CartRequestData.class);
            int customerId = data.getCustomerId();
            int bookId = data.getBookId();

            ShoppingCart cart = cartDao.getCartByCustomerId(customerId);
            if (cart == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                objectMapper.writeValue(resp.getWriter(), new ShoppingCartServlet.ErrorResponse("Cart not found"));
                return;
            }

            cartItemDao.removeItem(cart.getCartId(), bookId);
            resp.setStatus(HttpServletResponse.SC_OK);
            objectMapper.writeValue(resp.getWriter(), new ShoppingCartServlet.SuccessResponse("Item removed from cart"));

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            objectMapper.writeValue(resp.getWriter(), new ShoppingCartServlet.ErrorResponse("Error removing item from cart"));
        }
    }
}
