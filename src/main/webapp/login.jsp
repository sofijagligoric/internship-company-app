<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<jsp:useBean id="userBean" class="org.unibl.etf.company.bean.UserBean" scope="session" />
<%
String notification = "";
if (request.getParameter("submit") != null) {
	String user = request.getParameter("username");
	String pass = request.getParameter("password");

	if (userBean.login(user, pass)) {
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
</head>
<body>
	<div class="login-container">
		<form method="POST" action="login.jsp">
			Username<br /> <input type="text" name="username" required /><br />
			Password <br /> <input type="password" name="password" required /><br />
			<input type="submit" value="Prijavi me" name="submit" /><br />
		</form>

		<%
		if (!notification.isEmpty()) {
		%>
		<h3 style="color: red;"><%=notification%></h3>
		<%
		}
		%>
	</div>
</body>
</html>