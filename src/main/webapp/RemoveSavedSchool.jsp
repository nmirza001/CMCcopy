<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*, cmc.backend.entities.University, java.util.List, java.util.ArrayList" %>
<jsp:include page="VerifyLogin.jsp" />

<%
// Get the university name parameter
String universityName = request.getParameter("name");
if (universityName == null || universityName.trim().isEmpty()) {
    response.sendRedirect("SavedSchools.jsp");
    return;
}

// Get the user from the session
User currentUser = (User) session.getAttribute("user");
if (currentUser == null) {
    response.sendRedirect("Login.jsp");
    return;
}

// Remove the school from the user's saved list
// Note: The actual SystemController doesn't have removeSchool, so this would need to be implemented
// For now, we'll use a message indicating this feature is not yet implemented
String message = "The remove functionality is currently being implemented. Please check back later.";
session.setAttribute("message", message);

// Redirect back to saved schools page
response.sendRedirect("SavedSchools.jsp");
%>