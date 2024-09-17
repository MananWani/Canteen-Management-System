package com.crimsonlogic.cms.controller;

import java.io.IOException;
import java.math.BigDecimal;
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
@WebServlet("/EditItemServlet")
public class EditItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MenuItemDao menuItemDao;

	public void init() {
		menuItemDao = new MenuItemDaoImpl();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Integer itemId = Integer.parseInt(req.getParameter("itemId"));
		String itemName = req.getParameter("itemName");
		BigDecimal itemPrice = new BigDecimal(req.getParameter("itemPrice"));
		String itemCategory = req.getParameter("itemCategory");
		Integer itemInStock = Integer.parseInt(req.getParameter("itemInStock"));
        String	itemType=req.getParameter("itemType");


		MenuItem menuItem = new MenuItem();
		menuItem.setItemId(itemId);
		menuItem.setItemName(itemName);
		menuItem.setItemPrice(itemPrice);
		menuItem.setItemCategory(itemCategory);
		menuItem.setItemInStock(itemInStock);
		menuItem.setItemType(itemType);

		Integer result = menuItemDao.updateMenuItem(menuItem);
		if (result != 0) {
			HttpSession session = req.getSession();
			@SuppressWarnings("unchecked")
			List<MenuItem> menuItems = (List<MenuItem>) session.getAttribute("menuItems");

			if (menuItems != null) {
				for (int i = 0; i < menuItems.size(); i++) {
					MenuItem item = menuItems.get(i);
					if (item.getItemId().equals(itemId)) {
						menuItems.set(i, menuItem);
						break;
					}
				}
				session.setAttribute("menuItems", menuItems);
				resp.sendRedirect("adminmenu/adminmenu.jsp?success=updated");
			}
		}

		else {
			resp.sendRedirect("adminmenu/adminmenu.jsp?error=notUpdated");

		}
	}
}
