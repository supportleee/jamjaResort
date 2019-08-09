<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.net.*, java.io.*"%>
<%@ page import="onResort.service.*, onResort.dto.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <!-- 모바일 넓이에 맞게 출력되도록 하는 태그 -->
<meta name="description" content="">
<meta name="author" content="">
<title>onResort</title>
<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/modern-business.css" rel="stylesheet">
<!-- jquery -->
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

<script>
	// header, footer 설정
	$(document).ready(function() {
		$('#header').load('header.jsp');
		$('#footer').load('footer.html');
	});
</script>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		// 파라미터 가져오기
		String jump = request.getParameter("jump");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		// service를 사용하기 위해 선언
		AdminInfoService service = new AdminInfoServiceImpl();
		AdminInfoDto dto = service.selectOne(id); // 파라미터로 가져온 아이디값으로 selectOne 호출
		
		boolean bPassChk = false; // 비밀번호 맞는지 확인용 변수
		//입력한 값과 DB의 값이 같으면 true, 다르면 false로 세팅
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
		location.href = 'admin_login.jsp?jump=reservation_admin_allview.jsp';
	</script>
	<%
		}
	%>
</body>
</html>