<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="java.sql.*, javax.sql.*, java.net.*, java.io.*"%>
<%@ page import='onResort.service.ReservationService'%>
<%@ page import='onResort.service.ReservationServiceImpl'%>
<%
	// 세션 체크해서 없으면 로그인창으로 보내기
	// 로그인창에서 로그인 성공 시 돌아올 URL로 자신의 URL 전달(reservation_admin_allview.jsp)
	String loginOK = null;
	String jumpURL = "admin_login.jsp?jump=reservation_admin_allview.jsp";

	loginOK = (String) session.getAttribute("login_ok");
	if (loginOK == null) {
		response.sendRedirect(jumpURL);
		return;
	}
	if (!loginOK.equals("yes")) {
		response.sendRedirect(jumpURL);
		return;
	}
%>
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
	<!-- Navigation -->
	<div id='header'></div>

	<!-- Page Content -->
	<div class="container">

		<!-- Page Heading/Breadcrumbs -->
		<h1 class="mt-4 mb-3">
			예약하기 <small>관리자페이지</small>
		</h1>

		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.html">메인</a></li>
			<li class="breadcrumb-item active">관리자페이지</li>
		</ol>
		<!-- Item Row -->
		<div class="row">
			<div class='col-md-12 mb-4'>
				<table class='table text-center table-hover'>
					<thead>
						<tr>
							<th style='font-size:inhereit;'>예약가능일</th>
							<th>요일</th>
							<th>퍼스트클래스</th>
							<th>비즈니스</th>
							<th>이코노미</th>
						</tr>
					</thead>
					<tbody>
						<%
							ReservationService resvService = new ReservationServiceImpl();
							String[][] resv_arr = resvService.selectAllReservation();
							for (int i = 0; i < 30; i++) {
						%><tr>
							<%
								for (int j = 0; j < 5; j++) {
										if (resv_arr[i][j] == null) {
							%><td><a
								href='reservation_reserve.jsp?resv_date=<%=resv_arr[i][0]%>&room=<%=j - 1%>&jump=reservation_admin_allview.jsp'>예약가능</a></td>
							<%
								} else if (j > 1) {
							%>
							<td><a
								href='reservation_admin_oneview.jsp?resv_date=<%=resv_arr[i][0]%>&room=<%=j - 1%>'><%=resv_arr[i][j]%></a></td>
							<%
								} else {
							%><td><%=resv_arr[i][j]%></td>
							<%
								}

									}
							%>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<!-- /.row -->
	</div>
	<!-- /.container -->
	<!-- Footer -->
	<footer class="py-5 bg-dark" id='footer'>
		<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>