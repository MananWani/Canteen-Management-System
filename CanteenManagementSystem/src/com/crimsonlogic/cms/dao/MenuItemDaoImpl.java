package com.crimsonlogic.cms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.crimsonlogic.cms.config.DatabaseConnection;
import com.crimsonlogic.cms.model.MenuItem;

/**
 * @author abdulmanan
 *
 */
public class MenuItemDaoImpl implements MenuItemDao {

	public List<MenuItem> getMenuItems() {
		List<MenuItem> items = new ArrayList<>();
		String query = "SELECT * FROM menu_item";

		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement stmt = conn.prepareStatement(query);
				ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				MenuItem item = new MenuItem(rs.getInt("item_id"), rs.getString("item_category"),
						rs.getString("item_name"), rs.getBigDecimal("item_price"), rs.getInt("item_in_stock"),rs.getString("item_type"));
				items.add(item);
			}
			System.out.println(items);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return items;
	}

	@Override
	public Integer updateMenuItem(MenuItem menuItem) {
		String updateQuery = "UPDATE menu_item SET item_category=?, item_name=?, item_price=?, item_in_stock=?, item_type=? WHERE item_id=?;";
		Integer rowsAffected = 0;
		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

			stmt.setString(1, menuItem.getItemCategory());
			stmt.setString(2, menuItem.getItemName());
			stmt.setBigDecimal(3, menuItem.getItemPrice());
			stmt.setInt(4, menuItem.getItemInStock());
			stmt.setString(5, menuItem.getItemType());
			stmt.setInt(6, menuItem.getItemId());

			rowsAffected = stmt.executeUpdate();

			System.out.println("Rows affected: " + rowsAffected);

		} catch (SQLException e) {
			System.out.println("Error updating menu item: " + e.getMessage());
		}
		return rowsAffected;
	}

	@Override
	public Integer deleteMenuItem(Integer itemId) {
		String deleteQuery = "DELETE FROM menu_item WHERE item_id=?;";
		Integer rowsAffected = 0;
		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement stmt = conn.prepareStatement(deleteQuery)) {

			stmt.setInt(1, itemId);

			rowsAffected = stmt.executeUpdate();

			System.out.println("Rows affected: " + rowsAffected);

		} catch (SQLException e) {
			System.out.println("Error deleting menu item: " + e.getMessage());
		}
		return rowsAffected;
	}

	@Override
	public Integer insertMenuItem(MenuItem menuItem) {
		String insertQuery = "INSERT INTO menu_item (item_category, item_name, item_price, item_in_stock,item_type) VALUES (?, ?, ?, ?, ?);";
		Integer rowsAffected = 0;

		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement stmt = conn.prepareStatement(insertQuery)) {

			stmt.setString(1, menuItem.getItemCategory());
			stmt.setString(2, menuItem.getItemName());
			stmt.setBigDecimal(3, menuItem.getItemPrice());
			stmt.setInt(4, menuItem.getItemInStock());
			stmt.setString(5, menuItem.getItemType());

			rowsAffected = stmt.executeUpdate();

			System.out.println("Rows affected: " + rowsAffected);

		} catch (SQLException e) {
			System.out.println("Error inserting menu item: " + e.getMessage());
		}

		return rowsAffected;
	}

	@Override
	public void updateStock(Integer itemId, Integer orderItemQuantity) {

		String selectQuery = "SELECT item_in_stock FROM menu_item WHERE item_id=?";
		String updateQuery = "UPDATE menu_item SET item_in_stock=? WHERE item_id=?";

		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement selectStmt = conn.prepareStatement(selectQuery);
				PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {

			selectStmt.setInt(1, itemId);
			ResultSet rs = selectStmt.executeQuery();

			if (rs.next()) {
				Integer currentStock = rs.getInt("item_in_stock");

				Integer newStock = currentStock - orderItemQuantity;

				updateStmt.setInt(1, newStock);
				updateStmt.setInt(2, itemId);

				int rowsAffected = updateStmt.executeUpdate();
				System.out.println("Rows affected: " + rowsAffected);

			} else {
				System.out.println("Item with ID " + itemId + " not found.");
			}

		} catch (SQLException e) {
			System.out.println("Error updating menu item: " + e.getMessage());
		}
	}

	@Override
	public void restoreStockAfterReject(Integer orderId) {
		String orderItemSelectQuery = "SELECT * FROM order_item WHERE order_id=?";
		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement orderItemStmt = conn.prepareStatement(orderItemSelectQuery)) {

			orderItemStmt.setInt(1, orderId);
			ResultSet rs = orderItemStmt.executeQuery();

			while (rs.next()) {
				Integer orderItemQuantity = rs.getInt("order_item_quantity");
				String orderItemName = rs.getString("order_item_name");

				processItem(orderItemQuantity, orderItemName);
			}

		} catch (SQLException e) {
			System.out.println("Error restoring stock: " + e.getMessage());
		}
	}

	private void processItem(Integer orderItemQuantity, String orderItemName) {
		String menuItemSelectQuery = "SELECT * FROM menu_item WHERE item_name=?";
		String menuItemUpdateQuery = "UPDATE menu_item SET item_in_stock=? WHERE item_name=?";
		try (Connection conn = DatabaseConnection.initializeDatabase();
				PreparedStatement menuItemStmt = conn.prepareStatement(menuItemSelectQuery);
				PreparedStatement updateStmt = conn.prepareStatement(menuItemUpdateQuery)) {

			menuItemStmt.setString(1, orderItemName);
			ResultSet rs = menuItemStmt.executeQuery();

			if (rs.next()) {
				Integer menuItemQuantity = rs.getInt("item_in_stock");
				System.out.println("Previous Quantity: " + menuItemQuantity);
				Integer newQuantity = menuItemQuantity + orderItemQuantity;
				System.out.println("New Quantity: " + newQuantity);

				updateStmt.setInt(1, newQuantity);
				updateStmt.setString(2, orderItemName);

				int result = updateStmt.executeUpdate();
				if (result > 0) {
					System.out.println("Updated stock for item: " + orderItemName);
				}
			}

		} catch (SQLException e) {
			System.out.println("Error updating menu item: " + e.getMessage());
		}
	}

}
