package com.example.project.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class Book {

    @JsonProperty("bookId")
    private int bookId;

    @JsonProperty("title")
    private String title;

    @JsonProperty("author")
    private String author;

    @JsonProperty("bookPrice")
    private double bookPrice;

    @JsonProperty("stock")
    private int stock;

    @JsonProperty("available")
    private boolean isAvailable;

    @JsonProperty("genres")
    private List<String> genres;

    public Book(int bookId, String title, String author, double bookPrice, int stock, boolean isAvailable, List<String> genres) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.bookPrice = bookPrice;
        this.stock = stock;
        this.isAvailable = isAvailable;
        this.genres = genres;
    }

    public Book() {}

    // Getters
    public int getBookId() { return bookId; }
    public String getTitle() { return title; }
    public String getAuthor() { return author; }
    public double getBookPrice() { return bookPrice; }
    public int getStock() { return stock; }
    public boolean isAvailable() { return isAvailable; }
    public List<String> getGenres() { return genres; }

    // Setters
    public void setBookId(int bookId) { this.bookId = bookId; }
    public void setTitle(String title) { this.title = title; }
    public void setAuthor(String author) { this.author = author; }
    public void setBookPrice(double bookPrice) { this.bookPrice = bookPrice; }
    public void setStock(int stock) { this.stock = stock; }
    public void setAvailable(boolean available) { isAvailable = available; }
    public void setGenres(List<String> genres) { this.genres = genres; }
}
