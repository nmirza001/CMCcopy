<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*,cmc.backend.entities.*,java.net.*,java.util.*"%>
<%@include file="VerifyAdmin.jsp" %>
<%
UniversityController uc = new UniversityController();
List<University> unis = uc.getAllSchools();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Manage Universities</title>
		<link rel="stylesheet" href="style.css?v=3"></link>
	</head>
	<body>
		<%@include file="TopBar.jsp" %>
		<table border="1">
			<tr>
				<th>University</th>
				<th></th>
				<th></th>
			</tr>
			<%
			for(University uni : unis) {
				String name = uni.getName();
				String encName = URLEncoder.encode(name, "UTF8");
			%>
			<tr>
				<td><a href="./ViewUniversity.jsp?name=<%= encName %>"><%= name %></a></td>
				<td><a href="./EditUniversity.jsp?name=<%= encName %>">Edit</a></td>
				<td><a href="./DeleteUniversityAction.jsp?name=<%= encName %>">Delete</a></td>
			</tr>
			<% } %>
		</table>
		<a href="AdminHome.jsp">
       	 	<button style="font-size:20px; padding:8px 8px;">Go Back</button>
   		 </a>
	</body>
</html>