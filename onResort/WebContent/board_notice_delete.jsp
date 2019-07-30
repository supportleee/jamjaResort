<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="onResort.service.NoticeService"%>
<%@ page import="onResort.service.NoticeServiceImpl"%>
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
		NoticeService noticeService = new NoticeServiceImpl();
		noticeService.delete(Integer.parseInt(key));
		response.sendRedirect("board_notice_list.jsp");
	%>
</body>
</html>