package com.example.project.dao;

import com.example.project.model.Admin;
import java.sql.SQLException;
import java.util.List;

public interface AdminDao {
    /**
     * Logs an administrative action to the database.
     * @param actionType The action type performed by the admin.
     * @throws SQLException if a database access error occurs.
     */
    void logAction(String actionType) throws SQLException;

    /**
     * Retrieves all logged admin actions, ordered by most recent.
     * @return A list of admin logs.
     * @throws SQLException if a database access error occurs.
     */
    List<Admin> getAllLogs() throws SQLException;
}
