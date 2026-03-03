package org.unibl.etf.company.bean;

import java.io.Serializable;

import org.unibl.etf.company.dto.EvaluationDTO;
import org.unibl.etf.company.dto.InternshipDTO;
import org.unibl.etf.company.service.BackendService;

public class EvaluationBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5693346669437292306L;
	private BackendService bs = BackendService.getInstance();
	
	public EvaluationDTO getStudentEvaluationForInternship(Integer studentId, Integer internshipId) {
        return bs.get("/evaluation/student/"  +studentId +"/internship/" + internshipId, EvaluationDTO.class);
    }
	
	 public boolean createEvaluation(EvaluationDTO dto) {
		 EvaluationDTO result = bs.post("/evaluation", dto, EvaluationDTO.class);
	        if (result != null) {
	            return true;
	        }
	        return false;
	    }

	 
	 public boolean deleteEvaluation(Integer id) {
	        boolean deleted = bs.delete("/evaluation/" + id);
	        return deleted;
	    }
}
