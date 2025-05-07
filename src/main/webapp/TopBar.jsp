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
	
	<% if(session.getAttribute("user") != null) { %>
		<a href="SearchUniversity.jsp">Search Universities</a>
		<a href="SavedSchools.jsp">Saved Schools</a>
	<% } %>

	<a class="right" href="./LogOutAction.jsp">
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
