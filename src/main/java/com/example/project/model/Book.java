package com.example.project.model;

public class Book {
    private int bookId;
    private String title;
    private String author;
    private String genre;
    private double bookPrice;
    private int stock;
    private boolean isAvailable;

    //Setters
    public Book(int bookId, String title, String author, String genre, double bookPrice, int stock, boolean isAvailable) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.genre = genre;
        this.bookPrice = bookPrice;
        this.stock = stock;
        this.isAvailable = isAvailable;
    }

    // Getters
    public int getBookId() { return bookId; }
    public String getTitle() { return title; }
    public String getAuthor() { return author; }
    public String getGenre() { return genre; }
    public double getBookPrice() { return bookPrice; }
    public int getStock() { return stock; }
    public boolean isAvailable() { return isAvailable; }
}
