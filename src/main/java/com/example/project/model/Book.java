package com.example.project.model;

import java.util.List;

public class Book {
    private int bookId;
    private String title;
    private String author;
    private double bookPrice;
    private int stock;
    private boolean isAvailable;
    private List<String> genres; // NEW: list of genre names

    public Book(int bookId, String title, String author, double bookPrice, int stock, boolean isAvailable, List<String> genres) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.bookPrice = bookPrice;
        this.stock = stock;
        this.isAvailable = isAvailable;
        this.genres = genres;
    }

    // Getters
    public int getBookId() { return bookId; }
    public String getTitle() { return title; }
    public String getAuthor() { return author; }
    public double getBookPrice() { return bookPrice; }
    public int getStock() { return stock; }
    public boolean isAvailable() { return isAvailable; }
    public List<String> getGenres() { return genres; }
}
