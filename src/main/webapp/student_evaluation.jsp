<%@page import="org.unibl.etf.company.dto.EvaluationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="org.unibl.etf.company.dto.ApplicationDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="userBean" class="org.unibl.etf.company.bean.UserBean"
	scope="session" />
<jsp:useBean id="evaluationBean"
	class="org.unibl.etf.company.bean.EvaluationBean" scope="session" />

<%
if (!userBean.isLoggedIn()) {
	response.sendRedirect("login.jsp");
	return;
}

String sIdStr = request.getParameter("studentId");
String iIdStr = request.getParameter("internshipId");

if (sIdStr == null || iIdStr == null) {
	response.sendRedirect("students.jsp");
	return;
}

Integer studentId = Integer.parseInt(sIdStr);
Integer internshipId = Integer.parseInt(iIdStr);

EvaluationDTO evaluation = null;
try {
	evaluation = evaluationBean.getStudentEvaluationForInternship(userBean.getUser().getId(), studentId, internshipId);
} catch (Exception e) {
	response.sendRedirect("404.jsp");
	return;
}

if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("action") != null) {

	String action = request.getParameter("action");

	if ("create".equals(action)) {
		String description = request.getParameter("description");

		EvaluationDTO dto = new EvaluationDTO();
		dto.setDescription(description);
		dto.setStudentId(studentId);
		dto.setInternshipId(internshipId);
		dto.setCompanyId(userBean.getUser().getId());

		if (evaluationBean.createEvaluation(dto)) {
	session.setAttribute("flashMessage", "Evaluation created.");
	session.setAttribute("flashSuccess", true);
		} else {
	session.setAttribute("flashMessage", "Could not create evaluation.");
	session.setAttribute("flashSuccess", false);
		}

		response.sendRedirect("student_evaluation.jsp?studentId=" + studentId + "&internshipId=" + internshipId);
		return;
	} else if ("delete".equals(action)) {
		if (evaluation != null && evaluationBean.deleteEvaluation(evaluation.getId())) {
	session.setAttribute("flashMessage", "Evaluation deleted.");
	session.setAttribute("flashSuccess", true);
		} else {
	session.setAttribute("flashMessage", "Could not delete evaluation.");
	session.setAttribute("flashSuccess", false);
		}

		response.sendRedirect("student_evaluation.jsp?studentId=" + studentId + "&internshipId=" + internshipId);
		return;
	}
}

String message = (String) session.getAttribute("flashMessage");
Boolean success = (Boolean) session.getAttribute("flashSuccess");

if (message != null) {
	session.removeAttribute("flashMessage");
	session.removeAttribute("flashSuccess");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Evaluation</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="styles/style.css" type="text/css" rel="stylesheet">
<link href="styles/workentry.css" type="text/css" rel="stylesheet">
</head>
<body>

	<%@include file="WEB-INF/header.jsp"%>

	<div class="workentry-main column-div">
		<a href="students.jsp" class="back-arrow"> &#8592; <span>Back</span></a>
		<%
		if (message != null) {
		%>
		<div class="notification <%=success ? "success" : "error"%>">
			<%=message%>
		</div>
		<%
		}
		%>
		<div class="we-cards-container">
			<div class="we-card" style="padding: 20px;">
				<%
				if (evaluation != null) {
				%>
				<div class="row-div delete-button-div-evaluation">
					<form method="POST" onsubmit="return confirm('Delete?');">
						<input type="hidden" name="studentId" value="<%=studentId%>">
						<input type="hidden" name="internshipId"
							value="<%=internshipId%>"> <input type="hidden"
							name="action" value="delete">
						<button type="submit" class="apply-btn"
							style="background-color: #c42a1f; margin-top: 0px;">Delete</button>
					</form>
				</div>
				<p>
					<strong>Description:</strong>
					<%=evaluation.getDescription()%></p>
				<%
				} else {
				%>
				<h3>New evaluation</h3>
				<form method="POST">
					<input type="hidden" name="studentId" value="<%=studentId%>">
					<input type="hidden" name="internshipId"
						value="<%=internshipId%>"> <input type="hidden"
						name="action" value="create">

					<textarea name="description" required
						placeholder="Write evaluation for student..." rows="4"></textarea>
					<button type="submit" class="button-primary"
						style="min-width: 70px; margin-top: 10px;">Save</button>
				</form>
				<%
				}
				%>
			</div>

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