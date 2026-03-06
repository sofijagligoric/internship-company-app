<%@page import="org.unibl.etf.company.dto.WorkentryDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="org.unibl.etf.company.dto.ApplicationDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="userBean" class="org.unibl.etf.company.bean.UserBean"
	scope="session" />
<jsp:useBean id="workentryBean"
	class="org.unibl.etf.company.bean.WorkentryBean" scope="session" />

<%
if (!(userBean.isLoggedIn())) {
	response.sendRedirect("login.jsp");
	return;
}

String sIdParam = request.getParameter("studentId");
String iIdParam = request.getParameter("internshipId");

List<WorkentryDTO> workEntries = null;

if (sIdParam != null && iIdParam != null) {
	try {
		Integer studentId = Integer.parseInt(sIdParam);
		Integer internshipId = Integer.parseInt(iIdParam);
		workEntries = workentryBean.getAllStudentWorkentryForInternship(userBean.getUser().getId(), studentId, internshipId);
	} catch (NumberFormatException e) {
		response.sendRedirect("students.jsp");
		return;
	}
} else {
	response.sendRedirect("students.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Work entry</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="styles/style.css" type="text/css" rel="stylesheet">
<link href="styles/workentry.css" type="text/css" rel="stylesheet">
</head>
<body>

	<%@include file="WEB-INF/header.jsp"%>

	<div class="workentry-main column-div">

		<%
		if (workEntries == null || workEntries.isEmpty()) {
		%>
		<p>No entries found for this internship.</p>
		<%
		} else {
		%>
		<div class="we-cards-container">
			<%
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy.");
			for (WorkentryDTO entry : workEntries) {
			%>
			<div class="we-card">
				<p>
					<strong>Week start:</strong>
					<%=entry.getWeekStart() != null ? entry.getWeekStart().format(formatter) : "/"%></p>
				<p>
					<%=entry.getActivity()%></p>
			</div>
			<%
			}
			%>
		</div>
		<%
		}
		%>
	</div>
</body>
</html>