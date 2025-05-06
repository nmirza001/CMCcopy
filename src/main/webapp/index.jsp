<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*" %>

<%
User user = (User)session.getAttribute("user");
String type = (String)session.getAttribute("accttype");
if(user == null) response.sendRedirect("./Login.jsp");
else if("admin".equals(type)) response.sendRedirect("./AdminHome.jsp");
else response.sendRedirect("./StudentHome.jsp");
%>    
