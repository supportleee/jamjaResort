<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"><!-- 모바일 넓이에 맞게 출력되도록 하는 태그 -->
<meta name="description" content="">
<meta name="author" content="">
<title>onResort</title>
</head>
<body>
	<%	
		session.invalidate(); // 로그아웃 시 세션 파괴
		response.sendRedirect("main.html"); // 로그아웃 후 main으로 가기
	%>
</body>
</html>