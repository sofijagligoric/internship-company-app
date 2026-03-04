package org.unibl.etf.company.dto;

import java.io.Serializable;
import java.util.Objects;

import org.unibl.etf.company.util.Role;

public class LoginResponse implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3495844756062457062L;
	private Integer userId;
    private Role role;
	public LoginResponse(Integer userId, Role role) {
		super();
		this.userId = userId;
		this.role = role;
	}
	public LoginResponse() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	@Override
	public int hashCode() {
		return Objects.hash(role, userId);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		LoginResponse other = (LoginResponse) obj;
		return role == other.role && Objects.equals(userId, other.userId);
	}

    
}
