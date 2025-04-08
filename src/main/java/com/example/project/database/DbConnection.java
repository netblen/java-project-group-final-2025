package com.example.project.database;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.Statement;
import java.util.Scanner;

public class DbConnection {
    public static void initializeDatabase(Connection conn) throws Exception {
        InputStream input = DbConnection.class.getClassLoader().getResourceAsStream("schema.sql");
        if (input == null) {
            throw new RuntimeException("Theres no schema.sql find in the classpath");
        }

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
