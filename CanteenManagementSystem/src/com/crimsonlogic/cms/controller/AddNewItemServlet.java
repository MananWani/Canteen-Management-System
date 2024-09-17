package com.crimsonlogic.cms.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.crimsonlogic.cms.config.DatabaseConnection;
import com.crimsonlogic.cms.dao.MenuItemDao;
import com.crimsonlogic.cms.dao.MenuItemDaoImpl;
import com.crimsonlogic.cms.model.MenuItem;

/**
 * @author abdulmanan
 *
 */
@WebServlet("/AddNewItemServlet")
public class AddNewItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MenuItemDao menuItemDao;

	public void init() {
		menuItemDao = new MenuItemDaoImpl();
	}
	
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		 String itemName = req.getParameter("itemName");
	        BigDecimal itemPrice = new BigDecimal(req.getParameter("itemPrice"));
	        String itemCategory = req.getParameter("itemCategory");
	        Integer itemInStock = Integer.parseInt(req.getParameter("itemInStock"));
	        String	itemType=req.getParameter("itemType");
	        
		try (Connection conn = DatabaseConnection.initializeDatabase()) {
			String checkMenuItem = "SELECT COUNT(*) FROM menu_item WHERE item_name = ?";
			try (PreparedStatement checkStmt = conn.prepareStatement(checkMenuItem)) {
				checkStmt.setString(1, itemName);
				ResultSet rs = checkStmt.executeQuery();
				if (rs.next() && rs.getInt(1) > 0) {
					resp.sendRedirect("admin/additem.jsp?error=itemnameExists");
					return;
				}
			}} catch (SQLException e) {
				resp.sendRedirect("admin/additem.jsp?error=db");
			}
       
        
        MenuItem menuItem = new MenuItem();
        menuItem.setItemName(itemName);
        menuItem.setItemPrice(itemPrice);
        menuItem.setItemCategory(itemCategory);
        menuItem.setItemInStock(itemInStock);
        menuItem.setItemType(itemType);
        
        Integer result=menuItemDao.insertMenuItem(menuItem);
        if(result!=0)
        resp.sendRedirect("adminhome/adminhome.jsp?success=inserted");
        else {
            resp.sendRedirect("adminmenu/adminmenu.jsp?error=notUpdated");

        }
    }
}
