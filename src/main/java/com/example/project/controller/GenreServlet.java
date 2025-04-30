package com.example.project.controller;

import com.example.project.dao.GenreDao;
import com.example.project.dao.impl.GenreDaoimpl;
import com.example.project.database.DbUtil;
import com.example.project.model.Genre;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/genres")
public class GenreServlet extends HttpServlet {
    private GenreDao genreDao;
    private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DbUtil.getConnection();
            genreDao = new GenreDaoimpl(conn);
            objectMapper = new ObjectMapper();
        } catch (Exception e) {
            throw new ServletException("❌ Failed to initialize GenreServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        try {
            List<Genre> genres = genreDao.getAllGenres();
            objectMapper.writeValue(resp.getWriter(), genres);
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            objectMapper.writeValue(resp.getWriter(), "Error retrieving genres: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Genre genre = objectMapper.readValue(req.getReader(), Genre.class);
            genreDao.addGenre(genre);
            resp.setStatus(HttpServletResponse.SC_CREATED);
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            objectMapper.writeValue(resp.getWriter(), "⚠️ Error adding genre: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Genre genre = objectMapper.readValue(req.getReader(), Genre.class);
            genreDao.updateGenre(genre);
            resp.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            objectMapper.writeValue(resp.getWriter(), "⚠️ Error updating genre: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int genreId = Integer.parseInt(req.getParameter("genreId"));
            genreDao.deleteGenre(genreId);
            resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            objectMapper.writeValue(resp.getWriter(), "⚠️ Error deleting genre: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

