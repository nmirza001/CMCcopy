<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*" %>
<div class="topbar">
	<a href="/CMCWeb">
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
	<a class="right" href="/CMCWeb/LogOutAction.jsp">
		<%
		User topBarUser = (User)session.getAttribute("user");
		if(topBarUser == null) {
		%>
		Log Out
		<% } else { %>
		<%= topBarUser.getFirstName() %> - Log Out
		<% } %>
	</a>
</div>