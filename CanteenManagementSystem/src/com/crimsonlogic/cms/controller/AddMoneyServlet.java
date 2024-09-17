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
@WebServlet("/AddMoneyServlet")
public class AddMoneyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");

		if (username == null) {
			response.sendRedirect("payment/payment.jsp?error=notFound");
			return;
		}

		BigDecimal amountToAdd;

		amountToAdd = new BigDecimal(request.getParameter("amountToAdd"));

		try (Connection conn = DatabaseConnection.initializeDatabase()) {

			String selectQuery = "SELECT user_wallet FROM users WHERE user_username = ?";
			try (PreparedStatement selectStatement = conn.prepareStatement(selectQuery)) {
				selectStatement.setString(1, username);
				ResultSet resultSet = selectStatement.executeQuery();

				if (resultSet.next()) {
					BigDecimal currentBalance = resultSet.getBigDecimal("user_wallet");

					BigDecimal newBalance = currentBalance.add(amountToAdd);

					String updateQuery = "UPDATE users SET user_wallet = ? WHERE user_username = ?";
					try (PreparedStatement updateStatement = conn.prepareStatement(updateQuery)) {
						updateStatement.setBigDecimal(1, newBalance);
						updateStatement.setString(2, username);
						int rowsUpdated = updateStatement.executeUpdate();

						if (rowsUpdated > 0) {
							session.setAttribute("currentBalance", newBalance);
							response.sendRedirect("profile/profile.jsp?success=balanceUpdated");
						} else {
							response.sendRedirect("profile/profile.jsp?error=updateFailed");
						}
					}
				} else {
					response.sendRedirect("profile/profile.jsp?error=userNotFound");
				}
			}
		} catch (SQLException e) {
			response.sendRedirect("profile/profile.jsp?error=db");
		}
	}
}
