<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.frontend.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update My Profile</title>
<link rel="stylesheet" href="style.css"></link>

</head>
<body>
<%@ include file= "TopBar.jsp"%>

<h1>Update Your Profile</h1>

<%
User u = (User)session.getAttribute("user");
if (u == null){
%>
<p class = "error"> You failed to log in.</p>
<p><a href= "Login.jsp"></a></p>
<%
return;
}
%>
}

<form method="post" action="EditMyProfile.jsp">
<div>
<label for="firstName">New First Name (Current: <%= u.getFirstName() %>):</label>
<input type="text" id="firstName" name="firstName">
</div>
<div>
<label for="lastName">New Last Name (Current: <%= u.getLastName() %>):</label>
<input type="text" id="lastName" name="lastName">
</div>
<div>
<label for="password">New Password (Leave blank to keep current):</label>
<input type="password" id="password" name="password">
</div>
<button type="submit">Update Profile</button>
</form>

</body>
</html>