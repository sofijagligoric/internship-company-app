<%@page import="java.util.ArrayList"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="org.unibl.etf.company.dto.ApplicationDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="userBean" class="org.unibl.etf.company.bean.UserBean"
	scope="session" />
<jsp:useBean id="applicationsBean"
	class="org.unibl.etf.company.bean.ApplicationsBean" scope="session" />

<%
if (!(userBean.isLoggedIn())) {
	response.sendRedirect("login.jsp");
	return;
}

List<ApplicationDTO> pendingAps = applicationsBean.getAllApplications();

int pageSize = 10;
int currentPage = 1;
String pageParam = request.getParameter("page");

if (pageParam != null && !pageParam.isEmpty()) {
	try {
		currentPage = Integer.parseInt(pageParam);
	} catch (NumberFormatException e) {
		currentPage = 1;
	}
}
int totalItems = pendingAps.size();
int totalPages = (int) Math.ceil((double) totalItems / pageSize);
if (currentPage < 1)
	currentPage = 1;
if (currentPage > totalPages && totalPages > 0)
	currentPage = totalPages;
int start = (currentPage - 1) * pageSize;
int end = Math.min(start + pageSize, totalItems);

List<ApplicationDTO> pagedApps = new ArrayList<>();
if (totalItems > 0) {
	pagedApps = pendingAps.subList(start, end);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Archived applications</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="styles/style.css" type="text/css" rel="stylesheet">
<link href="styles/new-applications.css" type="text/css"
	rel="stylesheet">
</head>
<body>
	<%@include file="WEB-INF/header.jsp"%>
	<div class="main-new-app-div">
    <div class="table-container">
		<table>

			<thead>
				<tr>
					<th>Date</th>
					<th>Internship</th>
					<th>Student</th>
					<th>Status</th>
					<th>CV</th>
				</tr>
			</thead>

			<tbody>
				<%
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy.");
				for (ApplicationDTO app : pagedApps) {
				%>
				<tr>
					<td><%=app.getDate() != null ? app.getDate().format(formatter) : "/"%></td>
					<td><%=app.getInternshipName()%></td>
					<td><%=app.getStudentName()%></td>
					<td><%=app.getStatus().toLowerCase()%></td>
					 <td>
					<div class="action-buttons">
						<a href="cv_view.jsp?studentId=<%=app.getStudentId()%>"
									class="pagination-link-enabled" style="max-width: none;">
									View </a> 
						</div>
					</td> 
					
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	
	<%
			if (!pagedApps.isEmpty()) {
			%>
		<div class="pagination int-pag">
			<%
			if (currentPage > 1) {
			%>
			<a href="?page=<%=currentPage - 1%>" class="pagination-link-enabled">Previous</a>
			<%
			} else {
			%>
			<span class="pagination-link-disabled">Previous</span>
			<%
			}
			%>

			<span>Page <strong><%=currentPage%></strong> of <%=totalPages%></span>

			<%
			if (currentPage < totalPages) {
			%>
			<a href="?page=<%=currentPage + 1%>" class="pagination-link-enabled">Next</a>
			<%
			} else {
			%>
			<span class="pagination-link-disabled">Next</span>
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