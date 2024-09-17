package com.crimsonlogic.cms.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crimsonlogic.cms.dao.MenuItemDao;
import com.crimsonlogic.cms.dao.MenuItemDaoImpl;
import com.crimsonlogic.cms.model.MenuItem;

/**
 * @author abdulmanan
 *
 */
@WebServlet("/DeleteItemServlet")
public class DeleteItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MenuItemDao menuItemDao;

	public void init() {
		menuItemDao = new MenuItemDaoImpl();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Integer itemId = Integer.parseInt(req.getParameter("itemId"));

		Integer result = menuItemDao.deleteMenuItem(itemId);
		if (result != 0) {

			HttpSession session = req.getSession();
			@SuppressWarnings("unchecked")
			List<MenuItem> menuItems = (List<MenuItem>) session.getAttribute("menuItems");

			if (menuItems != null) {
				menuItems.removeIf(item -> item.getItemId().equals(itemId));
				session.setAttribute("menuItems", menuItems);
			}

			resp.sendRedirect("adminmenu/adminmenu.jsp?success=deleted");
		} else {
			resp.sendRedirect("adminmenu/adminmenu.jsp?error=notUpdated");

		}
	}

}
