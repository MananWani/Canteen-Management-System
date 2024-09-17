package com.crimsonlogic.cms.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crimsonlogic.cms.config.DatabaseConnection;

/**
 * @author abdulmanan
 *
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement stmt = conn
						.prepareStatement("SELECT * FROM users WHERE user_username = ? AND user_password = ?")) {
			stmt.setString(1, username);
			stmt.setString(2, password);

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				String role = rs.getString("user_role");
				BigDecimal wallet = rs.getBigDecimal("user_wallet");
				String mail = rs.getString("user_email");
				String mobile = rs.getString("user_mobile_no");
				HttpSession session = request.getSession();
				session.setAttribute("username", username);
				session.setAttribute("role", role);
				session.setAttribute("currentBalance", wallet);
				session.setAttribute("mail", mail);
				session.setAttribute("mobile", mobile);

				if ("ADMIN".equals(role)) {
					response.sendRedirect("adminhome/adminhome.jsp");
				} else {
					response.sendRedirect("home/home.jsp");
				}
			} else {
				response.sendRedirect("login/login.jsp?error=invalidUser");
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			response.sendRedirect("login/login.jsp?error=db");
		}
	}
}
