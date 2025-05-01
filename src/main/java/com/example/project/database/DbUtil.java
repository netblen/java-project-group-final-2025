package com.example.project.database;

import java.sql.*;
import java.io.*;

public class DbUtil {

    private static Connection connection;

    public static Connection getConnection() throws Exception {
        if (connection != null && !connection.isClosed()) return connection;

        Class.forName("org.h2.Driver");

        File file = new File("../../local-db/bookstore");
        String absolutePath = file.getCanonicalPath();
        String jdbcUrl = "jdbc:h2:file:" + absolutePath + ";AUTO_SERVER=TRUE";

        System.out.println("🔗 Connecting to H2 at: " + jdbcUrl);
        connection = DriverManager.getConnection(jdbcUrl, "sa", "");

        runSchemaSql(connection);
        runDataSql(connection);

        return connection;
    }

    private static void runSchemaSql(Connection conn) throws Exception {
        executeSqlFile(conn, "schema.sql", "✅ Tablas created/verify");
    }

    private static void runDataSql(Connection conn) throws Exception {
        executeSqlFile(conn, "data.sql", "✅ Data inserted");
    }

    private static void executeSqlFile(Connection conn, String resourceName, String successMsg) throws Exception {
        InputStream in = DbUtil.class.getClassLoader().getResourceAsStream(resourceName);

        if (in == null) {
            System.err.println("❌ " + resourceName + " NOT found.");
            return;
        }

        String sql = new String(in.readAllBytes());

        for (String statement : sql.split(";")) {
            if (!statement.trim().isEmpty()) {
                try (Statement stmt = conn.createStatement()) {
                    stmt.execute(statement.trim());
                } catch (SQLException e) {
                    System.err.println("⚠️ Error executing: " + statement);
                    e.printStackTrace();
                }
            }
        }

        System.out.println(successMsg);
    }
}
