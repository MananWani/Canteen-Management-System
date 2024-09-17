package com.crimsonlogic.cms.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.crimsonlogic.cms.config.DatabaseConnection;

/**
 * @author abdulmanan
 *
 */
public class UserDaoImpl implements UserDao {

	@Override
	public void updateWallet(BigDecimal amount, Integer userId) {

		String fetchQuery = "SELECT user_wallet FROM users WHERE user_id = ?";
		String updateQuery = "UPDATE users SET user_wallet = ? WHERE user_id = ?";

		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement fetchStmt = conn.prepareStatement(fetchQuery);
				PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {

			fetchStmt.setInt(1, userId);
			ResultSet rs = fetchStmt.executeQuery();

			if (rs.next()) {
				BigDecimal currentBalance = rs.getBigDecimal("user_wallet");
				System.out.println(currentBalance);
				System.out.println(amount);
				BigDecimal newBalance = currentBalance.subtract(amount);

				updateStmt.setBigDecimal(1, newBalance);
				updateStmt.setInt(2, userId);

				int rowsAffected = updateStmt.executeUpdate();

				if (rowsAffected == 0) {
					System.out.println("No rows updated. Check if the user exists.");
				} else {
					System.out.println("Wallet updated successfully.");
				}

			} else {
				System.out.println("User not found.");
			}

		} catch (SQLException e) {
			System.out.println("Error updating wallet: " + e.getMessage());
		}
	}

}
