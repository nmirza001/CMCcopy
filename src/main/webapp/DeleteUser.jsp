<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*"%>
<%@include file="VerifyAdmin.jsp" %>
<%
	String username = request.getParameter("name");
	AccountController myAC = new AccountController();
	User user = null;

	for (User x : myAC.getAllUsers()) {
    	if (x.getUsername().equals(username)) {
        	user = x;
        	break;
    	}
    }
    if(user != null && username.length() > 0){
    	myAC.removeUser(user);
    }
    
    response.sendRedirect("manageUsers.jsp");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>