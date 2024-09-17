package com.crimsonlogic.cms.controller;

import java.io.IOException;
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
public class RemoveFromCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String itemName = request.getParameter("itemName");

		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		Map<String, OrderItem> cart = (Map<String, OrderItem>) session.getAttribute("cart");

		if (cart != null) {
			OrderItem item = cart.get(itemName);

			if (item != null) {
				int currentQuantity = item.getOrderItemQuantity();

				if (currentQuantity > 1) {
					item.setOrderItemQuantity(currentQuantity - 1);
					cart.put(itemName, item);
				} else {
					cart.remove(itemName);
				}

				session.setAttribute("cart", cart);
			}
		}

		response.sendRedirect("cart/cart.jsp");
	}
}
