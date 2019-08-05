<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.net.*, java.io.*"%>
<%@ page import="onResort.service.*, onResort.dto.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>onResort</title>
<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/modern-business.css" rel="stylesheet">

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

<script>
	$(document).ready(function() {
		$('#header').load('header.jsp');
		$('#footer').load('footer.html');
	});
</script>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");

		String jump = request.getParameter("jump");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		AdminInfoService service = new AdminInfoServiceImpl();
		AdminInfoDto dto = service.selectOne(id);

		boolean bPassChk = false;
		if (id.replaceAll(" ", "").equals(dto.getId()) && pw.replaceAll(" ", "").equals(dto.getPw())) {
			bPassChk = true;
		} else {
			bPassChk = false;
		}

		// 비밀번호 체크 끝나면 세션 기록 후 점프
		if (bPassChk) {
			session.setAttribute("login_ok", "yes");
			session.setAttribute("login_id", id);
			response.sendRedirect(jump); // 로그인 체크 후 돌아갈 곳
		} else {
	%>
	<script>
		alert("아이디 혹은 비밀번호 오류");
		location.href = 'admin_login.jsp';
	</script>
	<%
		}
	%>
</body>
</html>