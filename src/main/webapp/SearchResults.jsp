<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*, cmc.backend.entities.University, java.util.List, java.util.ArrayList, cmc.backend.SearchController" %>
<jsp:include page="VerifyLogin.jsp" />

<%
// Create controller to handle the search
SystemController systemController = new SystemController();
SearchController searchController = systemController.getSearchController();

// Get parameters from the form
String state = request.getParameter("state");
String location = request.getParameter("location");
String control = request.getParameter("control");
String numStudentsStr = request.getParameter("numStudents");

// Process parameters
int numStudents = -1; // Default value to ignore this criterion
if (numStudentsStr != null && !numStudentsStr.trim().isEmpty()) {
    try {
        numStudents = Integer.parseInt(numStudentsStr.trim());
    } catch (NumberFormatException e) {
        // If invalid input, ignore this criterion
    }
}

// Perform the search based on state and numStudents (basic search)
List<University> searchResults = searchController.search(state, numStudents);

// Filter results by additional criteria if provided
if ((location != null && !location.isEmpty()) || (control != null && !control.isEmpty())) {
    List<University> filteredResults = new ArrayList<>();
    
    for (University uni : searchResults) {
        boolean locationMatch = (location == null || location.isEmpty() || 
                                (uni.getLocation() != null && uni.getLocation().equals(location)));
        boolean controlMatch = (control == null || control.isEmpty() || 
                               (uni.getControl() != null && uni.getControl().equals(control)));
        
        if (locationMatch && controlMatch) {
            filteredResults.add(uni);
        }
    }
    
    searchResults = filteredResults;
}

// Save the results in the session for use in other pages
session.setAttribute("searchResults", searchResults);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .results-container {
            width: 90%;
            margin: 20px auto;
            padding: 20px;
            background-color: #f0f8ff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
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
        
        .save-button {
            background-color: #4CAF50;
        }
        
        .save-button:hover {
            background-color: #45a049;
        }
        
        .similar-button {
            background-color: #ff9800;
        }
        
        .similar-button:hover {
            background-color: #e68a00;
        }
        
        .search-summary {
            margin-bottom: 20px;
            padding: 10px;
            background-color: #e7f3fe;
            border-left: 6px solid #2196F3;
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
    
    <h1>Search Results</h1>
    
    <div class="results-container">
        <div class="search-summary">
            <h3>Search Criteria:</h3>
            <p>
                <strong>State:</strong> <%= (state != null && !state.isEmpty()) ? state : "Any" %><br>
                <strong>Location:</strong> <%= (location != null && !location.isEmpty()) ? location : "Any" %><br>
                <strong>Control:</strong> <%= (control != null && !control.isEmpty()) ? control : "Any" %><br>
                <strong>Number of Students:</strong> <%= (numStudents != -1) ? numStudents : "Any" %>
            </p>
        </div>
        
        <% if (searchResults.isEmpty()) { %>
            <div class="no-results">
                <h3>No universities match your search criteria.</h3>
                <p>Please try broadening your search parameters.</p>
            </div>
        <% } else { %>
            <p><strong>Found <%= searchResults.size() %> universities matching your criteria:</strong></p>
            
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
                    <% for (University uni : searchResults) { %>
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
                                    <a href="SaveSchoolAction.jsp?name=<%= uni.getName() %>">
                                        <button type="button" class="action-button save-button">Save School</button>
                                    </a>
                                    <a href="FindSimilarSchools.jsp?name=<%= uni.getName() %>">
                                        <button type="button" class="action-button similar-button">Find Similar</button>
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
                <button type="button" class="nav-button">New Search</button>
            </a>
            <a href="SavedSchools.jsp">
                <button type="button" class="nav-button">View Saved Schools</button>
            </a>
        </div>
    </div>
</body>
</html>