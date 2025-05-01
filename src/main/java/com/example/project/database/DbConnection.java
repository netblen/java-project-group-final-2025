package com.example.project.database;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class DbConnection {
    public static void initializeSchema(Connection conn) throws Exception {
        runScript(conn, "schema.sql");
        System.out.println("✅ Schema initialized.");
    }

    public static void loadTestData(Connection conn) throws Exception {
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM Customer")) {
            rs.next();
            if (rs.getInt(1) == 0) {
                runScript(conn, "data.sql");
                System.out.println("✅ Sample data loaded.");
            } else {
                System.out.println("ℹ️ Skipped loading test data.");
            }
        }
    }

    private static void runScript(Connection conn, String fileName) throws Exception {
        InputStream input = DbConnection.class.getClassLoader().getResourceAsStream(fileName);
        if (input == null) throw new RuntimeException("❌ File not found: " + fileName);

        Scanner scanner = new Scanner(input).useDelimiter(";");
        Statement stmt = conn.createStatement();

        while (scanner.hasNext()) {
            String sql = scanner.next().trim();
            if (!sql.isEmpty()) {
                stmt.execute(sql);
            }
        }

        stmt.close();
        scanner.close();
    }
}