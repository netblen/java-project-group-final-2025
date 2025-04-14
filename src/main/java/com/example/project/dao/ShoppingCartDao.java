package com.example.project.dao;

import com.example.project.model.ShoppingCart;

public interface ShoppingCartDao {
    /**
     * Create a new shopping cart for a customer
     * @param customerId the customer's ID
     */
    void createCart(int customerId);

    /**
     * Get the shopping cart for a customer
     * @param customerId the customer's ID
     * @return the shopping cart, or null if not found
     */
    ShoppingCart getCartByCustomerId(int customerId);

    /**
     * Get the cart ID associated with a customer
     * @param customerId the customer's ID
     * @return the cart ID, or -1 if not found
     */
    int getCartIdByCustomerId(int customerId);

    /**
     * Delete a shopping cart by its ID
     * @param cartId the cart's ID
     */
    void deleteCart(int cartId);
}
