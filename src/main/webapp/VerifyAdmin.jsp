<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// Must be explicit in case other page imports cmc.backend.entities
cmc.backend.User u = (cmc.backend.User)session.getAttribute("user");
if(u == null || !u.isAdmin()) {
	response.sendRedirect("./");
	return;
}
%>