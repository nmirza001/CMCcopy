<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="TopBar.jsp" %>
<%
   // String user = (String) session.getAttribute("username");
    //if (user == null) {
        //response.sendRedirect("Login.jsp");
        //return;
    //}
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add University</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <h1>Search a University</h1>
  <form method="post" action="AddUniversityAction.jsp">
    <label for="name">Name:</label>
    <input id="name" name="name" type="text" required /><br/>

    <label for="state">State:</label>
    <input id="state" name="state" type="text" required /><br/>

    <label for="location">Location:</label>
    <input id="location" name="location" type="text" /><br/>

    <label for="control">Control:</label>
    <input id="control" name="control" type="text" /><br/>
    

    <button type="submit">Add University</button>
  </form>
</body>
</html>