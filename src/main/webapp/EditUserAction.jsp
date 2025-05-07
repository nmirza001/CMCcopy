<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*" %>
<%@include file="VerifyAdmin.jsp" %>

<%
String oldVal = request.getParameter("old");

String uname = request.getParameter("uname");
String pwd = request.getParameter("pwd");
String fn = request.getParameter("fn");
String ln = request.getParameter("ln");

User newUsr = new User(uname, pwd, false, fn, ln);

AccountController db = new AccountController();
if(oldVal == null || oldVal.length() == 0) {
	db.addUser(newUsr);
}
else {
	if(!oldVal.equals(uname)) {
		response.sendRedirect("./");
		return;
	}
	
	db.editUser(newUsr);
}

response.sendRedirect("./ManageUsers.jsp");
%>