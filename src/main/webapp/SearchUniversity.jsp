<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="cmc.backend.*, java.util.List, cmc.backend.entities.University" %>
<jsp:include page="VerifyLogin.jsp" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Universities</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .search-container {
            width: 80%;
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #f0f8ff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        
        .search-buttons {
            text-align: center;
            margin-top: 20px;
        }
        
        .search-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        
        .search-button:hover {
            background-color: #45a049;
        }
        
        .reset-button {
            background-color: #f44336;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-left: 10px;
            transition: background-color 0.3s;
        }
        
        .reset-button:hover {
            background-color: #d32f2f;
        }
        
        h1 {
            color: #2e5cb8;
            text-align: center;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <jsp:include page="TopBar.jsp" />
    
    <h1>Search Universities</h1>
    
    <div class="search-container">
        <form action="SearchResults.jsp" method="post">
            <div class="form-group">
                <label for="state">State (leave blank for all states):</label>
                <input type="text" id="state" name="state" placeholder="e.g. MINNESOTA">
            </div>
            
            <div class="form-group">
                <label for="location">Location Type:</label>
                <select id="location" name="location">
                    <option value="">Any Location</option>
                    <option value="URBAN">Urban</option>
                    <option value="SUBURBAN">Suburban</option>
                    <option value="SMALL-CITY">Small City</option>
                    <option value="RURAL">Rural</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="control">School Control:</label>
                <select id="control" name="control">
                    <option value="">Any Control</option>
                    <option value="STATE">State</option>
                    <option value="PRIVATE">Private</option>
                    <option value="CITY">City</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="numStudents">Number of Students (leave blank for any size):</label>
                <input type="number" id="numStudents" name="numStudents" placeholder="e.g. 10000">
            </div>
            
            <div class="search-buttons">
                <button type="submit" class="search-button">Search</button>
                <button type="reset" class="reset-button">Reset</button>
            </div>
        </form>
    </div>
</body>
</html>