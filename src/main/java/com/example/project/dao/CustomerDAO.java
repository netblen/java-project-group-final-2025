package com.example.project.dao;

import com.example.project.model.Customer;
import java.util.List;

public interface CustomerDAO {
    /**
     * Add a new customer
     * @param customer the customer to add
     * @return true if the customer was added successfully
     */
    boolean add(Customer customer);

    /**
     * Get a customer by their ID
     * @param id the customer ID
     * @return the customer or null if not found
     */
    Customer getById(int id);

    /**
     * Get a list of all customers
     * @return list of customers
     */
    List<Customer> listAll();

    /**
     * Delete a customer by ID
     * @param id the customer ID
     * @return true if the customer was deleted
     */
    boolean delete(int id);

    /**
     * Update the email of a customer
     * @param customerId the customer ID
     * @param newName the new name to set
     * @param newPassword the new password to set
     * @return true if the update was successful
     */
    boolean updateCustomer(int customerId, String newName, String newPassword);
}
