package org.unibl.etf.company.dto;

import java.util.Objects;

public class StudentDTO {
	private Integer id;
    private String firstName;
    private String lastName;
    private String indeks;
    private String email;
    private Integer facultyId;
	public StudentDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public StudentDTO(Integer id, String firstName, String lastName, String indeks, String email, Integer facultyId) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.indeks = indeks;
		this.email = email;
		this.facultyId = facultyId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
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
	public String getIndeks() {
		return indeks;
	}
	public void setIndeks(String indeks) {
		this.indeks = indeks;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Integer getFacultyId() {
		return facultyId;
	}
	public void setFacultyId(Integer facultyId) {
		this.facultyId = facultyId;
	}
	@Override
	public int hashCode() {
		return Objects.hash(facultyId, id, indeks);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		StudentDTO other = (StudentDTO) obj;
		return Objects.equals(facultyId, other.facultyId) && Objects.equals(id, other.id)
				&& Objects.equals(indeks, other.indeks);
	}
    
    
}
