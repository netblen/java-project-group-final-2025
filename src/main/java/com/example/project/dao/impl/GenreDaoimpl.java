package com.example.project.dao.impl;

import com.example.project.dao.GenreDao;
import com.example.project.model.Genre;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GenreDaoimpl implements GenreDao {
    private final Connection conn;

    public GenreDaoimpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public void addGenre(Genre genre) throws SQLException {
        String sql = "INSERT INTO Genre (genreName) VALUES (?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, genre.getGenreName());
            stmt.executeUpdate();
        }
    }

    @Override
    public List<Genre> getAllGenres() throws SQLException {
        List<Genre> genres = new ArrayList<>();
        String sql = "SELECT * FROM Genre";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                genres.add(new Genre(
                        rs.getInt("genreId"),
                        rs.getString("genreName")
                ));
            }
        }
        return genres;
    }

    @Override
    public void deleteGenre(int genreId) throws SQLException {
        String sql = "DELETE FROM Genre WHERE genreId = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, genreId);
            stmt.executeUpdate();
        }
    }

    @Override
    public void updateGenre(Genre genre) throws SQLException {
        String sql = "UPDATE Genre SET genreName = ? WHERE genreId = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, genre.getGenreName());
            stmt.setInt(2, genre.getGenreId());
            stmt.executeUpdate();
        }
    }
}
