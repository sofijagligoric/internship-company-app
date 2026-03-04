package org.unibl.etf.company.dto;

import java.io.Serializable;
import java.util.Objects;

public class PasswordChangeDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 751189272104898008L;
	private String oldPassword;
	private String newPassword;

	public PasswordChangeDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PasswordChangeDTO(String oldPassword, String newPassword) {
		super();
		this.oldPassword = oldPassword;
		this.newPassword = newPassword;
	}

	public String getOldPassword() {
		return oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	@Override
	public int hashCode() {
		return Objects.hash(newPassword, oldPassword);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PasswordChangeDTO other = (PasswordChangeDTO) obj;
		return Objects.equals(newPassword, other.newPassword) && Objects.equals(oldPassword, other.oldPassword);
	}
	
	
}
