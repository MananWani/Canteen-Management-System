package com.crimsonlogic.cms.dao;

import java.math.BigDecimal;
import java.util.List;

import com.crimsonlogic.cms.model.Payment;

/**
 * @author abdulmanan
 *
 */
public interface PaymentDao {
	List<Payment> fetchAllPayments();

	void insertPayment(BigDecimal total, Integer userId);
}
