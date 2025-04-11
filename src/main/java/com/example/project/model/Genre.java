package com.example.project.model;

public class Genre {
    private int genreId;
    private String genreName;

    // Constructor
    public Genre(int genreId, String genreName) {
        this.genreId = genreId;
        this.genreName = genreName;
    }

    // Getters
    public int getGenreId() { return genreId; }
    public String getGenreName() { return genreName; }

    // Setters
    public void setGenreId(int genreId) { this.genreId = genreId; }
    public void setGenreName(String genreName) { this.genreName = genreName; }
}
