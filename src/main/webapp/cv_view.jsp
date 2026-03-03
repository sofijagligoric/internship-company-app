<%@page import="org.unibl.etf.company.dto.CvDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="userBean" class="org.unibl.etf.company.bean.UserBean"
	scope="session" />
    <jsp:useBean id="cvBean" class="org.unibl.etf.company.bean.CvBean" scope="request"/>
    
    <%! 
    public String showOrDefault(String value) {
        return (value == null || value.trim().isEmpty()) 
               ? "" 
               : value;
    }
%>
    <%
if (!(userBean.isLoggedIn())) {
	response.sendRedirect("login.jsp");
	return;
}

String sIdParam = request.getParameter("studentId");
CvDTO cv = null;

if (sIdParam != null) {
    try {
        Integer studentId = Integer.parseInt(sIdParam);
        cv = cvBean.getCv(studentId);
        if (cv == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
    } catch (NumberFormatException e) {
        response.sendRedirect("new_applications.jsp");
        return;
    }
} else {
    response.sendRedirect("new_applications.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="styles/style.css" type="text/css" rel="stylesheet">
<link href="styles/cv-view.css" type="text/css"
	rel="stylesheet">
<title>CV view</title>
</head>
<body>
<%@include file="WEB-INF/header.jsp"%>
<div class="cv-view-main">
<% if (cv != null) { %>
    <div class="row-div download-pdf-div">
    <a href="http://localhost:8080/api/cv/downloadPdf/<%= sIdParam %>" class="pagination-link-enabled"
				style="max-width: none;">
       Download PDF
    </a>
    </div>
    <div class="cv-card">
        <div class="cv-header">
            <% if (cv.getImagePath() != null && !cv.getImagePath().isEmpty()) { %>
                <div class="cv-image">
                    <img src="http://localhost:8080/uploads/cvImages/<%= cv.getImagePath() %>" alt="Profile photo" />
                </div>
            <% } %>
            
            <div class="cv-header-info">
                <h1><%= showOrDefault(cv.getFirstName()) %> <%= showOrDefault(cv.getLastName()) %></h1>
                <p><strong>Contact:</strong> <%=  showOrDefault(cv.getContact()) %></p>
                <p><em><%= showOrDefault(cv.getDescription()) %></em></p>
          
            </div>
        </div>

        <div class="cv-body">
            <div class="cv-left">
                <h3>Education</h3>
                <p><%= showOrDefault(cv.getSchool())  %></p>

                <h3>Skills</h3>
                <p><%= showOrDefault(cv.getSkills()) %></p>

                <h3>Interests</h3>
                <p><%= showOrDefault(cv.getInterests()) %></p>
            </div>

            <div class="cv-right">
                <h3>Internships</h3>
                <p><%= showOrDefault(cv.getInternships()) %></p>

                <h3>Experience</h3>
                <p><%= showOrDefault(cv.getExperience()) %></p>

                <h3>Training</h3>
                <p><%= showOrDefault(cv.getTraining()) %></p>
            </div>
        </div>
    </div>
<% } %></div>

</body>
</html>