//package com.example.project.listener;
//
//import com.example.project.database.DbUtil;
//import com.example.project.util.DbInitializer;
//import javax.servlet.ServletContextEvent;
//import javax.servlet.ServletContextListener;
//import javax.servlet.annotation.WebListener;
//import java.sql.Connection;
//
//@WebListener
//public class AppStartUpListener implements ServletContextListener {
//    @Override
//    public void contextInitialized(ServletContextEvent sce) {
//        try (Connection conn = DbUtil.getConnection()) {
//            System.out.println("🔄 Initializing database on startup...");
//            DbInitializer.initialize(conn);
//        } catch (Exception e) {
//            System.err.println("❌ Error initializing DB at startup: " + e.getMessage());
//            e.printStackTrace();
//        }
//    }
//
//    @Override
//    public void contextDestroyed(ServletContextEvent sce) {
//        System.out.println("🛑 App context destroyed.");
//    }
//}
