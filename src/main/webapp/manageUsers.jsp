<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*"%>
<%@include file="VerifyAdmin.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Manage User</title>
		<link rel="stylesheet" href="style.css"></link>
	</head>
	<body>
		<%AccountController ac = new AccountController(); %>
		<%@include file="TopBar.jsp" %>
		<br>
		<br>
		<br>
		<table border="1" style="border-collapse: collapse; width: 75%;">
  			<tr>
  				<th>Num</th>
    			<th>Username</th>
    			<th>Password</th>
    			<th>First Name</th>
    			<th>Last Name</th>
   				<th>Type</th>
    			<th>Is Active</th>
  			</tr>
  				<%int count = 1;%>
  				<%for(User up : ac.getAllUsers()){ %>
  					<tr>
  						<td><%=count %></td>
  						<td><%=up.getUsername()%></td>
  						<td><%=up.getPassword()%></td>
  						<td><%=up.getFirstName()%></td>
  						<td><%=up.getLastName()%></td>
  						<%if(up.isAdmin()){ %>
  							<td>A</td>
  						<%} %>
  						<%if(!up.isAdmin()){ %>
  							<td>U</td>
  						<%} %>
  						<%if(up.isActivated()){ %>
  							<td>Yes</td>
  						<%} %>
  						<%if(!up.isActivated()){ %>
  							<td>No</td>
  						<%} %>
  						<%count++; %>
  						<td><a href="EditUser.jsp?name=<%= up.getUsername() %>">
  							<button type="button">Edit</button>
						</a></td>
  				<%} %>		
  		</table>	
  		<a href="EditUser.jsp"><button style="font-size:20px;">Add User</button></a>
  		<a href="AdminHome.jsp"><button style="font-size:20px;">Go Back</button></a>
	</body>
</html>