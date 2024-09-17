package com.crimsonlogic.cms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.crimsonlogic.cms.config.DatabaseConnection;
import com.crimsonlogic.cms.model.OrderItem;

/**
 * @author abdulmanan
 *
 */
public class OrderItemDaoImpl implements OrderItemDao {

	@Override
	public void insertIntoOrderItem(OrderItem orderItem) {

		final String insertQuery = "INSERT INTO order_item( order_id, item_id, order_item_quantity, order_item_price,order_item_name)VALUES (?, ?, ?, ?, ?);";
		Integer rowAffected = 0;
		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {

			pstmt.setInt(1, orderItem.getOrderId());
			pstmt.setInt(2, orderItem.getItemId());
			pstmt.setInt(3, orderItem.getOrderItemQuantity());
			pstmt.setBigDecimal(4, orderItem.getOrderItemPrice());
			pstmt.setString(5, orderItem.getOrderItemName());

			rowAffected = pstmt.executeUpdate();
			System.out.println(rowAffected);

		} catch (SQLException e) {
			System.err.println("SQL Error: " + e.getMessage());

		}
	}

}
