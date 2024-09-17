package com.crimsonlogic.cms.controller;

import java.io.IOException;
import java.math.BigDecimal;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crimsonlogic.cms.model.OrderItem;

/**
 * @author abdulmanan
 *
 */
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		@SuppressWarnings("unchecked")
		Map<String, OrderItem> cart = (Map<String, OrderItem>) session.getAttribute("cart");
		if (cart == null) {
			cart = new HashMap<>();
			session.setAttribute("cart", cart);
		}
		String itemName = request.getParameter("itemName");
		BigDecimal itemPrice = new BigDecimal(request.getParameter("itemPrice"));
		Integer itemQuantity = Integer.parseInt(request.getParameter("itemQuantity"));
		Integer itemId = Integer.parseInt(request.getParameter("itemId"));

		OrderItem item = cart.get(itemName);
		if (item == null) {
			item = new OrderItem(itemQuantity, itemPrice, itemId);
		} else {
			item = new OrderItem(item.getOrderItemQuantity() + itemQuantity, item.getOrderItemPrice(), itemId);
		}
		cart.put(itemName, item);
		System.out.println(cart);
		response.sendRedirect("menu/menu.jsp?success=addedtocart");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();

		@SuppressWarnings("unchecked")
		Map<String, OrderItem> cart = (Map<String, OrderItem>) session.getAttribute("cart");

		if (cart == null) {
			cart = new HashMap<>();
		}

		session.setAttribute("cart", cart);

		response.sendRedirect("cart/cart.jsp");
	}

}
