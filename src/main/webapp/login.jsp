<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="userBean" class="org.unibl.etf.company.bean.UserBean"
	scope="session" />
<jsp:useBean id="internshipBean"
	class="org.unibl.etf.company.bean.InternshipBean" scope="session" />
	<jsp:useBean id="applicationsBean"
	class="org.unibl.etf.company.bean.ApplicationsBean" scope="session" />
<%
String notification = "";
if (request.getParameter("submit") != null) {
	String user = request.getParameter("username");
	String pass = request.getParameter("password");

	if (userBean.login(user, pass)) {
		Integer companyId = userBean.getUser().getId();
		internshipBean.loadInternships(companyId);
		applicationsBean.loadApplications(companyId);
		response.sendRedirect("internships.jsp");
		return;
	} else {
		notification = "Wrong username or password!";
	}
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<link href="styles/style.css" type="text/css" rel="stylesheet">
<link href="styles/login.css" type="text/css" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
	<div class="main-div column-div">
		<form method="POST" action="login.jsp" class="login-form column-div">
			<h1 class="login-title">Login</h1>
			<input type="text" name="username" required placeholder="Username" />
			<input type="password" name="password" required
				placeholder="Password" /> <input class="button-primary"
				type="submit" value="Login" name="submit" />

		</form>
		<% if (!notification.isEmpty()) { %>
		<div class="notification-div">
			<h3><%= notification %></h3>
		</div>
		<% } %>
	</div>

</body>
</html>