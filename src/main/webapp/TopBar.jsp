<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*" %>
<div class="topbar">
	<a href="./">
		<%
		String acctType = (String)session.getAttribute("accttype");
		if("admin".equals(acctType)) {
		%>
		CMC - Admin
		<% } else if("student".equals(acctType)) { %>
		CMC - Student
		<% } else { %>
		CMC
		<% } %>
	</a>
	<a class="right" href="./LogOutAction.jsp">
		<%
		// Must be explicit in case other page imports cmc.backend.entities
		cmc.backend.User topBarUser = (cmc.backend.User)session.getAttribute("user");
		if(topBarUser == null) {
		%>
		Log Out
		<% } else { %>
		<%= topBarUser.getFirstName() %> - Log Out
		<% } %>
	</a>
</div>