<%@page import="org.unibl.etf.company.dto.PasswordChangeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="userBean" class="org.unibl.etf.company.bean.UserBean"
	scope="session" />

<%
if (!(userBean.isLoggedIn())) {
	response.sendRedirect("login.jsp");
	return;
}

String message = null;
boolean success = false;
if ("POST".equalsIgnoreCase(request.getMethod())) {

	String oldPassword = request.getParameter("oldPassword");
	String newPassword = request.getParameter("newPassword");

	if (oldPassword != null && newPassword != null && !oldPassword.isEmpty() && !newPassword.isEmpty()) {
		if(oldPassword.equals(newPassword))
		{
			message = "Passwords must be different.";
		}
		else{
			PasswordChangeDTO dto = new PasswordChangeDTO(oldPassword, newPassword);
			Integer userId = userBean.getUser().getId();
			success = userBean.changePassword(userId, dto);
			if (success) {
		message = "Password successfully changed.";
			} else {
		message = "Password change failed.";
			}
		}
		
	} else {
		message = "All fields are required.";
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Change password</title>
<link href="styles/style.css" type="text/css" rel="stylesheet">
<link href="styles/login.css" type="text/css" rel="stylesheet">
</head>
<body>
	<%@include file="WEB-INF/header.jsp"%>
	<div class="main-div column-div" style="background: white;">
		<%
		if (message != null) {
		%>
		<div class="notification <%=success ? "success" : "error"%>">
			<%=message%>
		</div>
		<%
		}
		%>
		<form method="POST" action="password_change.jsp"
			class="login-form column-div"
			style="background: radial-gradient(circle at top left, #cedbed, #4b68b3);">
			<h2 class="login-title">Change password</h2>
			<input type="password" name="oldPassword" required
				placeholder="Old password" /> <input type="password"
				name="newPassword" required placeholder="New password" /> <input
				class="button-primary" type="submit" value="Change" name="submit" />

		</form>

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