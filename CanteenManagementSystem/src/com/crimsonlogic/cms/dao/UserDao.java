package com.crimsonlogic.cms.dao;

import java.math.BigDecimal;

/**
 * @author abdulmanan
 *
 */
public interface UserDao {
	void updateWallet(BigDecimal amount,Integer userId);
}
