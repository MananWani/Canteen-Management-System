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
public class Payment implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Payment(Integer paymentId, BigDecimal paymentAmount, LocalDate paymentDate, Integer paymentForOrder,String paymentStatus) {
		super();
		this.paymentId = paymentId;
		this.paymentAmount = paymentAmount;
		this.paymentDate = paymentDate;
		this.paymentForOrder = paymentForOrder;
		this.paymentStatus= paymentStatus;
	}
	private Integer paymentId;
    private BigDecimal paymentAmount;
    private LocalDate paymentDate;
    private Integer paymentForOrder;  // Foreign key to Order
    private String paymentStatus;
}
