package com.crimsonlogic.cms.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.crimsonlogic.cms.config.DatabaseConnection;
import com.crimsonlogic.cms.model.Payment;

/**
 * @author abdulmanan
 *
 */
public class PaymentDaoImpl implements PaymentDao {

	@Override
	public List<Payment> fetchAllPayments() {
		final String selectAll = "SELECT * FROM payment order by payment_date desc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		List<Payment> paymentsList = null;
		try {
			conn = DatabaseConnection.initializeDatabase();
			if (conn != null) {
				pstmt = conn.prepareStatement(selectAll);
				paymentsList = new ArrayList<>();
				ResultSet rs = pstmt.executeQuery();
				while (rs.next()) {
					Integer paymentId = rs.getInt("payment_id");
					LocalDate paymentDate = DatabaseConnection.getDate(rs.getDate("payment_date"));
					BigDecimal paymentAmount = rs.getBigDecimal("payment_amount");
					Integer paymentForOrder = rs.getInt("payment_for_order");
					String paymentStatus = rs.getString("payment_status");
					paymentsList
							.add(new Payment(paymentId, paymentAmount, paymentDate, paymentForOrder, paymentStatus));
				}
				System.out.println("Payment List Size: " + paymentsList.size());
			} else {
				System.out.println("Failed to establish a connection.");
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				System.err.println(e.getMessage());
			}
		}
		return paymentsList;
	}

	@Override
	public void insertPayment(BigDecimal total, Integer userId) {
		String insertQuery = "INSERT INTO payment( payment_amount, payment_date, payment_for_order,payment_status) VALUES ( ?, ?, ?, ?);";
		Integer rowAffected = 0;
		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {

			pstmt.setBigDecimal(1, total);
			pstmt.setDate(2, DatabaseConnection.getSqlDate(LocalDate.now()));
			pstmt.setInt(3, userId);
			pstmt.setString(4, "Completed");

			rowAffected = pstmt.executeUpdate();
			System.out.println(rowAffected);

		} catch (SQLException e) {
			System.err.println("SQL Error: " + e.getMessage());

		}
	}
}
