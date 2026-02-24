package org.unibl.etf.company.dto;

import java.time.LocalDate;
import java.util.Objects;

public class InternshipDTO {

	private Integer id;
    private String name;
    private LocalDate startDate;
    private LocalDate endDate;
    private Boolean available;
    private String about;
    private String technologies;
    private String skills;
    private Integer companyId;
    private String requirements;
    
    
    
	public InternshipDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public InternshipDTO(Integer id, String name, LocalDate startDate, LocalDate endDate, Boolean available,
			String about, String technologies, String skills, Integer companyId, String requirements) {
		super();
		this.id = id;
		this.name = name;
		this.startDate = startDate;
		this.endDate = endDate;
		this.available = available;
		this.about = about;
		this.technologies = technologies;
		this.skills = skills;
		this.companyId = companyId;
		this.requirements = requirements;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public LocalDate getStartDate() {
		return startDate;
	}
	public void setStartDate(LocalDate startDate) {
		this.startDate = startDate;
	}
	public LocalDate getEndDate() {
		return endDate;
	}
	public void setEndDate(LocalDate endDate) {
		this.endDate = endDate;
	}
	public Boolean getAvailable() {
		return available;
	}
	public void setAvailable(Boolean available) {
		this.available = available;
	}
	public String getAbout() {
		return about;
	}
	public void setAbout(String about) {
		this.about = about;
	}
	public String getTechnologies() {
		return technologies;
	}
	public void setTechnologies(String technologies) {
		this.technologies = technologies;
	}
	public String getSkills() {
		return skills;
	}
	public void setSkills(String skills) {
		this.skills = skills;
	}
	public Integer getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}
	public String getRequirements() {
		return requirements;
	}
	public void setRequirements(String requirements) {
		this.requirements = requirements;
	}
	@Override
	public int hashCode() {
		return Objects.hash(companyId, id, name);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		InternshipDTO other = (InternshipDTO) obj;
		return Objects.equals(companyId, other.companyId) && Objects.equals(id, other.id)
				&& Objects.equals(name, other.name);
	}
    
    
}
