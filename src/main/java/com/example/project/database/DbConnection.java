package com.example.project.database;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Scanner;

//import java.io.InputStream;
//import java.sql.Connection;
//import java.sql.Statement;
//import java.util.Scanner;
//
//public class DbConnection {
//    public static void initializeDatabase(Connection conn) throws Exception {
//        InputStream input = DbConnection.class.getClassLoader().getResourceAsStream("schema.sql");
//        if (input == null) {
//            throw new RuntimeException("There's no schema.sql find in the classpath");
//        }
//
//        Scanner scanner = new Scanner(input).useDelimiter(";");
//        Statement stmt = conn.createStatement();
//
//        while (scanner.hasNext()) {
//            String sql = scanner.next().trim();
//            if (!sql.isEmpty()) {
//                stmt.execute(sql);
//            }
//        }
//
//        stmt.close();
//        scanner.close();
//    }
//}

public class DbConnection {

    private static final String DB_URL = "jdbc:h2:./bookstore"; // uses bookstore.mv.db file
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "";

    // Method to get DB connection
    public static Connection getConnection() throws Exception {
        Class.forName("org.h2.Driver"); // Make sure the H2 driver is on your classpath
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // Initializes the DB schema + data
    public static void initializeDatabase(Connection conn) throws Exception {
        runScript(conn, "schema.sql");
        runScript(conn, "data.sql");
        System.out.println("✅ Database initialized with schema and test data.");
    }

    // Helper to run a SQL script from resources
    private static void runScript(Connection conn, String fileName) throws Exception {
        InputStream input = DbConnection.class.getClassLoader().getResourceAsStream(fileName);
        if (input == null) {
            throw new RuntimeException("❌ File not found in classpath: " + fileName);
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
