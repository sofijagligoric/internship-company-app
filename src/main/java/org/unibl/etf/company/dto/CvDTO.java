package org.unibl.etf.company.dto;

import java.io.Serializable;
import java.util.Objects;

public class CvDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3168588842488468304L;
	private Integer id;
    private String description;
    private String imagePath;
    private String school;
    private String internships;
    private String experience;
    private String contact;
    private String interests;
    private String skills;
    private String firstName;
    private String lastName;
    private String training;
    private Integer studentId;
	public CvDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CvDTO(Integer id, String description, String imagePath, String school, String internships, String experience,
			String contact, String interests, String skills, String firstName, String lastName, String training,
			Integer studentId) {
		super();
		this.id = id;
		this.description = description;
		this.imagePath = imagePath;
		this.school = school;
		this.internships = internships;
		this.experience = experience;
		this.contact = contact;
		this.interests = interests;
		this.skills = skills;
		this.firstName = firstName;
		this.lastName = lastName;
		this.training = training;
		this.studentId = studentId;
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
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public String getInternships() {
		return internships;
	}
	public void setInternships(String internships) {
		this.internships = internships;
	}
	public String getExperience() {
		return experience;
	}
	public void setExperience(String experience) {
		this.experience = experience;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getInterests() {
		return interests;
	}
	public void setInterests(String interests) {
		this.interests = interests;
	}
	public String getSkills() {
		return skills;
	}
	public void setSkills(String skills) {
		this.skills = skills;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getTraining() {
		return training;
	}
	public void setTraining(String training) {
		this.training = training;
	}
	public Integer getStudentId() {
		return studentId;
	}
	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}
	@Override
	public int hashCode() {
		return Objects.hash(firstName, id, lastName);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CvDTO other = (CvDTO) obj;
		return Objects.equals(firstName, other.firstName) && Objects.equals(id, other.id)
				&& Objects.equals(lastName, other.lastName);
	}
    
    
}
