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
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("name");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String mobile=request.getParameter("mobile");

		try (Connection conn = DatabaseConnection.initializeDatabase()) {
			String checkUsernameQuery = "SELECT COUNT(*) FROM users WHERE user_username = ?";
			try (PreparedStatement checkStmt = conn.prepareStatement(checkUsernameQuery)) {
				checkStmt.setString(1, username);
				ResultSet rs = checkStmt.executeQuery();
				if (rs.next() && rs.getInt(1) > 0) {
					response.sendRedirect("register/register.jsp?error=usernameExists");
					return;
				}
			}
			String checkEmailQuery = "SELECT COUNT(*) FROM users WHERE user_email = ?";
			try (PreparedStatement checkStmt = conn.prepareStatement(checkEmailQuery)) {
				checkStmt.setString(1, email);
				ResultSet rs = checkStmt.executeQuery();
				if (rs.next() && rs.getInt(1) > 0) {
					response.sendRedirect("register/register.jsp?error=emailExists");
					return;
				}
			}
			String checkMobileQuery = "SELECT COUNT(*) FROM users WHERE user_mobile_no = ?";
			try (PreparedStatement checkStmt = conn.prepareStatement(checkMobileQuery)) {
				checkStmt.setString(1, mobile);
				ResultSet rs = checkStmt.executeQuery();
				if (rs.next() && rs.getInt(1) > 0) {
					response.sendRedirect("register/register.jsp?error=mobileExists");
					return;
				}
			}
			

			String insertUserQuery = "INSERT INTO users (user_username, user_password, user_email, user_mobile_no, user_role) VALUES (?, ?, ?, ?, 'USER');";
			try (PreparedStatement insertStmt = conn.prepareStatement(insertUserQuery)) {
				insertStmt.setString(1, username);
				insertStmt.setString(2, password);
				insertStmt.setString(3, email);
				insertStmt.setString(4, mobile);
				int rows = insertStmt.executeUpdate();

				if (rows > 0) {
					response.sendRedirect("login/login.jsp?success=userAdded");
				} else {
					response.sendRedirect("register/register.jsp?error=failed");
				}
			}
		} catch (SQLException e) {
			response.sendRedirect("register/register.jsp?error=db");
		}
	}
}
