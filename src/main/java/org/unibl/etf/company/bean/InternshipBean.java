package org.unibl.etf.company.bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.unibl.etf.company.dto.ApplicationDTO;
import org.unibl.etf.company.dto.InternshipDTO;
import org.unibl.etf.company.service.BackendService;

public class InternshipBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3362892697444217937L;
	private BackendService bs = BackendService.getInstance();
	private InternshipDTO internship = new InternshipDTO();
	private List<InternshipDTO> allInternships = new ArrayList<InternshipDTO>();
	public InternshipBean() {}
	
	/*
	 * public void loadInternships(Integer companyId) { this.allInternships =
	 * getCompanyInternships(companyId); }
	 */
	
	public void loadInternships(Integer companyId) {
	    this.allInternships = new ArrayList<>(getCompanyInternships(companyId));
	}

	public List<InternshipDTO> getAllInternships() {
	    return allInternships;
	}

    public List<InternshipDTO> getAvailableInternships() {
        return bs.getList("/internship/available", InternshipDTO[].class);
    }

    public List<InternshipDTO> getCompanyInternships(Integer companyId) {
        return bs.getList("/internship/company/" + companyId, InternshipDTO[].class);
    }

    public boolean createInternship() {
        InternshipDTO result = bs.post("/internship", this.internship, InternshipDTO.class);
        if (result != null) {
            this.internship = new InternshipDTO(); 
            this.allInternships.add(result);
            return true;
        }
        return false;
    }
    
    public boolean changeStatus(Integer id) {
	    try {
	    	InternshipDTO updated = bs.putWithResponse("/internship/" + id + "/status", null, InternshipDTO.class);
	        if (updated != null) {
	        	if (updated != null) {
	                allInternships.replaceAll(i -> i.getId().equals(id) ? updated : i);
	                return true;
	            }
	        }
	    } catch (Exception e) {
	        System.err.println("Error while changing status: " + e.getMessage());
	    }
	    return false;
	}

    public boolean deleteInternship(Integer id) {
        boolean deleted = bs.delete("/internship/" + id);
        if (deleted) {
            allInternships.removeIf(i -> i.getId().equals(id));
        }
        return deleted;
    }

    public boolean updateInternship(Integer id, InternshipDTO dto) {
        return bs.put("/internship/" + id, dto);
    }


    public InternshipDTO getInternship() { return internship; }
    public void setInternship(InternshipDTO internship) { this.internship = internship; }
}
