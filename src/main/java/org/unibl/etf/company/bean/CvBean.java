package org.unibl.etf.company.bean;

import java.io.Serializable;

import org.unibl.etf.company.dto.CvDTO;
import org.unibl.etf.company.service.BackendService;

public class CvBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2099234737401664733L;
	
	public CvDTO getCv(Integer studentId) {
        return BackendService.get("/cv/student/"  +studentId, CvDTO.class);
    }
	

}
