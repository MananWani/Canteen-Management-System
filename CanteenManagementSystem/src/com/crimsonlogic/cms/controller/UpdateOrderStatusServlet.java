package com.crimsonlogic.cms.controller;

import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crimsonlogic.cms.config.DatabaseConnection;
import com.crimsonlogic.cms.dao.MenuItemDao;
import com.crimsonlogic.cms.dao.MenuItemDaoImpl;
import com.crimsonlogic.cms.model.Orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * @author abdulmanan
 *
 */
@WebServlet("/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String completed="Order completed successfully. Thank you for ordering.";
	private static final String rejected="Order rejected due to operational constraints. Sorry for the inconvenience. Order amount has been refunded.";

	

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer orderId = Integer.parseInt(request.getParameter("orderId"));
		String orderStatus = request.getParameter("orderStatus");
		//SQL query to update order status and description
		String updateOrder = "UPDATE orders SET order_status = ?,order_description=? WHERE order_id = ?";
		//SQL query to fetch userid and total amount
		String getUserIdAndAmount = "SELECT order_made_by, order_total_amount FROM orders WHERE order_id = ?";
		//SQL query to update wallet
		String updateWallet = "UPDATE users SET user_wallet = user_wallet + ? WHERE user_id = ?";
		//SQL query to update payment status
		String updatePayment = "Update payment set payment_status='Refunded' where payment_for_order=?;";

		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement updateOrderStmt = conn.prepareStatement(updateOrder);
				PreparedStatement getUserIdAndAmountStmt = conn.prepareStatement(getUserIdAndAmount);
				PreparedStatement updateWalletStmt = conn.prepareStatement(updateWallet);
				PreparedStatement updatePaymentStmt = conn.prepareStatement(updatePayment)) {

			updateOrderStmt.setString(1, orderStatus);
			if("rejected".equalsIgnoreCase(orderStatus)) {
				updateOrderStmt.setString(2, rejected);
			}else {
				updateOrderStmt.setString(2, completed);
			}
			updateOrderStmt.setInt(3, orderId);
			int rowsAffected = updateOrderStmt.executeUpdate();

			if (rowsAffected > 0) {
				if ("rejected".equalsIgnoreCase(orderStatus)) {

					getUserIdAndAmountStmt.setInt(1, orderId);
					ResultSet rs = getUserIdAndAmountStmt.executeQuery();

					if (rs.next()) {
						Integer userId = rs.getInt("order_made_by");
						BigDecimal refundAmount = rs.getBigDecimal("order_total_amount");

						updateWalletStmt.setBigDecimal(1, refundAmount);
						updateWalletStmt.setInt(2, userId);
						updateWalletStmt.executeUpdate();

						updatePaymentStmt.setInt(1, orderId);
						updatePaymentStmt.executeUpdate();

						MenuItemDao menuItemDao = new MenuItemDaoImpl();
						menuItemDao.restoreStockAfterReject(orderId);
					}
				}

				HttpSession session = request.getSession();
				@SuppressWarnings("unchecked")
				ArrayList<Orders> orderList = (ArrayList<Orders>) session.getAttribute("orderList");

				if (orderList != null) {
					for (Orders order : orderList) {
						if (order.getOrderId().equals(orderId)) {
							order.setOrderStatus(orderStatus);
							break;
						}
					}
					session.setAttribute("orderList", orderList);
					response.sendRedirect("adminorder/adminorder.jsp?success=success");
				}
			} else {
				response.sendRedirect("adminorder/adminorder.jsp?error=notFound");
			}

		} catch (SQLException e) {
			response.sendRedirect("adminorder/adminorder.jsp?error=error");
		}
	}

}
