package com.crimsonlogic.cms.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crimsonlogic.cms.config.DatabaseConnection;
import com.crimsonlogic.cms.dao.OrderDao;
import com.crimsonlogic.cms.dao.OrderDaoImpl;
import com.crimsonlogic.cms.model.Orders;

/**
 * @author abdulmanan
 *
 */
@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private OrderDao orderDao;

	public void init() {
		orderDao = new OrderDaoImpl();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		String username = (String) session.getAttribute("username");
		String role = (String) session.getAttribute("role");

		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement statement = conn
						.prepareStatement("SELECT user_id,user_role FROM users WHERE user_username = ?")) {

			statement.setString(1, username);
			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				if (role.equalsIgnoreCase("ADMIN")) {
					List<Orders> orderList = orderDao.fetchAllOrders();
					session.setAttribute("orderList", orderList);
					resp.sendRedirect("adminorder/adminorder.jsp");
				} else {
					Integer userId = resultSet.getInt("user_id");
					System.out.println(userId);
					List<Orders> orderList = orderDao.fetchOrdersById(userId);
					session.setAttribute("orderList", orderList);
					resp.sendRedirect("order/order.jsp");
				}

			} else {
				resp.sendRedirect("order/order.jsp?error=notFound");
			}
		} catch (SQLException e) {
			resp.sendRedirect("order/order.jsp?error=db");
		}

	}
}

