<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String user = (String)session.getAttribute("username");
if(user == null) response.sendRedirect("./Login.jsp");
%>    
