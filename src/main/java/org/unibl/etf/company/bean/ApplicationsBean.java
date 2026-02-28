package org.unibl.etf.company.bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.unibl.etf.company.dto.ApplicationDTO;
import org.unibl.etf.company.dto.InternshipDTO;
import org.unibl.etf.company.service.BackendService;

public class ApplicationsBean implements Serializable {

	private static final long serialVersionUID = 2347147607299787140L;
	/**
	 * 
	 */
	private BackendService bs = BackendService.getInstance();
	private ApplicationDTO application = new ApplicationDTO();
	private List<ApplicationDTO> allApplications = new ArrayList<ApplicationDTO>();
	private List<ApplicationDTO> pendingApplications = new ArrayList<ApplicationDTO>();
	
	public void loadApplications(Integer companyId) {
	    List<ApplicationDTO> rawList = getAllCompanyApplications(companyId);
	    this.allApplications = rawList.stream()
	            .filter(app -> "ACCEPTED".equalsIgnoreCase(app.getStatus()) || "DECLINED".equalsIgnoreCase(app.getStatus()))
	            .collect(Collectors.toList());
	}
	
	public void loadPendingApplications(Integer companyId) {
	    this.pendingApplications = new ArrayList<>(getCompanyApplicationsPending(companyId));
	}
	
	public boolean changeStatus(Integer id, String status) {
	    try {
	        String endpoint = "/application/" + id + "/status?status=" + status;
	        ApplicationDTO updated = bs.putWithResponse(endpoint, null, ApplicationDTO.class);

	        if (updated != null) {
	            pendingApplications.removeIf(app -> app.getId().equals(id));
	            if (allApplications == null) {
	                allApplications = new ArrayList<>();
	            }
	            allApplications.removeIf(app -> app.getId().equals(id));
	            allApplications.add(updated);
	            return true;
	        }
	    } catch (Exception e) {
	        System.err.println("Error while changing status: " + e.getMessage());
	    }
	    return false;
	}

	public List<ApplicationDTO> getAllApplications() {
	    return allApplications;
	}

	public List<ApplicationDTO> getAllCompanyApplications(Integer companyId) {
        return bs.getList("/application/company/" + companyId, ApplicationDTO[].class);
    }
	 public List<ApplicationDTO> getCompanyApplicationsPending(Integer companyId) {
	        return bs.getList("/application/company/" + companyId + "/pending", ApplicationDTO[].class);
	    }
	 
	 public List<ApplicationDTO> getAcceptedApplications() {
		    return allApplications.stream()
		            .filter(app -> "ACCEPTED".equalsIgnoreCase(app.getStatus()))
		            .collect(Collectors.toList());
		}

}
