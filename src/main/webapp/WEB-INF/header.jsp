<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="styles/style.css" type="text/css" rel="stylesheet">
<link href="styles/header-footer.css" type="text/css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
	<div class="header-div row-div">
		<input type="checkbox" id="check"> <label for="check"
			class="checkbtn"> &#9776; </label>
		<ul class="menu">
  
  <li><a href="internships.jsp">Internships</a></li>

			<li class="dropdown"><input type="checkbox"
				id="applications-toggle"> <label for="applications-toggle">Applications</label>
				<ul class="dropdown-menu">
					<li><a href="new_applications.jsp">New</a></li>
					<li><a href="archived.jsp">Archived</a></li>
				</ul></li>

			<li class="dropdown"><input type="checkbox" id="students-toggle">
				<label for="students-toggle">Students</label>
				<ul class="dropdown-menu">
					<li><a href="evaluations.jsp">Evaluations</a></li>
					<li><a href="students.jsp">Students</a></li>
				</ul></li>

			<li class="dropdown"><input type="checkbox" id="profile-toggle">
				<label for="profile-toggle">Profile</label>
				<ul class="dropdown-menu">
					<li><a href="password_change.jsp">Password</a></li>
					<li><a href="logout.jsp" style="color: red;">Log out</a></li>
				</ul></li>

		</ul>
	</div>
</body>
</html>