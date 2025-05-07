<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*" %>

<%
User u = (User)session.getAttribute("user");
if(u != null) {
	response.sendRedirect("./");
	return;
}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Login</title>
		<link rel="stylesheet" href="style.css"></link>
	</head>
	<body>
		<%@include file="TopBar.jsp" %>
		<h1>CMC</h1>
		<%
		String errStr = request.getParameter("error");
		if(errStr != null && errStr.length() > 0) {
		%>
		<div class="error">
			Those credentials don't match any of the users in the system.<br />
			Try again.
		</div>
		<% } %>
		<form method="post" action="LoginAction.jsp">
			<label for="uname">Username: </label>
			<input id="uname" name="uname" placeholder="Username" type="text" />
			<br />
			<label for="pwd">Password: </label>
			<input id="pwd" name="pwd" placeholder="Password" type="password" />
			<br />
			<input type="submit" value="Log In" />
		</form>
	</body>
</html>
