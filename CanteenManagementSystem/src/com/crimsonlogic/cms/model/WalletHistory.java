package com.crimsonlogic.cms.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

import lombok.Data;
import lombok.NoArgsConstructor;


/**
 * @author abdulmanan
 *
 */
@Data
@NoArgsConstructor
public class WalletHistory implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	Integer historyId;
	Integer userId;
	BigDecimal oldWallet;
	BigDecimal newWallet;
	String action;
	LocalDate changeDate;
}
