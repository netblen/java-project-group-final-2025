package com.example.project.dao;

import com.example.project.model.Order;
import com.example.project.model.OrderDetail;

import java.util.List;

/**
 * DAO interface for handling order-related operations.
 */
public interface OrderDAO {

    /**
     * Place a new order along with its order details.
     * @param order the order to place
     */
    void placeOrder(Order order);

    /**
     * Get all orders placed by a specific customer.
     * @param customerId the customer's ID
     * @return list of orders
     */
    List<Order> getOrdersByCustomerId(int customerId);

    /**
     * Insert a detail line for an order.
     * @param detail the order detail
     * @param orderId the associated order ID
     */
    void createOrderDetail(OrderDetail detail, int orderId);
}
