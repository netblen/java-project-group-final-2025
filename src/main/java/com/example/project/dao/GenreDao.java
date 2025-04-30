package com.example.project.dao;

import com.example.project.model.Genre;

import java.sql.SQLException;
import java.util.List;

public interface GenreDao {
    void addGenre(Genre genre) throws SQLException;

    List<Genre> getAllGenres() throws SQLException;

    void deleteGenre(int genreId) throws SQLException;

    void updateGenre(Genre genre) throws SQLException;
}

