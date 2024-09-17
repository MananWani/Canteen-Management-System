package com.crimsonlogic.cms.dao;

import java.util.List;

import com.crimsonlogic.cms.model.MenuItem;

/**
 * @author abdulmanan
 *
 */
public interface MenuItemDao {

	List<MenuItem> getMenuItems();
	Integer updateMenuItem(MenuItem menuItem);
	Integer deleteMenuItem(Integer itemId);
	Integer insertMenuItem(MenuItem menuItem);
	void updateStock(Integer itemId, Integer orderItemQuantity);
	void restoreStockAfterReject(Integer orderId);

}
