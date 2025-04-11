package com.example.project.dao;

import com.example.project.model.Genre;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GenreDao {
    private final Connection conn;

    public GenreDao(Connection conn) {
        this.conn = conn;
    }

    public void addGenre(Genre genre) throws SQLException {
        String sql = "INSERT INTO Genre (genreName) VALUES (?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, genre.getGenreName());
        stmt.executeUpdate();
        stmt.close();
    }

    public List<Genre> getAllGenres() throws SQLException {
        List<Genre> genres = new ArrayList<>();
        String sql = "SELECT * FROM Genre";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            genres.add(new Genre(
                    rs.getInt("genreId"),
                    rs.getString("genreName")
            ));
        }
        stmt.close();
        return genres;
    }

    public void deleteGenre(int genreId) throws SQLException {
        String sql = "DELETE FROM Genre WHERE genreId = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, genreId);
        stmt.executeUpdate();
        stmt.close();
    }
}
