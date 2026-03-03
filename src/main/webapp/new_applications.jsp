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
String appIdParam = request.getParameter("appId");
String newStatusParam = request.getParameter("newStatus");
String message = null;
boolean success = false;

 if (session.getAttribute("flashMessage") != null) {
    message = (String) session.getAttribute("flashMessage");
    success = (Boolean) session.getAttribute("flashSuccess");
    
    session.removeAttribute("flashMessage");
    session.removeAttribute("flashSuccess");
}

if (appIdParam != null && newStatusParam != null && "POST".equalsIgnoreCase(request.getMethod())) {
	try {
		Integer appId = Integer.parseInt(appIdParam);
		applicationsBean.changeStatus(appId, newStatusParam);
		session.setAttribute("flashMessage", "Status changed to: " + newStatusParam + ".");
		session.setAttribute("flashSuccess", true);
	} catch (Exception e) {
		session.setAttribute("flashMessage", "Cannot change status to " + newStatusParam + ".");
		session.setAttribute("flashSuccess", false);
	}
	  response.sendRedirect("new_applications.jsp");
	    return;
}

List<ApplicationDTO> pendingAps = applicationsBean.getCompanyApplicationsPending(userBean.getUser().getId());

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
<title>New applications</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="styles/style.css" type="text/css" rel="stylesheet">
<link href="styles/new-applications.css" type="text/css"
	rel="stylesheet">
</head>
<body>
	<%@include file="WEB-INF/header.jsp"%>

	<div class="main-new-app-div">
		<%
		if (message != null) {
		%>
		<div class="notification <%=success ? "success" : "error"%>">
			<%=message%>
		</div>
		<%
		}
		%>
		<div class="table-container">
			<table>

				<thead>
					<tr>
						<th>Date</th>
						<th>Internship</th>
						<th>Student</th>
						<th>Actions</th>
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
						<td>
							<div class="action-buttons">
							<a href="cv_view.jsp?studentId=<%=app.getStudentId()%>"
									class="pagination-link-enabled" style="max-width: none;">
									CV </a> 
								<%-- <form action="cv_view.jsp" method="GET"
								style="display: inline;">
								<input type="hidden" name="studentId"
									value="<%=app.getStudentId()%>"> 
								<button type="submit" class="button-primary" style="padding: 10px; border-radius: 20px">CV</button>
						     	</form>  --%>
								<form method="POST" style="display: inline;"
									onsubmit="return confirm('Are you sure you want to accept this application?');">
									<input type="hidden" name="appId" value="<%=app.getId()%>">
									<input type="hidden" name="newStatus" value="ACCEPTED">
									<button type="submit" class="apply-btn"
										style="background-color: #28a745;">✔ Accept</button>
								</form>

								<form method="POST" style="display: inline;"
									onsubmit="return confirm('Are you sure you want to decline this application?');">
									<input type="hidden" name="appId" value="<%=app.getId()%>">
									<input type="hidden" name="newStatus" value="DECLINED">
									<button type="submit" class="apply-btn"
										style="background-color: #c42a1f">✖ Decline</button>
								</form>

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