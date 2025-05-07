<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.frontend.*, java.util.ArrayList, java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Favorite Schools</title>

<link rel="stylesheet" href="style.css">
</head>
<body>
<%@ include file="TopBar.jsp" %>

<h1>My Favorite Schools</h1>

<%
User u = (User) session.getAttribute("user");
if (u == null) {
%>
<p class="error">You failed to log in.</p>
<p><a href="Login.jsp">Login</a></p>
<%
return;
}

UserInteraction itr = new UserInteraction();
List<String> favoriteSchoolNames = itr.getSavedSchools();

if (favoriteSchoolNames != null && !favoriteSchoolNames.isEmpty()) {
%>

<table>
<thead>
<tr>
<th>School Name</th>
</tr>
</thead>
<tbody>

<%
for (String schoolName : favoriteSchoolNames) {
%>
<tr>
<td><%= schoolName %></td>
</tr>
<%
}
%>

</tbody>
</table>

<%
} 
else {
%>
<p>No favorite schools in list</p>
<%
}
%>

</body>
</html>