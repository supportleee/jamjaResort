<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="onResort.service.Review_boardService"%>
<%@ page import="onResort.service.Review_boardServiceImpl"%>
<%@ page import="onResort.dto.*"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>onResort</title>
</head>
<body>
	<%
		String key = request.getParameter("key");
		Review_boardService reviewService = new Review_boardServiceImpl();
		reviewService.delete(Integer.parseInt(key));
		response.sendRedirect("board_review_list.jsp");
	%>
</body>
</html>