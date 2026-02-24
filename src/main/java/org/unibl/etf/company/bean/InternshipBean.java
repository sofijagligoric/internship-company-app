package org.unibl.etf.company.bean;

import java.io.Serializable;
import java.util.List;

import org.unibl.etf.company.dto.InternshipDTO;
import org.unibl.etf.company.service.BackendService;

public class InternshipBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3362892697444217937L;
	private BackendService bs = BackendService.getInstance();
	private InternshipDTO internship = new InternshipDTO();
	public InternshipBean() {}

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
            return true;
        }
        return false;
    }

    public boolean deleteInternship(Integer id) {
        return bs.delete("/internship/" + id);
    }

    public boolean updateInternship(Integer id, InternshipDTO dto) {
        return bs.put("/internship/" + id, dto);
    }


    public InternshipDTO getInternship() { return internship; }
    public void setInternship(InternshipDTO internship) { this.internship = internship; }
}
