<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*"%>
<%
User u = (User)session.getAttribute("user");
if(u == null || u.isAdmin()) {
	response.sendRedirect("./");
	return;
}
%>