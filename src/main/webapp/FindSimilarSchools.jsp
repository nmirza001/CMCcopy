<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*, cmc.backend.entities.University, java.util.List, java.util.ArrayList" %>
<jsp:include page="VerifyLogin.jsp" />

<%
String universityName = request.getParameter("name");
if (universityName == null || universityName.trim().isEmpty()) {
    response.sendRedirect("SearchUniversity.jsp");
    return;
}

// Get the details of the university
SystemController systemController = new SystemController();
SearchController searchController = systemController.getSearchController();
University targetUniversity = null;

// Get the actual University object
List<University> allUniversities = systemController.getAllUniversities();
for (University uni : allUniversities) {
    if (uni.getName().equals(universityName)) {
        targetUniversity = uni;
        break;
    }
}

if (targetUniversity == null) {
    // University not found
    response.sendRedirect("SearchUniversity.jsp");
    return;
}

// Find similar universities
List<University> similarUniversities = searchController.findSimilar(targetUniversity);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Similar Schools to <%= targetUniversity.getName() %></title>
    <link rel="stylesheet" href="style.css">
    <style>
        .similar-container {
            width: 90%;
            margin: 20px auto;
            padding: 20px;
            background-color: #f0f8ff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        .target-school {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #e7f3fe;
            border-left: 6px solid #2196F3;
            border-radius: 5px;
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
        
        .similarity-info {
            background-color: #fff3cd;
            color: #856404;
            padding: 10px;
            margin-top: 20px;
            border-radius: 5px;
            font-style: italic;
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
    
    <h1>Similar Schools to <%= targetUniversity.getName() %></h1>
    
    <div class="similar-container">
        <div class="target-school">
            <h3>Target University:</h3>
            <p>
                <strong>Name:</strong> <%= targetUniversity.getName() %><br>
                <strong>State:</strong> <%= (targetUniversity.getState() != null && !targetUniversity.getState().equals("-1")) ? targetUniversity.getState() : "N/A" %><br>
                <strong>Location:</strong> <%= (targetUniversity.getLocation() != null && !targetUniversity.getLocation().equals("-1")) ? targetUniversity.getLocation() : "N/A" %><br>
                <strong>Control:</strong> <%= (targetUniversity.getControl() != null && !targetUniversity.getControl().equals("-1")) ? targetUniversity.getControl() : "N/A" %><br>
                <strong>Students:</strong> <%= (targetUniversity.getNumStudents() != -1) ? targetUniversity.getNumStudents() : "N/A" %><br>
                <strong>SAT Scores:</strong> <%= (targetUniversity.getSatVerbal() != -1 && targetUniversity.getSatMath() != -1) ? 
                                               (targetUniversity.getSatVerbal() + targetUniversity.getSatMath()) : "N/A" %><br>
                <strong>Acceptance Rate:</strong> <%= (targetUniversity.getPercentAdmitted() != -1) ? targetUniversity.getPercentAdmitted() + "%" : "N/A" %><br>
                <strong>Academic Scale:</strong> <%= (targetUniversity.getScaleAcademics() != -1) ? targetUniversity.getScaleAcademics() + "/5" : "N/A" %>
            </p>
            <a href="ViewUniversity.jsp?name=<%= targetUniversity.getName() %>">
                <button type="button" class="action-button">View Full Details</button>
            </a>
        </div>
        
        <div class="similarity-info">
            Similar universities match at least 3 out of 7 criteria: State, Location, Control, Student Body Size (±25%), 
            SAT Scores (±75 points), Acceptance Rate (±15%), and Academic Scale (±1 point).
        </div>
        
        <% if (similarUniversities.isEmpty()) { %>
            <div class="no-results">
                <h3>No similar universities found.</h3>
                <p>The target university has unique characteristics based on our similarity criteria.</p>
            </div>
        <% } else { %>
            <p><strong>Found <%= similarUniversities.size() %> similar universities:</strong></p>
            
            <table class="results-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>State</th>
                        <th>Location</th>
                        <th>Control</th>
                        <th>Students</th>
                        <th>SAT Total</th>
                        <th>Acceptance</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (University uni : similarUniversities) { %>
                        <tr>
                            <td><%= uni.getName() %></td>
                            <td><%= (uni.getState() != null && !uni.getState().equals("-1")) ? uni.getState() : "N/A" %></td>
                            <td><%= (uni.getLocation() != null && !uni.getLocation().equals("-1")) ? uni.getLocation() : "N/A" %></td>
                            <td><%= (uni.getControl() != null && !uni.getControl().equals("-1")) ? uni.getControl() : "N/A" %></td>
                            <td><%= (uni.getNumStudents() != -1) ? uni.getNumStudents() : "N/A" %></td>
                            <td><%= (uni.getSatVerbal() != -1 && uni.getSatMath() != -1) ? 
                                   (uni.getSatVerbal() + uni.getSatMath()) : "N/A" %></td>
                            <td><%= (uni.getPercentAdmitted() != -1) ? uni.getPercentAdmitted() + "%" : "N/A" %></td>
                            <td>
                                <div class="action-buttons">
                                    <a href="ViewUniversity.jsp?name=<%= uni.getName() %>">
                                        <button type="button" class="action-button">View Details</button>
                                    </a>
                                    <a href="SaveSchoolAction.jsp?name=<%= uni.getName() %>">
                                        <button type="button" class="action-button save-button">Save School</button>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
        
        <div class="navigation-buttons">
            <% if (request.getHeader("Referer") != null && request.getHeader("Referer").contains("ViewUniversity.jsp")) { %>
                <a href="ViewUniversity.jsp?name=<%= targetUniversity.getName() %>">
                    <button type="button" class="nav-button">Back to University Details</button>
                </a>
            <% } else if (request.getHeader("Referer") != null && request.getHeader("Referer").contains("SearchResults.jsp")) { %>
                <a href="SearchResults.jsp">
                    <button type="button" class="nav-button">Back to Search Results</button>
                </a>
            <% } else { %>
                <a href="SearchUniversity.jsp">
                    <button type="button" class="nav-button">New Search</button>
                </a>
            <% } %>
            <a href="SavedSchools.jsp">
                <button type="button" class="nav-button">View Saved Schools</button>
            </a>
        </div>
    </div>
</body>
</html>