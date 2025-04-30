package com.example.project.dao;
import com.example.project.model.Book;
import java.util.List;

public interface BookDAO {
    /**
     * Find a book by code
     * @param code the book code
     * @return the book or null if not found
     */
    Book findByCode(String code);

    /**
     * Get all books
     * @return list of all books
     */
    List<Book> listAll();

    /**
     * Save a book (insert if new, update if existing)
     * @param book the book to save
     * @return true if successful
     */
    boolean save(Book book);

    /**
     * Delete a book
     * @param code the course code
     * @return true if successful
     */
    boolean delete(String code);

    /**
     * NEW: Filter and sort books based on search criteria
     * @param genres list of genre names
     * @param maxPrice maximum price
     * @param onlyInStock true if only showing in stock
     * @param sortBy sorting option (e.g., priceAsc, priceDesc, newest, etc)
     * @return list of books matching criteria
     */
    List<Book> filterAndSortBooks(List<String> genres, double maxPrice, boolean onlyInStock, String sortBy);
}

