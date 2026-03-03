<%@page import="org.unibl.etf.company.dto.InternshipDTO"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="userBean" class="org.unibl.etf.company.bean.UserBean"
	scope="session" />
<jsp:useBean id="internshipBean"
	class="org.unibl.etf.company.bean.InternshipBean" scope="session" />

<%
if (!(userBean.isLoggedIn())) {
	response.sendRedirect("login.jsp");
	return;
}

String message = null;
boolean success = false;

if (session.getAttribute("flashMessage") != null) {
    message = (String) session.getAttribute("flashMessage");
    success = (Boolean) session.getAttribute("flashSuccess");
    
    session.removeAttribute("flashMessage");
    session.removeAttribute("flashSuccess");
}

if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("submit") != null) {
	try {
		String name = request.getParameter("name");
		String startDateStr = request.getParameter("startDate");
		String endDateStr = request.getParameter("endDate");
		String about = request.getParameter("about");
		String technologies = request.getParameter("technologies");
		String skills = request.getParameter("skills");
		String requirements = request.getParameter("requirements");

		InternshipDTO dto = new InternshipDTO();
		dto.setName(name.trim());
		dto.setAbout(about);
		dto.setTechnologies(technologies);
		dto.setSkills(skills);
		dto.setRequirements(requirements);
		dto.setAvailable(true); 
		dto.setCompanyId(userBean.getUser().getId());

		if (startDateStr != null && !startDateStr.isEmpty()) {
	dto.setStartDate(LocalDate.parse(startDateStr));
		}
		if (endDateStr != null && !endDateStr.isEmpty()) {
	dto.setEndDate(LocalDate.parse(endDateStr));
		}

		boolean created = internshipBean.createInternship(dto);

		if (created) {
	session.setAttribute("flashMessage", "Internship successfully created.");
	session.setAttribute("flashSuccess", true);
		} else {
	session.setAttribute("flashMessage", "Failed to create internship.");
	session.setAttribute("flashSuccess", false);
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	response.sendRedirect("new_internship.jsp");
	return; 
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Create Internship</title>
<link href="styles/style.css" type="text/css" rel="stylesheet">
<link href="styles/new-internship.css" type="text/css" rel="stylesheet">
</head>
<body>
	<%@include file="WEB-INF/header.jsp"%>
	<div class="column-div main-new-internship-div">
		<%
		if (message != null) {
		%>
		<div class="notification <%=success ? "success" : "error"%>">
			<%=message%>
		</div>
		<%
		}
		%>

		<div class="new-internship-card">
			<h2 class="new-int-header">Add New Internship</h2>
			<form class="column-div internship-form" method="POST"
				action="new_internship.jsp">

				<div class="column-div create-internship-input-div">
					<label for="name"> Internship Name:</label> <input type="text"
						name="name" id="name" required />
				</div>

				<div class="column-div create-internship-input-div">
					<label for="startDate">Start Date:</label> <input type="date"
						name="startDate" id="startDate" required />
				</div>
				<div class="column-div create-internship-input-div">
					<label for="endDate">End Date:</label> <input type="date"
						name="endDate" id="endDate" required />
				</div>

				<div class="column-div create-internship-input-div">
					<label for="technologies">Technologies (comma separated):</label> <input
						type="text" name="technologies" id="technologies"
						placeholder="e.g. Java, Spring, React" required />
				</div>

				<div class="column-div create-internship-input-div">
					<label for="skills">Skills:</label> <input type="text"
						name="skills" id="skills" />
				</div>

				<div class="column-div create-internship-input-div">
					<label for="about">About Internship:</label>
					<textarea name="about" id="about" rows="4"></textarea>
				</div>

				<div class="column-div create-internship-input-div">
					<label for="requirements">Requirements:</label>
					<textarea name="requirements" id="requirements" rows="4" required></textarea>
				</div>

				<input class="button-primary submit-button" type="submit"
					value="Create Internship" name="submit" />
			</form>
		</div>
	</div>
	<script>
    const notification = document.querySelector('.notification');
    if (notification) {
        setTimeout(() => {
            notification.style.transition = "opacity 0.5s ease";
            notification.style.opacity = "0";
            setTimeout(() => {
                notification.style.display = "none";
            }, 500);
        }, 5000);
    }
</script>
</body>
</html>