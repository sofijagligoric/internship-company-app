<%@page import="java.util.List"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="org.unibl.etf.company.dto.InternshipDTO"%>
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

String deleteIdParam = request.getParameter("deleteId");
String actionStatus = request.getParameter("status");

if ("refused".equals(actionStatus)) {
	message = "Not allowed to delete this internship.";
	success = false;
} else if (deleteIdParam != null && "POST".equalsIgnoreCase(request.getMethod())) {
	try {
		Integer idToDelete = Integer.parseInt(deleteIdParam);
		boolean deleted = internshipBean.deleteInternship(idToDelete);

		if (deleted) {
			session.setAttribute("flashMessage", "Internship successfully deleted.");
			session.setAttribute("flashSuccess", true);
		} else {
			session.setAttribute("flashMessage", "Cannot delete this internship.");
			session.setAttribute("flashSuccess", false);
		}
	} catch (Exception e) {
		session.setAttribute("flashMessage", "An error occurred: " + (e.getMessage() != null ? e.getMessage() : "Database constraint violation."));
		session.setAttribute("flashSuccess", false);
	}

	response.sendRedirect("internships.jsp");
	return; 
}

String updateStatusIdParam = request.getParameter("updateStatusId");

if (updateStatusIdParam != null && "POST".equalsIgnoreCase(request.getMethod())) {
	try {
		Integer idToUpdate = Integer.parseInt(updateStatusIdParam);
		boolean updated = internshipBean.changeStatus(idToUpdate);

		if (updated) {
			session.setAttribute("flashMessage", "Status successfully changed.");
			session.setAttribute("flashSuccess", true);
		} else {
			session.setAttribute("flashMessage", "Failed to update status.");
			session.setAttribute("flashSuccess", false);
		}
	} catch (Exception e) {
		session.setAttribute("flashMessage", "An error occurred during status update.");
		session.setAttribute("flashSuccess", false);
	}
	response.sendRedirect("internships.jsp");
	return;
}
List<InternshipDTO> allInternships = internshipBean.getAllInternships();
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

int totalItems = allInternships.size();
int totalPages = (int) Math.ceil((double) totalItems / pageSize);
if (currentPage < 1)
	currentPage = 1;
if (currentPage > totalPages && totalPages > 0)
	currentPage = totalPages;
int start = (currentPage - 1) * pageSize;
int end = Math.min(start + pageSize, totalItems);

List<InternshipDTO> pagedInternships = (totalItems > 0)
		? allInternships.subList(start, end)
		: new java.util.ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Internships</title>
<link href="styles/style.css" type="text/css" rel="stylesheet">
<link href="styles/internships.css" type="text/css" rel="stylesheet">
</head>
<body>
	<%@include file="WEB-INF/header.jsp"%>
	<div class="column-div main-internships-div">
		<%
		if (message != null) {
		%>
		<div class="notification <%=success ? "success" : "error"%>">
			<%=message%>
		</div>
		<%
		}
		%>
		<div class="row-div create-int-button-div">
			<a href="new_internship.jsp" class="pagination-link-enabled"
				style="max-width: none;">Create internship</a>
		</div>
		<div class="cards-container">
			<%
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy.");
			for (InternshipDTO internship : pagedInternships) {
			%>
			<div class="internship-card">
				<div class="card-header">
					<h3><%=internship.getName()%></h3>
					<span
						class="status <%=internship.getAvailable() ? "open" : "closed"%>">
						<%=internship.getAvailable() ? "Available" : "Closed"%>
					</span>
				</div>

				<div class="card-body">
					<p>
						<strong>Start:</strong>
						<%=internship.getStartDate() != null ? internship.getStartDate().format(formatter) : "/"%>
					</p>

					<p>
						<strong>End:</strong>
						<%=internship.getEndDate() != null ? internship.getEndDate().format(formatter) : "/"%>
					</p>

					<p>
						<strong>About:</strong>
						<%=internship.getAbout()%></p>
					<p>
						<strong>Technologies:</strong>
						<%=internship.getTechnologies()%></p>
					<p>
						<strong>Skills:</strong>
						<%=internship.getSkills()%></p>
					<p>
						<strong>Requirements:</strong>
						<%=internship.getRequirements()%></p>
				</div>
				<div class="card-footer">
					<form method="POST">
						<input type="hidden" name="updateStatusId"
							value="<%=internship.getId()%>">
						<button type="submit" class="apply-btn"
							style="background-color: <%=internship.getAvailable() ? "#c76528" : "#28a745"%>; min-width: 100px;">
							<%=internship.getAvailable() ? "Close" : "Open"%>
						</button>
					</form>

					<form method="POST" onsubmit="return confirmDelete(event, this)">
						<input type="hidden" name="deleteId"
							value="<%=internship.getId()%>">
						<button type="submit" class="apply-btn"
							style="background-color: #c42a1f">Delete</button>
					</form>
				</div>
			</div>
			<%
			}
			%>
		</div>


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
	</div>

	<script>
    function confirmDelete(event, form) {
        if (!confirm("Are you sure you want to delete this internship?")) {
            event.preventDefault();
            window.location.href = "internships.jsp?status=refused";
            return false;
        }
        return true; 
    }

    window.onload = function() {
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
    };
</script>
</body>
</html>