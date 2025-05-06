<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*" %>

<%

String uname = request.getParameter("uname");
String pwd = request.getParameter("pwd");

SystemController sc = new SystemController();
User u = sc.login(uname, pwd);
if(u != null) {
	session.setAttribute("user", u);
	session.setAttribute("accttype", u.isAdmin() ? "admin" : "student");
	
	response.sendRedirect("/CMCWeb");
}
else {
	response.sendRedirect("./Login.jsp?error=1");
	return;
}

%>