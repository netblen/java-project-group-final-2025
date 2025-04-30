package com.example.project.util;

import com.example.project.database.DbConnection;

import java.sql.Connection;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DbInitializer {
    private static final Logger logger = Logger.getLogger(DbInitializer.class.getName());

    public static void initialize(Connection conn) {
        try {
            DbConnection.initializeSchema(conn);
            DbConnection.loadTestData(conn);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "❌ Failed to initialize database: ", e);
        }
    }
}
