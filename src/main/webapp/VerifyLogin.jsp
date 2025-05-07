<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*"%>
<%
User user = (User)session.getAttribute("user");
if(user == null) {
    response.sendRedirect("Login.jsp");
    return;
}
%>