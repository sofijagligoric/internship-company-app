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

String idParam = request.getParameter("id");
if (idParam == null) {
    response.sendRedirect("internships.jsp");
    return;
}

Integer id = Integer.parseInt(idParam);
InternshipDTO internship = internshipBean.getInternshipById(id); 

if (internship == null) {
    response.sendError(HttpServletResponse.SC_NOT_FOUND);
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

if ("POST".equalsIgnoreCase(request.getMethod())) {
    try {
	internship.setName(request.getParameter("name").trim());
    internship.setStartDate(LocalDate.parse(request.getParameter("startDate")));
    internship.setEndDate(LocalDate.parse(request.getParameter("endDate")));
    internship.setTechnologies(request.getParameter("technologies"));
    internship.setSkills(request.getParameter("skills"));
    internship.setAbout(request.getParameter("about"));
    internship.setRequirements(request.getParameter("requirements"));

    boolean updated = internshipBean.updateInternship(id,internship);

    if (updated) {
        session.setAttribute("flashMessage", "Internship updated successfully.");
        session.setAttribute("flashSuccess", true);
        response.sendRedirect("internships.jsp");
        return;
    } else {
        message = "Failed to update internship.";
        success = false;
    }
} catch (Exception e) {
    message = "Error: " + e.getMessage();
}
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Edit Internship</title>
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
            <h2 class="new-int-header">Edit Internship: <%=internship.getName()%></h2>
            <form class="column-div internship-form" method="POST">
                <input type="hidden" name="id" value="<%=internship.getId()%>">

                <div class="column-div create-internship-input-div">
                    <label>Internship Name:</label>
                    <input type="text" name="name" value="<%=internship.getName()%>" required />
                </div>

                <div class="column-div create-internship-input-div">
                    <label>Start Date:</label>
                    <input type="date" name="startDate" value="<%=internship.getStartDate()%>" required />
                </div>
                
                <div class="column-div create-internship-input-div">
                    <label>End Date:</label>
                    <input type="date" name="endDate" value="<%=internship.getEndDate()%>" required />
                </div>

                <div class="column-div create-internship-input-div">
                    <label>Technologies:</label>
                    <input type="text" name="technologies" value="<%=internship.getTechnologies()%>" required />
                </div>

                <div class="column-div create-internship-input-div">
                    <label>Skills:</label>
                    <input type="text" name="skills" value="<%=internship.getSkills()%>" />
                </div>

                <div class="column-div create-internship-input-div">
                    <label>About:</label>
                    <textarea name="about" rows="4"><%=internship.getAbout()%></textarea>
                </div>

                <div class="column-div create-internship-input-div">
                    <label>Requirements:</label>
                    <textarea name="requirements" rows="4" required><%=internship.getRequirements()%></textarea>
                </div>

                <input class="button-primary submit-button" type="submit" value="Save Changes" />
                <a href="internships.jsp" class="pagination-link-enabled" style="background-color: #c42a1f">Cancel</a>
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