<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*, cmc.frontend.*, cmc.backend.entities.University, java.util.List, java.util.ArrayList" %>
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
UserInteraction ui = new UserInteraction();
boolean success = ui.removeSavedSchool(universityName);

// Set message based on success/failure
String message = "";
if (success) {
    message = "School '" + universityName + "' has been successfully removed from your saved list.";
} else {
    message = "Error: Unable to remove '" + universityName + "' from your saved list. Please try again.";
}
session.setAttribute("message", message);

// Redirect back to saved schools page
response.sendRedirect("SavedSchools.jsp");
%>