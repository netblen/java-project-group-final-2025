package com.example.project.controller;

import com.example.project.dao.InventoryDao;
import com.example.project.dao.impl.InventoryDaoimpl;
import com.example.project.db.DbUtil;
import com.example.project.model.Inventory;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/inventory")
public class InventoryServlet extends HttpServlet {
    private InventoryDao inventoryDAO;
    private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DbUtil.getConnection();
            inventoryDAO = new InventoryDaoimpl(conn);
            objectMapper = new ObjectMapper();
        } catch (Exception e) {
            throw new ServletException("❌ Failed to initialize InventoryServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String bookIdParam = req.getParameter("bookId");

        if (bookIdParam == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("Missing bookId parameter");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdParam);
            Inventory inventory = inventoryDAO.getInventory(bookId);

            if (inventory != null) {
                resp.setContentType("application/json");
                objectMapper.writeValue(resp.getWriter(), inventory);
            } else {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write("Inventory not found for bookId: " + bookId);
            }
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("Invalid bookId format");
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("Error retrieving inventory: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Inventory inv = objectMapper.readValue(req.getReader(), Inventory.class);
            inventoryDAO.updateStock(inv.getBookId(), inv.getInventoryQuantity());
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("Inventory updated");
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("⚠️ Error updating inventory: " + e.getMessage());
        }
    }
}
