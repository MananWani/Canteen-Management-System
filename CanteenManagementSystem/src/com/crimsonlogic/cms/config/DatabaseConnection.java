package com.crimsonlogic.cms.config;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.LocalDate;

/**
 * @author abdulmanan
 *
 */
public class DatabaseConnection {
    private static final String URL = "jdbc:postgresql://localhost:5432/CanteenManagementSystem";
    private static final String USER = "postgres"; 
    private static final String PASSWORD = "crimson@123"; 
    public static Connection initializeDatabase() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver"); 
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("PostgreSQL JDBC Driver not found", e);
        }
    }
    public static Date getSqlDate(LocalDate dt) {
		return java.sql.Date.valueOf(dt);
	}
	public static LocalDate getDate(Date date) {
		return date.toLocalDate();
	}
}
