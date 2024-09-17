package com.crimsonlogic.cms.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author abdulmanan
 *
 */
@Data
@NoArgsConstructor
public class Orders implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Orders(Integer orderId, LocalDate orderDate, BigDecimal orderTotalAmount, String orderStatus,
			Integer orderMadeBy,String orderDescription) {
		super();
		this.orderId = orderId;
		this.orderDate = orderDate;
		this.orderTotalAmount = orderTotalAmount;
		this.orderStatus = orderStatus;
		this.orderMadeBy = orderMadeBy;
		this.orderDescription=orderDescription;
	}
	public Orders(Integer orderId, LocalDate orderDate, BigDecimal orderTotalAmount, String orderStatus) {
		super();
		this.orderId = orderId;
		this.orderDate = orderDate;
		this.orderTotalAmount = orderTotalAmount;
		this.orderStatus = orderStatus;
	}
	private Integer orderId;
    private LocalDate orderDate;
    private BigDecimal orderTotalAmount;
    private String orderStatus;
    private Integer orderMadeBy;
    private String orderDescription;
    private List<OrderItem> orderItem;
}
