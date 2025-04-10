package com.example.project.dao;

import com.example.project.model.Book;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDao {
    private final Connection conn;
    public CustomerDao(Connection conn) {
        this.conn = conn;
    }

}
