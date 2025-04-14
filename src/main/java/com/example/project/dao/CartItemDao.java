package com.example.project.dao;

import com.example.project.model.CartItem;
import java.util.List;

public interface CartItemDao {

    /**
     * Add a new item to the shopping cart
     * @param item the item to add
     */
    void addItem(CartItem item);

    /**
     * Get all items in a shopping cart
     * @param cartId the cart ID
     * @return list of cart items
     */
    List<CartItem> getItemsInCart(int cartId);

    /**
     * Remove a specific item from the shopping cart
     * @param cartId the cart ID
     * @param bookId the book ID to remove
     */
    void removeItem(int cartId, int bookId);

    /**
     * Update the quantity of an item in the cart
     * @param cartId the cart ID
     * @param bookId the book ID
     * @param newQty the new quantity
     */
    void updateQuantity(int cartId, int bookId, int newQty);

    /**
     * Clear all items in a cart
     * @param cartId the cart ID
     */
    void clearCart(int cartId);

    /**
     * Check if a book is already in the cart
     * @param cartId the cart ID
     * @param bookId the book ID
     * @return true if the item exists, false otherwise
     */
    boolean itemExists(int cartId, int bookId);

    /**
     * Get the current quantity of a book in the cart
     * @param cartId the cart ID
     * @param bookId the book ID
     * @return quantity of the book in the cart
     */
    int getQuantity(int cartId, int bookId);
}
