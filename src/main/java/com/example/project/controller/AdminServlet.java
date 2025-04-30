package com.example.project.controller;

import com.example.project.dao.AdminDao;
import com.example.project.dao.impl.AdminDaoimpl;
import com.example.project.database.DbUtil;
import com.example.project.model.Admin;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private AdminDao adminDao;
    private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DbUtil.getConnection();
            adminDao = new AdminDaoimpl(conn);
            objectMapper = new ObjectMapper();
        } catch (Exception e) {
            throw new ServletException("❌ Failed to initialize AdminServlet", e);
        }
    }

    // GET: Return all admin logs as JSON
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");

        try {
            List<Admin> logs = adminDao.getAllLogs();
            objectMapper.writeValue(resp.getWriter(), logs);
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            objectMapper.writeValue(resp.getWriter(), "❌ Error retrieving admin logs: " + e.getMessage());
        }
    }

    // POST: Log a new admin action
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String actionType = req.getParameter("actionType");

            if (actionType == null || actionType.trim().isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("⚠️ 'actionType' is required.");
                return;
            }

            adminDao.logAction(actionType);
            resp.setStatus(HttpServletResponse.SC_CREATED);
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("❌ Error logging admin action: " + e.getMessage());
        }
    }
}
