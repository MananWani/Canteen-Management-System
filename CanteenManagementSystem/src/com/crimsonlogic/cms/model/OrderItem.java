package com.crimsonlogic.cms.model;

import java.io.Serializable;
import java.math.BigDecimal;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author abdulmanan
 *
 */
@Data
@NoArgsConstructor
public class OrderItem implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public OrderItem(Integer orderItemQuantity, BigDecimal orderItemPrice,Integer itemId) {
		super();
		this.orderItemQuantity = orderItemQuantity;
		this.orderItemPrice = orderItemPrice;
		this.itemId=itemId;
	}
	public OrderItem(String orderItemName, Integer orderItemQuantity) {
		super();
		this.orderItemName = orderItemName;
		this.orderItemQuantity = orderItemQuantity;
	}
	private Integer orderItemId;
	private String orderItemName;
    private Integer orderItemQuantity;
    private BigDecimal orderItemPrice;
    private Integer orderId;  
    private Integer itemId;   
}
