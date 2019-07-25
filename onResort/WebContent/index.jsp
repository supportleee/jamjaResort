<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 넘어오는 값 받아서 div에 배치할 것 지정하기
	String contentPage = request.getParameter("contentPage");
	if (contentPage == null) {
		contentPage = "main.html";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온리조트</title>
</head>
<body>
	<table>
		<tr>
			<td><jsp:include page="menu.html"/></td>
		</tr>
		<tr>
			<td><jsp:include page="<%=contentPage %>" /></td>
		</tr>
		<tr>
			<td><jsp:include page="footer.html"/></td>
		</tr>
	</table>
</body>
</html>