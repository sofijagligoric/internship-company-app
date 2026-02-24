package org.unibl.etf.company.bean;

import java.io.Serializable;

import org.unibl.etf.company.dto.LoginRequest;
import org.unibl.etf.company.dto.LoginResponse;
import org.unibl.etf.company.dto.UserDTO;
import org.unibl.etf.company.service.BackendService;
import org.unibl.etf.company.util.Role;

public class UserBean implements Serializable{

	private static final long serialVersionUID = -5764553752693177953L;
	private UserDTO user = new UserDTO();
	private boolean isLoggedIn = false;
	private BackendService bs = BackendService.getInstance();
	
	public UserDTO getUser() {
		return user;
	}
	public boolean isLoggedIn() {
		return isLoggedIn;
	}
	
	public boolean login(String username, String password) {
	    try {
	        LoginResponse res = bs.post("/auth/login", new LoginRequest(username, password), LoginResponse.class);
	        if (res != null && res.getRole()!=null && res.getRole()==Role.COMPANY) {
	            this.user = new UserDTO(res.getUserId(), username, res.getRole());
	            this.isLoggedIn = true;
	            return true;
	        }
	    } catch (Exception e) {
	        System.err.println("Login failed: " + e.getMessage());
	    }
	    return false;
	}
}
