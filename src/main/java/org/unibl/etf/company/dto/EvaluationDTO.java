package org.unibl.etf.company.dto;

import java.io.Serializable;
import java.util.Objects;

public class EvaluationDTO implements Serializable{
	 /**
	 * 
	 */
	private static final long serialVersionUID = -312328351026881303L;
	private Integer id;
	    private String description;
	    private Integer studentId;
	    private Integer internshipId;
	    private Integer companyId;
		public EvaluationDTO() {
			super();
			// TODO Auto-generated constructor stub
		}
		public EvaluationDTO(Integer id, String description, Integer studentId, Integer internshipId,
				Integer companyId) {
			super();
			this.id = id;
			this.description = description;
			this.studentId = studentId;
			this.internshipId = internshipId;
			this.companyId = companyId;
		}
		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
		public Integer getStudentId() {
			return studentId;
		}
		public void setStudentId(Integer studentId) {
			this.studentId = studentId;
		}
		public Integer getInternshipId() {
			return internshipId;
		}
		public void setInternshipId(Integer internshipId) {
			this.internshipId = internshipId;
		}
		public Integer getCompanyId() {
			return companyId;
		}
		public void setCompanyId(Integer companyId) {
			this.companyId = companyId;
		}
		@Override
		public int hashCode() {
			return Objects.hash(companyId, id, internshipId, studentId);
		}
		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			EvaluationDTO other = (EvaluationDTO) obj;
			return Objects.equals(companyId, other.companyId) && Objects.equals(id, other.id)
					&& Objects.equals(internshipId, other.internshipId) && Objects.equals(studentId, other.studentId);
		}
	    
	    
}
