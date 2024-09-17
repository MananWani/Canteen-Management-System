package com.crimsonlogic.cms.controller;

import java.io.IOException;
import java.util.ArrayList;
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
@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve the role from the session
        String role = (String) session.getAttribute("role");
        MenuItemDao dao = new MenuItemDaoImpl();
        List<MenuItem> menuItems = dao.getMenuItems();

        String itemType = request.getParameter("itemtype");
        if (itemType == null) {
            itemType = "both"; 
        }
        System.out.println(itemType);

        List<MenuItem> filteredItems = new ArrayList<>();
        for (MenuItem item : menuItems) {
            if ("both".equals(itemType) || itemType.equalsIgnoreCase(item.getItemType())) {
                filteredItems.add(item);
            }
        }

        session.setAttribute("menuItems", filteredItems);

        if ("ADMIN".equalsIgnoreCase(role)) {
            response.sendRedirect("adminmenu/adminmenu.jsp");
        } else {
            response.sendRedirect("menu/menu.jsp");
        }
    }
}

