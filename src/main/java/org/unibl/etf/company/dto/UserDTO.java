package org.unibl.etf.company.dto;

import java.io.Serializable;
import java.util.Objects;

import org.unibl.etf.company.util.Role;

public class UserDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5333871588487474889L;
	private Integer id;
    private String username;
    private Role role;
	public UserDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public UserDTO(Integer id, String username, Role role) {
		super();
		this.id = id;
		this.username = username;
		this.role = role;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	@Override
	public int hashCode() {
		return Objects.hash(id, username);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserDTO other = (UserDTO) obj;
		return Objects.equals(id, other.id) && Objects.equals(username, other.username);
	}
    
    
}
