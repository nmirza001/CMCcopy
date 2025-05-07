<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="VerifyStudent.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .dashboard {
            width: 80%;
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #f0f8ff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .feature-links {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 30px;
        }
        .feature-link {
            background-color: #4CAF50;
            color: white;
            padding: 15px 25px;
            margin: 10px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
            width: 200px;
        }
        .feature-link:hover {
            background-color: #45a049;
            transform: scale(1.05);
        }
        .search-link { background-color: #2196F3; }
        .search-link:hover { background-color: #0b7dda; }
        .saved-link { background-color: #ff9800; }
        .saved-link:hover { background-color: #e68a00; }
        .profile-link { background-color: #673AB7; }
        .profile-link:hover { background-color: #5e35b1; }
    </style>
</head>
<body>
    <%@include file="TopBar.jsp" %>
    <div class="dashboard">
        <h1>Welcome to Choose My College</h1>
        <p>Your one-stop solution for finding and comparing universities that match your preferences.</p>
        <div class="feature-links">
            <a href="SearchUniversity.jsp" class="feature-link search-link">Search Universities</a>
            <a href="SavedSchools.jsp" class="feature-link saved-link">View Saved Schools</a>
            <a href="EditMyProfile.jsp" class="feature-link profile-link">Edit Profile</a>
        </div>
    </div>
</body>
</html>