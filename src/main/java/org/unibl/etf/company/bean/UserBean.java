package org.unibl.etf.company.bean;

import java.io.Serializable;

import org.unibl.etf.company.dto.CompanyDTO;
import org.unibl.etf.company.dto.EvaluationDTO;
import org.unibl.etf.company.dto.LoginRequest;
import org.unibl.etf.company.dto.LoginResponse;
import org.unibl.etf.company.dto.PasswordChangeDTO;
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
	
	public boolean changePassword(Integer id, PasswordChangeDTO dto) {
	    return bs.put("/users/" + id + "/password", dto); 
	}
	
	public int login(String username, String password) {
	    try {
	        LoginResponse res = bs.post("/auth/login", new LoginRequest(username, password), LoginResponse.class);
	        if (res != null && res.getRole()!=null && res.getRole()==Role.COMPANY) {
	        	CompanyDTO comp = bs.get("/company/"  +res.getUserId(), CompanyDTO.class);
	        	if(comp != null && comp.getActive())
	        	{
	        		this.user = new UserDTO(res.getUserId(), username, res.getRole());
		            this.isLoggedIn = true;
		            return 1;
	        	}
	        	else {
	        		return 2;
	        	}
	        }
	        else
	        {
	        	return 3;
	        }
	    } catch (Exception e) {
	        System.err.println("Login failed: " + e.getMessage());
	    }
	    return 4;
	}
	
	public void logout() {
	    this.user = new UserDTO();
	    this.isLoggedIn = false;
	}
}
