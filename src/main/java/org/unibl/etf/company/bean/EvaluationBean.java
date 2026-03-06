package org.unibl.etf.company.bean;

import java.io.Serializable;

import org.unibl.etf.company.dto.EvaluationDTO;
import org.unibl.etf.company.service.BackendService;

public class EvaluationBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5693346669437292306L;
	
	public EvaluationDTO getStudentEvaluationForInternship(Integer companyId, Integer studentId, Integer internshipId) {
        return BackendService.getWithoutCatch("/evaluation/company/"+ companyId+"/internship/" + internshipId +"/student/"  +studentId , EvaluationDTO.class);
    }
	
	 public boolean createEvaluation(EvaluationDTO dto) {
		 EvaluationDTO result = BackendService.post("/evaluation", dto, EvaluationDTO.class);
	        if (result != null) {
	            return true;
	        }
	        return false;
	    }

	 
	 public boolean deleteEvaluation(Integer id) {
	        boolean deleted = BackendService.delete("/evaluation/" + id);
	        return deleted;
	    }
}
