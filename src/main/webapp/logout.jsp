<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="userBean" class="org.unibl.etf.company.bean.UserBean" scope="session" />
<%
    userBean.logout(); 
    session.invalidate(); 
    response.sendRedirect("login.jsp");
%>
<!-- <!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html> -->