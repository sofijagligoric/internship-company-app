package org.unibl.etf.company.bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.unibl.etf.company.dto.InternshipDTO;
import org.unibl.etf.company.service.BackendService;

public class InternshipBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3362892697444217937L;
	private List<InternshipDTO> allInternships = new ArrayList<InternshipDTO>();

	public InternshipBean() {
	}

	public void loadInternships(Integer companyId) {
		this.allInternships = new ArrayList<>(getCompanyInternships(companyId));
	}

	public List<InternshipDTO> getAllInternships() {
		return allInternships;
	}

	public List<InternshipDTO> getAvailableInternships() {
		return BackendService.getList("/internship/available", InternshipDTO[].class);
	}

	public List<InternshipDTO> getCompanyInternships(Integer companyId) {
		return BackendService.getList("/internship/company/" + companyId, InternshipDTO[].class);
	}

	public boolean createInternship(InternshipDTO dto) {
		InternshipDTO result = BackendService.post("/internship", dto, InternshipDTO.class);
		if (result != null) {
			this.allInternships.add(result);
			return true;
		}
		return false;
	}

	public boolean changeStatus(Integer id) {
		try {
			InternshipDTO updated = BackendService.putWithResponse("/internship/" + id + "/status", null, InternshipDTO.class);

			if (updated != null) {
				allInternships.replaceAll(i -> i.getId().equals(id) ? updated : i);
				return true;
			}
		} catch (Exception e) {
			System.err.println("Error while changing status: " + e.getMessage());
		}
		return false;
	}

	public boolean deleteInternship(Integer id) {
		boolean deleted = BackendService.delete("/internship/" + id);
		if (deleted) {
			allInternships.removeIf(i -> i.getId().equals(id));
		}
		return deleted;
	}

	public InternshipDTO getInternshipById(Integer companyId, Integer internshipId) {
		return BackendService.get("/internship/" +companyId + "/"+ internshipId, InternshipDTO.class);
	}

	public boolean updateInternship(Integer id, InternshipDTO dto) {
		try {
			InternshipDTO updated = BackendService.putWithResponse("/internship/" + id, dto, InternshipDTO.class);

			if (updated != null) {
				allInternships.replaceAll(i -> i.getId().equals(id) ? updated : i);
				return true;
			}
		} catch (Exception e) {
			System.err.println("Error while changing status: " + e.getMessage());
		}
		return false;
	//	return bs.put("/internship/" + id, dto);
	}
}
