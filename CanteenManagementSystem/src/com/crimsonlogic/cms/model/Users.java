package com.crimsonlogic.cms.model;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author abdulmanan
 *
 */
@Data
@NoArgsConstructor
public class Users {
	private Long userId;
    private String userUsername;
    private String userPassword;
    private String userRole;
    private String userEmail;
}
