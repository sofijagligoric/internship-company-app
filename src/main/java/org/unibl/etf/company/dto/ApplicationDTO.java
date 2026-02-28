package org.unibl.etf.company.dto;

import java.io.Serializable;
import java.time.LocalDate;

public class ApplicationDTO implements Serializable {
	 /**
	 * 
	 */
	private static final long serialVersionUID = -2381036292585239069L;
	private Integer id;
	    private String status;
	    private LocalDate date;
	    private Integer internshipId;
	    private Integer studentId;
	    private String studentName;
	    private String internshipName;
		public ApplicationDTO() {
			super();
			// TODO Auto-generated constructor stub
		}
	
		public ApplicationDTO(Integer id, String status, LocalDate date, Integer internshipId, Integer studentId,
				String studentName, String internshipName) {
			super();
			this.id = id;
			this.status = status;
			this.date = date;
			this.internshipId = internshipId;
			this.studentId = studentId;
			this.studentName = studentName;
			this.internshipName = internshipName;
		}

		public String getStudentName() {
			return studentName;
		}

		public void setStudentName(String studentName) {
			this.studentName = studentName;
		}

		public String getInternshipName() {
			return internshipName;
		}

		public void setInternshipName(String internshipName) {
			this.internshipName = internshipName;
		}

		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}
		public LocalDate getDate() {
			return date;
		}
		public void setDate(LocalDate date) {
			this.date = date;
		}
		public Integer getInternshipId() {
			return internshipId;
		}
		public void setInternshipId(Integer internshipId) {
			this.internshipId = internshipId;
		}
		public Integer getStudentId() {
			return studentId;
		}
		public void setStudentId(Integer studentId) {
			this.studentId = studentId;
		}
		
	    
}
