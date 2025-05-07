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
String universityDetails = systemController.viewSchool(universityName);
University university = null;

// Get the actual University object for use with similar schools
List<University> allUniversities = systemController.getAllUniversities();
for (University uni : allUniversities) {
    if (uni.getName().equals(universityName)) {
        university = uni;
        break;
    }
}

if (university == null) {
    // University not found
    response.sendRedirect("SearchUniversity.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= university.getName() %> - University Details</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .university-container {
            width: 80%;
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #f0f8ff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        .university-name {
            color: #2e5cb8;
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
        }
        
        .university-image {
            text-align: center;
            margin-bottom: 20px;
        }
        
        .university-image img {
            max-width: 100%;
            max-height: 300px;
            border-radius: 5px;
        }
        
        .university-details {
            margin-top: 20px;
            padding: 15px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .detail-section {
            margin-bottom: 20px;
        }
        
        .detail-section h3 {
            color: #2e5cb8;
            border-bottom: 1px solid #ddd;
            padding-bottom: 5px;
            margin-bottom: 10px;
        }
        
        .detail-row {
            display: flex;
            margin-bottom: 10px;
        }
        
        .detail-label {
            font-weight: bold;
            width: 35%;
            padding-right: 10px;
        }
        
        .detail-value {
            width: 65%;
        }
        
        .action-buttons {
            margin-top: 20px;
            text-align: center;
        }
        
        .action-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin: 0 5px 10px 5px;
            transition: background-color 0.3s;
        }
        
        .action-button:hover {
            background-color: #45a049;
        }
        
        .similar-button {
            background-color: #ff9800;
        }
        
        .similar-button:hover {
            background-color: #e68a00;
        }
        
        .back-button {
            background-color: #2196F3;
        }
        
        .back-button:hover {
            background-color: #0b7dda;
        }
        
        .external-link {
            background-color: #673AB7;
        }
        
        .external-link:hover {
            background-color: #5e35b1;
        }
    </style>
</head>
<body>
    <jsp:include page="TopBar.jsp" />
    
    <div class="university-container">
        <h1 class="university-name"><%= university.getName() %></h1>
        
        <% if (university.getImageUrl() != null && !university.getImageUrl().isEmpty()) { %>
            <div class="university-image">
                <img src="<%= university.getImageUrl() %>" alt="<%= university.getName() %>" />
            </div>
        <% } %>
        
        <div class="university-details">
            <div class="detail-section">
                <h3>Location Information</h3>
                <div class="detail-row">
                    <div class="detail-label">State:</div>
                    <div class="detail-value"><%= (university.getState() != null && !university.getState().equals("-1")) ? university.getState() : "Not specified" %></div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Location:</div>
                    <div class="detail-value"><%= (university.getLocation() != null && !university.getLocation().equals("-1")) ? university.getLocation() : "Not specified" %></div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Control:</div>
                    <div class="detail-value"><%= (university.getControl() != null && !university.getControl().equals("-1")) ? university.getControl() : "Not specified" %></div>
                </div>
            </div>
            
            <div class="detail-section">
                <h3>Student Body</h3>
                <div class="detail-row">
                    <div class="detail-label">Number of Students:</div>
                    <div class="detail-value"><%= (university.getNumStudents() != -1) ? university.getNumStudents() : "Not specified" %></div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Percent Female:</div>
                    <div class="detail-value"><%= (university.getPercentFemale() != -1) ? university.getPercentFemale() + "%" : "Not specified" %></div>
                </div>
            </div>
            
            <div class="detail-section">
                <h3>Academics</h3>
                <div class="detail-row">
                    <div class="detail-label">SAT Verbal:</div>
                    <div class="detail-value"><%= (university.getSatVerbal() != -1) ? university.getSatVerbal() : "Not specified" %></div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">SAT Math:</div>
                    <div class="detail-value"><%= (university.getSatMath() != -1) ? university.getSatMath() : "Not specified" %></div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Expenses:</div>
                    <div class="detail-value"><%= (university.getExpenses() != -1) ? "$" + String.format("%,.2f", university.getExpenses()) : "Not specified" %></div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Percent Financial Aid:</div>
                    <div class="detail-value"><%= (university.getPercentFinancialAid() != -1) ? university.getPercentFinancialAid() + "%" : "Not specified" %></div>
                </div>
            </div>
            
            <div class="detail-section">
                <h3>Admissions</h3>
                <div class="detail-row">
                    <div class="detail-label">Number of Applicants:</div>
                    <div class="detail-value"><%= (university.getNumApplicants() != -1) ? university.getNumApplicants() : "Not specified" %></div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Percent Admitted:</div>
                    <div class="detail-value"><%= (university.getPercentAdmitted() != -1) ? university.getPercentAdmitted() + "%" : "Not specified" %></div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Percent Enrolled:</div>
                    <div class="detail-value"><%= (university.getPercentEnrolled() != -1) ? university.getPercentEnrolled() + "%" : "Not specified" %></div>
                </div>
            </div>
            
            <div class="detail-section">
                <h3>Campus Life</h3>
                <div class="detail-row">
                    <div class="detail-label">Academic Scale:</div>
                    <div class="detail-value"><%= (university.getScaleAcademics() != -1) ? university.getScaleAcademics() + "/5" : "Not specified" %></div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Social Scale:</div>
                    <div class="detail-value"><%= (university.getScaleSocial() != -1) ? university.getScaleSocial() + "/5" : "Not specified" %></div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Quality of Life Scale:</div>
                    <div class="detail-value"><%= (university.getScaleQualityOfLife() != -1) ? university.getScaleQualityOfLife() + "/5" : "Not specified" %></div>
                </div>
            </div>
            
            <% if (university.getEmphases() != null && !university.getEmphases().isEmpty()) { %>
                <div class="detail-section">
                    <h3>Emphases</h3>
                    <div class="detail-row">
                        <div class="detail-value">
                            <% for (String emphasis : university.getEmphases()) { %>
                                <%= emphasis %><br>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
        
        <div class="action-buttons">
            <a href="SaveSchoolAction.jsp?name=<%= university.getName() %>">
                <button type="button" class="action-button">Save School</button>
            </a>
            <a href="FindSimilarSchools.jsp?name=<%= university.getName() %>">
                <button type="button" class="action-button similar-button">Find Similar Schools</button>
            </a>
            <% if (request.getHeader("Referer") != null && request.getHeader("Referer").contains("SearchResults.jsp")) { %>
                <a href="SearchResults.jsp">
                    <button type="button" class="action-button back-button">Back to Search Results</button>
                </a>
            <% } else if (request.getHeader("Referer") != null && request.getHeader("Referer").contains("SavedSchools.jsp")) { %>
                <a href="SavedSchools.jsp">
                    <button type="button" class="action-button back-button">Back to Saved Schools</button>
                </a>
            <% } else { %>
                <a href="SearchUniversity.jsp">
                    <button type="button" class="action-button back-button">Back to Search</button>
                </a>
            <% } %>
            
            <% if (university.getWebpageUrl() != null && !university.getWebpageUrl().isEmpty()) { %>
                <a href="<%= university.getWebpageUrl() %>" target="_blank">
                    <button type="button" class="action-button external-link">Visit University Website</button>
                </a>
            <% } %>
        </div>
    </div>
</body>
</html>