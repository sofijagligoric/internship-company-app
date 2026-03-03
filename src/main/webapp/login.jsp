<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="userBean" class="org.unibl.etf.company.bean.UserBean"
	scope="session" />
<jsp:useBean id="internshipBean"
	class="org.unibl.etf.company.bean.InternshipBean" scope="session" />
	<jsp:useBean id="applicationsBean"
	class="org.unibl.etf.company.bean.ApplicationsBean" scope="session" />
<%
String notification = null;
if (request.getParameter("submit") != null) {
	String user = request.getParameter("username");
	String pass = request.getParameter("password");
	int result = userBean.login(user, pass);

	if (result == 1) {
		Integer companyId = userBean.getUser().getId();
		internshipBean.loadInternships(companyId);
		applicationsBean.loadApplications(companyId);
		response.sendRedirect("internships.jsp");
		return;
	} else if(result==2){
		notification = "Account not active. Unable to proceed.";
	}
	else if(result==3){
		notification = "Wrong username or password!";
	}
	else{
		notification = "An error occurred.";
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
		<%
		if (notification != null) {
		%>
		<div class="notification error">
			<%=notification%>
		</div>
		<%
		}
		%>
		<form method="POST" action="login.jsp" class="login-form column-div">
			<h1 class="login-title">Login</h1>
			<input type="text" name="username" required placeholder="Username" />
			<input type="password" name="password" required
				placeholder="Password" /> <input class="button-primary"
				type="submit" value="Login" name="submit" />

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