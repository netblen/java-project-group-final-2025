package com.example.project.database;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.Statement;
import java.util.Scanner;

public class DbConnection {
    public static void initializeSchema(Connection conn) throws Exception {
        runScript(conn, "schema.sql");
        System.out.println("✅ Schema initialized.");
    }

    // Run data.sql only if needed
    public static void loadTestData(Connection conn) throws Exception {
        runScript(conn, "data.sql");
        System.out.println("✅ Sample data loaded.");
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