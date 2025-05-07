<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*" %>
<%@include file="VerifyAdmin.jsp" %>

<%
String oldVal = request.getParameter("old");

String uname = request.getParameter("uname");
String pwd = request.getParameter("pwd");
String fn = request.getParameter("fn");
String ln = request.getParameter("ln");

boolean oldValBlank = oldVal == null || oldVal.length() == 0;

User newUsr = new User(oldValBlank ? uname : oldVal, pwd, false, fn, ln);

AccountController db = new AccountController();
if(oldValBlank) {
	db.addUser(newUsr);
}
else {
	db.editUser(newUsr);
}

response.sendRedirect("./manageUsers.jsp");
%>