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
public class MenuItem implements Serializable{
	
	private static final long serialVersionUID = 1L;
	public MenuItem(Integer itemId, String itemCategory, String itemName, BigDecimal itemPrice, Integer itemInStock,String itemType) {
		super();
		this.itemId = itemId;
		this.itemCategory = itemCategory;
		this.itemName = itemName;
		this.itemPrice = itemPrice;
		this.itemInStock = itemInStock;
		this.itemType=itemType;
	}
	private Integer itemId;
    private String itemCategory;
    private String itemName;
    private BigDecimal itemPrice;
    private Integer itemInStock;
    private String itemType;
}
