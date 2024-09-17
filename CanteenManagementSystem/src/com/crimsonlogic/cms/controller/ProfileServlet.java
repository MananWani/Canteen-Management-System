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
@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
		String role = (String) session.getAttribute("role");
		if (!"ADMIN".equalsIgnoreCase(role)) {
            try (Connection conn = DatabaseConnection.initializeDatabase();
                 PreparedStatement statement = conn.prepareStatement("SELECT user_wallet FROM users WHERE user_username = ?")) {

                statement.setString(1, username);
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    BigDecimal currentBalance = resultSet.getBigDecimal("user_wallet");
                    session.setAttribute("currentBalance", currentBalance);
                }
            } catch (SQLException e) {
                response.sendRedirect("profile/profile.jsp?error=db");
                return;
            }
        }
		String redirectPage = "ADMIN".equalsIgnoreCase(role) ? "adminprofile/adminprofile.jsp" : "profile/profile.jsp";
		response.sendRedirect(redirectPage);

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		String role = (String) session.getAttribute("role");
		
		String currentPassword = request.getParameter("current-password");
		String newPassword = request.getParameter("new-password");

		try (Connection conn = DatabaseConnection.initializeDatabase()) {
			
			String verifyPasswordSQL = "SELECT user_password FROM users WHERE user_username = ?";
			try (PreparedStatement verifyStatement = conn.prepareStatement(verifyPasswordSQL)) {
				verifyStatement.setString(1, username);
				ResultSet resultSet = verifyStatement.executeQuery();

				if (resultSet.next()) {
					String storedPassword = resultSet.getString("user_password");
					if (!storedPassword.equals(currentPassword)) {
						String errorPage = "ADMIN".equalsIgnoreCase(role) ? "adminprofile/adminprofile.jsp"
								: "profile/profile.jsp";
						response.sendRedirect(errorPage + "?error=incorrectCurrentPassword");
						return;
					}
				} else {
					String errorPage = "ADMIN".equalsIgnoreCase(role) ? "adminprofile/adminprofile.jsp"
							: "profile/profile.jsp";
					response.sendRedirect(errorPage + "?error=notFound");
					return;
				}
			}

			String updatePasswordSQL = "UPDATE users SET user_password = ? WHERE user_username = ?";
			try (PreparedStatement updateStatement = conn.prepareStatement(updatePasswordSQL)) {
				updateStatement.setString(1, newPassword);
				updateStatement.setString(2, username);
				int result = updateStatement.executeUpdate();

				String successOrErrorPage = (result > 0) ? "success=changed" : "error=notFound";
				String redirectPage = "ADMIN".equalsIgnoreCase(role) ? "adminprofile/adminprofile.jsp"
						: "profile/profile.jsp";
				response.sendRedirect(redirectPage + "?" + successOrErrorPage);
			}
		} catch (SQLException e) {
			String errorPage = "ADMIN".equalsIgnoreCase(role) ? "adminprofile/adminprofile.jsp" : "profile/profile.jsp";
			response.sendRedirect(errorPage + "?error=db");
		}
	}
}
