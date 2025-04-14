package com.example.project.dao.impl;

import com.example.project.dao.CustomerDAO;
import com.example.project.model.Customer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDaoimpl implements CustomerDAO {
    private final Connection conn;

    public CustomerDaoimpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public boolean add(Customer customer) {
        String sql = "INSERT INTO Customer (customerId, name, email, password, userType) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customer.getCustomerId());
            stmt.setString(2, customer.getName());
            stmt.setString(3, customer.getEmail());
            stmt.setString(4, customer.getPassword());
            stmt.setString(5, customer.getUserType());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding customer: " + e.getMessage());
            return false;
        }
    }

    @Override
    public Customer getById(int id) {
        String sql = "SELECT * FROM Customer WHERE customerId = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Customer(
                        rs.getInt("customerId"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("userType")
                );
            }
        } catch (SQLException e) {
            System.err.println("Error getting customer: " + e.getMessage());
        }
        return null;
    }

    @Override
    public List<Customer> listAll() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM Customer";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                customers.add(new Customer(
                        rs.getInt("customerId"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("userType")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Error listing customers: " + e.getMessage());
        }
        return customers;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM Customer WHERE customerId = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting customer: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean updateCustomer(int customerId, String newName, String newPassword) {
        String sql = "UPDATE Customer SET name = ? , password =?  WHERE customerId = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newName);
            stmt.setString(2, newPassword);
            stmt.setInt(3, customerId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating email: " + e.getMessage());
            return false;
        }
    }

    public Customer getByEmail(String email) {
        String sql = "SELECT * FROM Customer WHERE email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Customer(
                        rs.getInt("customerId"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("userType")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
