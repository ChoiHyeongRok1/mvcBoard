<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	int currentPage = Integer.parseInt(request.getParameter("currentPage"));

	response.sendRedirect("list.nhn?currentPage=" + currentPage);
%>
</body>
</html>