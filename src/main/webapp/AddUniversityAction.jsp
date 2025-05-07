<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import= "cmc.backend.SystemController,cmc.backend.entities.University, cmc.CMCException"%>
<%@include file="VerifyAdmin.jsp" %>
<%
  // 1) Pull form fields into locals
  String name = request.getParameter("name").toUpperCase();
  String state = request.getParameter("state").toUpperCase();
  String location = request.getParameter("location").toUpperCase();
  String control = request.getParameter("control").toUpperCase();
  int numStudents = Integer.parseInt(request.getParameter("numStudents"));
  double percentFemale        = Double.parseDouble(request.getParameter("percentFemale"));
  double satVerbal            = Double.parseDouble(request.getParameter("satVerbal"));
  double satMath              = Double.parseDouble(request.getParameter("satMath"));
  double expenses             = Double.parseDouble(request.getParameter("expenses"));
  double percentFinancialAid  = Double.parseDouble(request.getParameter("percentFinancialAid"));
  int numApplicants           = Integer.parseInt(request.getParameter("numApplicants"));
  double percentAdmitted      = Double.parseDouble(request.getParameter("percentAdmitted"));
  double percentEnrolled      = Double.parseDouble(request.getParameter("percentEnrolled"));
  int scaleAcademics          = Integer.parseInt(request.getParameter("scaleAcademics"));
  int scaleSocial             = Integer.parseInt(request.getParameter("scaleSocial"));
  int scaleQualityOfLife      = Integer.parseInt(request.getParameter("scaleQualityOfLife"));

  // 2) Build a University object called `uni`
  University uni = new University(name);
  uni.setState(state);
  uni.setLocation(location);
  uni.setControl(control);
  uni.setNumStudents(numStudents);
  uni.setPercentFemale(percentFemale);
  uni.setSatVerbal(satVerbal);
  uni.setSatMath(satMath);
  uni.setExpenses(expenses);
  uni.setPercentFinancialAid(percentFinancialAid);
  uni.setNumApplicants(numApplicants);
  uni.setPercentAdmitted(percentAdmitted);
  uni.setPercentEnrolled(percentEnrolled);
  uni.setScaleAcademics(scaleAcademics);
  uni.setScaleSocial(scaleSocial);
  uni.setScaleQualityOfLife(scaleQualityOfLife);

  // 3) Delegate to your backend
  SystemController sc = new SystemController();
  boolean ok = sc.addNewUniversity(uni);  // ← pass `uni`, not your User

  // 4) Redirect on success or failure
  if (ok) {
      response.sendRedirect("AdminHome.jsp?msg=added");
  } else {
      response.sendRedirect("AddUniversity.jsp?error=1");
  }
%>