package com.crimsonlogic.cms.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.crimsonlogic.cms.config.DatabaseConnection;
import com.crimsonlogic.cms.model.OrderItem;
import com.crimsonlogic.cms.model.Orders;

/**
 * @author abdulmanan
 *
 */
public class OrderDaoImpl implements OrderDao {

	@Override
	public List<Orders> fetchOrdersById(Integer userId) {
		final String selectOrders = "SELECT * FROM orders WHERE order_made_by = ? order by order_date desc;";
		final String selectOrderItems = "SELECT * FROM order_item WHERE order_id = ?;";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Orders> orderList = new ArrayList<>();

		try {
			System.out.println("User ID: " + userId);
			conn = DatabaseConnection.initializeDatabase();

			if (conn != null) {
				pstmt = conn.prepareStatement(selectOrders);
				pstmt.setInt(1, userId);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					Integer orderId = rs.getInt("order_id");
					LocalDate orderDate = DatabaseConnection.getDate(rs.getDate("order_date"));
					BigDecimal orderAmount = rs.getBigDecimal("order_total_amount");
					String orderStatus = rs.getString("order_status");
					Integer orderMadeBy = rs.getInt("order_made_by");
					String orderDescription=rs.getString("order_description");

					Orders order = new Orders(orderId, orderDate, orderAmount, orderStatus, orderMadeBy,orderDescription);

					List<OrderItem> orderItems = new ArrayList<>();
					try (PreparedStatement itemPstmt = conn.prepareStatement(selectOrderItems)) {
						itemPstmt.setInt(1, orderId);
						try (ResultSet itemRs = itemPstmt.executeQuery()) {
							while (itemRs.next()) {

								String itemName = itemRs.getString("order_item_name");
								Integer itemQuantity = itemRs.getInt("order_item_quantity");
								OrderItem orderItem = new OrderItem(itemName, itemQuantity);
								orderItems.add(orderItem);
							}
						}
					}

					order.setOrderItem(orderItems);
					orderList.add(order);
				}

				System.out.println("Order List: " + orderList);
			} else {
				System.out.println("Failed to establish a connection.");
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				System.err.println(e.getMessage());
			}
		}
		return orderList;
	}

	public Integer insertIntoOrders(Orders order) {
		String query = "INSERT INTO orders (order_made_by, order_status, order_total_amount, order_date) VALUES (?, ?, ?, ?)";
		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
			stmt.setInt(1, order.getOrderMadeBy());
			stmt.setString(2, order.getOrderStatus());
			stmt.setBigDecimal(3, order.getOrderTotalAmount());
			stmt.setDate(4, java.sql.Date.valueOf(order.getOrderDate()));

			int affectedRows = stmt.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Creating order failed, no rows affected.");
			}

			try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
				if (generatedKeys.next())
					return generatedKeys.getInt(1);

			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	@Override
	public List<Orders> fetchAllOrders() {
		final String selectAll = "SELECT * FROM orders order by order_date desc;";
		Connection conn = null;
		PreparedStatement pstmt = null;
		List<Orders> orderList = null;
		try {
			conn = DatabaseConnection.initializeDatabase();
			if (conn != null) {
				pstmt = conn.prepareStatement(selectAll);
				orderList = new ArrayList<>();
				ResultSet rs = pstmt.executeQuery();
				while (rs.next()) {
					Integer orderid = rs.getInt("order_id");
					LocalDate orderDate = DatabaseConnection.getDate(rs.getDate("order_date"));
					BigDecimal orderAmount = rs.getBigDecimal("order_total_amount");
					String orderStatus = rs.getString("order_status");
					Integer orderMadeBy = rs.getInt("order_made_by");
					String orderDescription=rs.getString("order_description");
					orderList.add(new Orders(orderid, orderDate, orderAmount, orderStatus, orderMadeBy,orderDescription));
				}
				System.out.println("Order List Size: " + orderList.size());
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
		return orderList;
	}

}
