<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.controllers.*" %>
<%@include file="VerifyAdmin.jsp" %>
<%

// To add a user, just navigate to EditUser.jsp
// To edit a user, navigate tp EditUser.jsp?name=USERNAME


String oldVal = request.getParameter("name");
if(oldVal != null && oldVal.length() == 0) oldVal = null;

String verb = oldVal == null ? "Add" : "Edit";

String uname, pwd, fn, ln;
if(oldVal == null) {
	uname = pwd = fn = ln = "";
}
else {
	DatabaseController db = new DatabaseController();
	User oldUser = db.getUser(oldVal);
	db.close();
	if(oldUser == null) {
		response.sendRedirect("./");
		return;
	}
	uname = oldUser.getUsername();
	pwd = oldUser.getPassword();
	fn = oldUser.getFirstName();
	ln = oldUser.getLastName();
}

String disableIfEdit;
if(oldVal == null) disableIfEdit = "";
else disableIfEdit = "disabled";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title><%= verb %> User</title>
		<link rel="stylesheet" href="style.css"></link>
	</head>
	<body>
		<%@include file="TopBar.jsp" %>
		<h1><%= verb %> User</h1>
		<form method="post" action="EditUserAction.jsp">
			<% if(oldVal != null) { %>
			<input type="hidden" name="old" value="<%= oldVal %>" />
			<% } %>
			<label for="uname">Username: </label>
			<input id="uname" name="uname" placeholder="Username" type="text" value="<%= uname %>" <%= disableIfEdit %> />
			<br />
			<label for="pwd">Password: </label>
			<input id="pwd" name="pwd" placeholder="Password" type="password" value="<%= pwd %>" />
			<br />
			<label for="fn">First Name: </label>
			<input id="fn" name="fn" placeholder="First Name" type="text" value="<%= fn %>" />
			<br />
			<label for="fn">Last Name: </label>
			<input id="ln" name="ln" placeholder="Last Name" type="text" value="<%= ln %>" />
			<br />
			<input type="submit" value="Save" />
		</form>
	</body>
</html>