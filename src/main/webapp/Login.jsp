<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Login</title>
		<link rel="stylesheet" href="style.css?v=2"></link>
	</head>
	<body>
		<%@include file="TopBar.jsp" %>
		<h1>CMC</h1>
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
