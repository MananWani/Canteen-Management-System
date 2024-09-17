package com.crimsonlogic.cms.dao;

import java.util.List;

import com.crimsonlogic.cms.model.Orders;

/**
 * @author abdulmanan
 *
 */
public interface OrderDao {
	List<Orders> fetchOrdersById(Integer userId);
	Integer insertIntoOrders(Orders o);
	List<Orders> fetchAllOrders();
}
