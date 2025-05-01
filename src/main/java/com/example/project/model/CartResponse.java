package com.example.project.model;

import java.util.List;

public class CartResponse {
    private final List<CartItemDetails> items;
    private final double total;

    public CartResponse(List<CartItemDetails> items) {
        this.items = items;
        this.total = calculateTotal(items);
    }

    private double calculateTotal(List<CartItemDetails> items) {
        return items.stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();
    }

    public List<CartItemDetails> getItems() {
        return items;
    }

    public double getTotal() {
        return total;
    }
}
