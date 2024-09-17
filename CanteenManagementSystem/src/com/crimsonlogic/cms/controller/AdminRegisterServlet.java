package com.crimsonlogic.cms.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.crimsonlogic.cms.config.DatabaseConnection;

/**
 * @author abdulmanan
 *
 */
@WebServlet("/AdminRegisterServlet")
public class AdminRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("name"); 
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String checkEmailQuery = "SELECT COUNT(*) FROM users WHERE user_email = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkEmailQuery)) {
                checkStmt.setString(1, email);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    response.sendRedirect("adminregister/adminregister.jsp?error=emailExists");
                    return;
                }
            }
            String checkUsernameQuery = "SELECT COUNT(*) FROM users WHERE user_username = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkUsernameQuery)) {
                checkStmt.setString(1, username);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    response.sendRedirect("adminregister/adminregister.jsp?error=usernameExists");
                    return;
                }
            }

            String insertUserQuery = "INSERT INTO users (user_username, user_password, user_email, user_role) VALUES (?, ?, ?, 'ADMIN');";
            try (PreparedStatement insertStmt = conn.prepareStatement(insertUserQuery)) {
                insertStmt.setString(1, username);
                insertStmt.setString(2, password);
                insertStmt.setString(3, email);
                int rows = insertStmt.executeUpdate();

                if (rows > 0) {
                    response.sendRedirect("adminhome/adminhome.jsp?success=adminAdded");
                } else {
                    response.sendRedirect("adminregister/adminregister.jsp?error=failed");
                }
            }
        } catch (SQLException e) {
            response.sendRedirect("adminregister/adminregister.jsp?error=db");
        }
    }

}
