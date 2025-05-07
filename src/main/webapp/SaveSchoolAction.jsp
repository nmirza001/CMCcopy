<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*, cmc.backend.entities.University, java.util.List, java.util.ArrayList" %>
<jsp:include page="VerifyLogin.jsp" />

<%
// Get the user from the session
User currentUser = (User) session.getAttribute("user");
if (currentUser == null) {
    response.sendRedirect("Login.jsp");
    return;
}

// Get the list of saved schools for the user
SystemController systemController = new SystemController();
List<String> savedSchoolNames = systemController.getSavedSchools(currentUser.getUsername());
List<University> savedSchools = new ArrayList<>();

// Retrieve full University objects for each saved school
if (savedSchoolNames != null && !savedSchoolNames.isEmpty()) {
    List<University> allUniversities = systemController.getAllUniversities();
    for (String name : savedSchoolNames) {
        for (University uni : allUniversities) {
            if (uni.getName().equals(name)) {
                savedSchools.add(uni);
                break;
            }
        }
    }
}

// Check for any messages (e.g., from SaveSchoolAction.jsp)
String message = (String) session.getAttribute("message");
if (message != null) {
    // Clear the message after retrieving it
    session.removeAttribute("message");
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Saved Schools</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .saved-container {
            width: 90%;
            margin: 20px auto;
            padding: 20px;
            background-color: #f0f8ff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        .message {
            margin: 10px 0;
            padding: 10px;
            border-radius: 5px;
        }
        
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .info {
            background-color: #e7f3fe;
            border-left: 6px solid #2196F3;
        }
        
        .results-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .results-table th, .results-table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        .results-table th {
            background-color: #4CAF50;
            color: white;
        }
        
        .results-table tr:hover {
            background-color: #e0e0e0;
        }
        
        .action-buttons {
            margin-top: 5px;
        }
        
        .action-button {
            background-color: #2196F3;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 5px;
            transition: background-color 0.3s;
        }
        
        .action-button:hover {
            background-color: #0b7dda;
        }
        
        .remove-button {
            background-color: #f44336;
        }
        
        .remove-button:hover {
            background-color: #d32f2f;
        }
        
        .similar-button {
            background-color: #ff9800;
        }
        
        .similar-button:hover {
            background-color: #e68a00;
        }
        
        .no-results {
            text-align: center;
            padding: 20px;
            color: #757575;
            font-style: italic;
        }
        
        .navigation-buttons {
            margin-top: 20px;
            text-align: center;
        }
        
        .nav-button {
            background-color: #673AB7;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin: 0 5px;
            transition: background-color 0.3s;
        }
        
        .nav-button:hover {
            background-color: #5e35b1;
        }
        
        h1 {
            color: #2e5cb8;
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <jsp:include page="TopBar.jsp" />
    
    <h1>My Saved Schools</h1>
    
    <div class="saved-container">
        <% if (message != null && !message.isEmpty()) { %>
            <div class="message <%= message.contains("Error") ? "error" : "success" %>">
                <%= message %>
            </div>
        <% } %>
        
        <% if (savedSchools.isEmpty()) { %>
            <div class="no-results">
                <h3>You haven't saved any schools yet.</h3>
                <p>Use the search function to find and save schools you're interested in.</p>
            </div>
        <% } else { %>
            <div class="info message">
                <p>You have saved <%= savedSchools.size() %> universities. Click on "View Details" to see full information about each university.</p>
            </div>
            
            <table class="results-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>State</th>
                        <th>Location</th>
                        <th>Control</th>
                        <th>Students</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (University uni : savedSchools) { %>
                        <tr>
                            <td><%= uni.getName() %></td>
                            <td><%= (uni.getState() != null && !uni.getState().equals("-1")) ? uni.getState() : "N/A" %></td>
                            <td><%= (uni.getLocation() != null && !uni.getLocation().equals("-1")) ? uni.getLocation() : "N/A" %></td>
                            <td><%= (uni.getControl() != null && !uni.getControl().equals("-1")) ? uni.getControl() : "N/A" %></td>
                            <td><%= (uni.getNumStudents() != -1) ? uni.getNumStudents() : "N/A" %></td>
                            <td>
                                <div class="action-buttons">
                                    <a href="ViewUniversity.jsp?name=<%= uni.getName() %>">
                                        <button type="button" class="action-button">View Details</button>
                                    </a>
                                    <a href="FindSimilarSchools.jsp?name=<%= uni.getName() %>">
                                        <button type="button" class="action-button similar-button">Find Similar</button>
                                    </a>
                                    <a href="RemoveSavedSchool.jsp?name=<%= uni.getName() %>" onclick="return confirm('Are you sure you want to remove <%= uni.getName() %> from your saved schools?');">
                                        <button type="button" class="action-button remove-button">Remove</button>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
        
        <div class="navigation-buttons">
            <a href="SearchUniversity.jsp">
                <button type="button" class="nav-button">Search More Schools</button>
            </a>
        </div>
    </div>
</body>
</html>