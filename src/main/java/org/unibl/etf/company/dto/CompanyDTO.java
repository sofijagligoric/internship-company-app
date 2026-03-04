package org.unibl.etf.company.dto;

import java.io.Serializable;
import java.util.Objects;

public class CompanyDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5378107346427747566L;
	private Integer id;
    private String name;
    private String email;
    private Boolean active;
    private String address;
    
    
    
	public CompanyDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CompanyDTO(Integer id, String name, String email, Boolean active, String address) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.active = active;
		this.address = address;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Boolean getActive() {
		return active;
	}
	public void setActive(Boolean active) {
		this.active = active;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Override
	public int hashCode() {
		return Objects.hash(id, name);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CompanyDTO other = (CompanyDTO) obj;
		return Objects.equals(id, other.id) && Objects.equals(name, other.name);
	}
    
    
}
