package org.unibl.etf.company.bean;

import java.io.Serializable;
import java.util.List;

import org.unibl.etf.company.dto.WorkentryDTO;
import org.unibl.etf.company.service.BackendService;

public class WorkentryBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8091136527447925226L;
	
	public List<WorkentryDTO> getAllStudentWorkentryForInternship(Integer studentId, Integer internshipId) {
        return BackendService.getList("/workentry/student/"  +studentId +"/internship/" + internshipId, WorkentryDTO[].class);
    }

}
