<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add University</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
<%@ include file="TopBar.jsp" %>
  <h1>Search a University</h1>
  <form method="post" action="AddUniversityAction.jsp">
  <table>
  <tr>
    <td><label for="name">Name (ALL CAPS):</label></td>
    <td><input type="text" id="name" name="name" required /><td/>
    
    </tr>
    <tr>

    <td><label for="state">State (ALL CAPS):</label></td>
    <td><input type= "text" id="state" name="state" /><td/>
    
    </tr>
    <tr>

    <td><label for="location">Location (ALL CAPS):</label></td>
    <td><input type="text" id="location" name="location" /><td/>  
    
 	</tr>
    <tr>
    
    <td><label for="control">Control (ALL CAPS):</label></td>
    <td><input type="text" id="control" name="control" /></td>
    
    </tr>
    <tr>
    
    <td><label for="numStudents"># Students:</label></td>
    <td><input type="number" id="numStudents" name="numStudents" min="0" max="100000" /></td>
    
    </tr>
        <tr>
          <td><label for="percentFemale">% Female (e.g.45.0):</label></td>
          <td><input type="text" id="percentFemale" name="percentFemale" /></td>
        </tr>
        <tr>
          <td><label for="satVerbal">%SAT Verbal (e.g.450.0):</label></td>
          <td><input type="text" id="satVerbal" name="satVerbal" /></td>
        </tr>
        <tr>
          <td><label for="satMath">%SAT Math (e.g.450.0):</label></td>
          <td><input type="text" id="satMath" name="satMath" /></td>
        </tr>
        <tr>
          <td><label for="expenses">Expenses (e.g 4500.00):</label></td>
          <td><input type="text" id="expenses" name="expenses" /></td>
        </tr>
        <tr>
          <td><label for="percentFinancialAid">% Financial Aid (e.g 45.0):</label></td>
          <td><input type="text" id="percentFinancialAid" name="percentFinancialAid" /></td>
        </tr>
        <tr>
          <td><label for="numApplicants"># Applicants:</label></td>
          <td><input type="text" id="numApplicants" name="numApplicants" /></td>
        </tr>
        <tr>
          <td><label for="percentAdmitted">% Admitted (e.g.45.0):</label></td>
          <td><input type="text" id="percentAdmitted" name="percentAdmitted" /></td>
        </tr>
        <tr>
          <td><label for="percentEnrolled">% Enrolled (e.g.45.0):</label></td>
          <td><input type="text" id="percentEnrolled" name="percentEnrolled" /></td>
        </tr>
        <tr>
          <td><label for="scaleAcademics">Academics Scale:</label></td>
          <td><input type="text" id="scaleAcademics" name="scaleAcademics" /></td>
        </tr>
        <tr>
          <td><label for="scaleSocial">Social Scale:</label></td>
          <td><input type="text" id="scaleSocial" name="scaleSocial" /></td>
        </tr>
        <tr>
          <td><label for="scaleQualityOfLife">Quality-of-Life Scale:</label></td>
          <td><input type="text" id="scaleQualityOfLife" name="scaleQualityOfLife" /></td>
        </tr>

        <tr>
          <td colspan="2" style="text-align:center">
            <input type="submit" value="Add University" />
          </td>
        </tr>
      </table>
    </form>
	<a href="AdminHome.jsp"><button style="font-size:20px" style="text-align:center">Go Back</button></a>
  </body>
</html>