package com.crimsonlogic.cms.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crimsonlogic.cms.config.DatabaseConnection;
import com.crimsonlogic.cms.dao.MenuItemDao;
import com.crimsonlogic.cms.dao.MenuItemDaoImpl;
import com.crimsonlogic.cms.dao.OrderDao;
import com.crimsonlogic.cms.dao.OrderDaoImpl;
import com.crimsonlogic.cms.dao.OrderItemDao;
import com.crimsonlogic.cms.dao.OrderItemDaoImpl;
import com.crimsonlogic.cms.dao.PaymentDao;
import com.crimsonlogic.cms.dao.PaymentDaoImpl;
import com.crimsonlogic.cms.dao.UserDao;
import com.crimsonlogic.cms.dao.UserDaoImpl;
import com.crimsonlogic.cms.model.OrderItem;
import com.crimsonlogic.cms.model.Orders;

/**
 * @author abdulmanan
 *
 */
@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	OrderDao orderDao = null;
	OrderItemDao orderItemDao = null;
	MenuItemDao menuItemDao = null;
	PaymentDao paymentDao = null;
	UserDao userDao = null;

	public void init() {
		orderDao = new OrderDaoImpl();
		orderItemDao = new OrderItemDaoImpl();
		menuItemDao = new MenuItemDaoImpl();
		paymentDao = new PaymentDaoImpl();
		userDao = new UserDaoImpl();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement statement = conn
						.prepareStatement("SELECT user_wallet FROM users WHERE user_username = ?")) {

			statement.setString(1, username);
			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				BigDecimal currentBalance = resultSet.getBigDecimal("user_wallet");
				System.out.println(currentBalance);
				session.setAttribute("currentBalance", currentBalance);
			}
		} catch (SQLException e) {
			response.sendRedirect("profile/profile.jsp?error=db");
		}
		BigDecimal currentBalance = (BigDecimal) session.getAttribute("currentBalance");
		BigDecimal total = new BigDecimal(request.getParameter("totalAmount"));
		System.out.println(total);

		@SuppressWarnings("unchecked")
		Map<String, OrderItem> cart = (Map<String, OrderItem>) session.getAttribute("cart");

		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement statement = conn
						.prepareStatement("SELECT user_id FROM users WHERE user_username = ?")) {

			statement.setString(1, username);
			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				Integer userId = resultSet.getInt("user_id");

				Orders o = new Orders();
				o.setOrderMadeBy(userId);
				o.setOrderStatus("In Progress");
				o.setOrderTotalAmount(total);
				o.setOrderDate(LocalDate.now());

				Integer orderId = orderDao.insertIntoOrders(o);

				List<OrderItem> orderItems = new ArrayList<>();

				for (Map.Entry<String, OrderItem> entry : cart.entrySet()) {
					OrderItem cartItem = entry.getValue();

					OrderItem orderItem = new OrderItem();
					orderItem.setOrderItemName(entry.getKey());
					orderItem.setItemId(cartItem.getItemId());
					orderItem.setOrderItemQuantity(cartItem.getOrderItemQuantity());
					orderItem.setOrderItemPrice(cartItem.getOrderItemPrice());
					orderItem.setOrderId(orderId);

					orderItems.add(orderItem);

					menuItemDao.updateStock(cartItem.getItemId(), cartItem.getOrderItemQuantity());
				}

				paymentDao.insertPayment(total, orderId);
				System.out.println(orderItems);

				for (OrderItem item : orderItems) {
					orderItemDao.insertIntoOrderItem(item);
				}
				BigDecimal newBalance = currentBalance.subtract(total);
				session.setAttribute("currentBalance", newBalance);
				userDao.updateWallet(total, userId);
				session.setAttribute("cart", new HashMap<String, OrderItem>());
				response.sendRedirect("cart/cart.jsp?success=orderSuccess");

			} else {
				response.sendRedirect("payment/payment.jsp?error=notFound");
			}

		} catch (SQLException e) {
			response.sendRedirect("payment/payment.jsp?error=db");
		}
	}
}
