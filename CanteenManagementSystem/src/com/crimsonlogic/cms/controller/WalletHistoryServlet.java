package com.crimsonlogic.cms.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crimsonlogic.cms.config.DatabaseConnection;
import com.crimsonlogic.cms.model.WalletHistory;

/**
 * @author abdulmanan
 *
 */
@WebServlet("/WalletHistoryServlet")
public class WalletHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");

		List<WalletHistory> walletList = new ArrayList<>();
		String userIdQuery = "SELECT user_id FROM users WHERE user_username = ?";
		String walletHistoryQuery = "SELECT * FROM wallet_history WHERE user_id = ?";

		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement userstmt = conn.prepareStatement(userIdQuery);
				PreparedStatement psHistory = conn.prepareStatement(walletHistoryQuery)) {

			userstmt.setString(1, username);
			ResultSet rs = userstmt.executeQuery();
			if (rs.next()) {
				Integer userId = rs.getInt("user_id");
				System.out.println(userId);
				psHistory.setInt(1, userId);
				ResultSet rsHistory = psHistory.executeQuery();
				while (rsHistory.next()) {
					WalletHistory history = new WalletHistory();
					history.setHistoryId(rsHistory.getInt("history_id"));
					history.setUserId(userId);
					history.setOldWallet(rsHistory.getBigDecimal("old_wallet"));
					history.setNewWallet(rsHistory.getBigDecimal("new_wallet"));
					history.setAction(rsHistory.getString("action"));
					history.setChangeDate(DatabaseConnection.getDate(rsHistory.getDate("change_date")));
					walletList.add(history);
				}
				System.out.println(walletList);
			} else {
				response.sendRedirect("profile/profile.jsp?error=notFound");
				return;
			}

		} catch (SQLException e) {
			System.out.println(e.getMessage());
			response.sendRedirect("profile/profile.jsp?error=db");
			return;
		}

		session.setAttribute("walletList", walletList);

		response.sendRedirect("wallet/wallet.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
