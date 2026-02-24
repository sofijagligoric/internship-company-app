<%@page import="org.unibl.etf.company.dto.InternshipDTO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<jsp:useBean id="userBean" class="org.unibl.etf.company.bean.UserBean"
	scope="session" />
<jsp:useBean id="internshipBean"
	class="org.unibl.etf.company.bean.InternshipBean" scope="session" />

<%
	if(!(userBean.isLoggedIn())) response.sendRedirect("login.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Internships</title>
<link href="styles/style.css" type="text/css" rel="stylesheet">
</head>
<body>

	<table>

		<thead>
			<tr>
				<th>Name</th>
				<th>Start date</th>
				<th>End date</th>
				<th>Available</th>
				<th>About</th>
				<th>Technologies</th>
				<th>Skills</th>
				<th>Requirements</th>
			</tr>
		</thead>

		<tbody>
			<% for(InternshipDTO internship : internshipBean.getCompanyInternships(userBean.getUser().getId()))
	 { %>
			<tr>
				<td><%= internship.getName() %></td>
				<td><%= internship.getStartDate() %></td>
				<td><%= internship.getEndDate() %></td>
				<td><%= internship.getAvailable() %></td>
				<td><%= internship.getAbout() %></td>
				<td><%= internship.getTechnologies() %></td>
				<td><%= internship.getSkills() %></td>
				<td><%= internship.getRequirements() %></td>
			</tr>
			<% } %>
		</tbody>
	</table>


</body>
</html>