<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import='onResort.service.ReservationService'%>
<%@ page import='onResort.service.ReservationServiceImpl'%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no"> <!-- 모바일 넓이에 맞게 출력되도록 하는 태그 -->
<meta name="description" content="">
<meta name="author" content="">
<title>onResort</title>
<!-- Bootstrap core CSS -->
<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- jquery -->
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
.table thead th {
	vertical-align: middle;
}

.table td, .table th {
	vertical-align: middle;
}
</style>
</head>
<body>
	<!-- Page Content -->
	<div class="container">

		<!-- Page Heading/Breadcrumbs -->
		<h1 class="my-2 mb-3">
			예약하기 <small style='font-size: 60%;'>예약상황</small>
		</h1>

		<ol class="breadcrumb">
			<li class="breadcrumb-item">메인</li>
			<li class="breadcrumb-item active">예약상황</li>
		</ol>
		<!-- Item Row -->
		<div class="row">
			<div class='col-md-12 mb-4'>
				<table class='table text-center table-hover'>
					<thead>
						<tr>
							<th>날짜</th>
							<th>요일</th>
							<th>퍼스트<br>클래스</th>
							<th>비즈<br>니스</th>
							<th>이코<br>노미</th>
						</tr>
					</thead>
					<tbody>
						<%
							// service 사용을 위해 선언
							ReservationService resvService = new ReservationServiceImpl();
							// select 결과를 받을 배열 선언
							String[][] resv_arr = resvService.selectAllReservation();
							for (int i = 0; i < 30; i++) {
						%><tr>
							<%
								for (int j = 0; j < 5; j++) {
										if (j == 0) {
							%>
							<td><%=resv_arr[i][j].substring(5)%></td>
							<%
								} else {
											if (resv_arr[i][j] == null) {
							%><td><a
								href='reservation_reserve.jsp?resv_date=<%=resv_arr[i][0]%>&room=<%=j - 1%>'>예약<br>가능
							</a></td>
							<%
								} else {
							%>
							<td><%=resv_arr[i][j]%></td>
							<%
								}
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

	<!-- Bootstrap core JavaScript -->
	<script src="../vendor/jquery/jquery.min.js"></script>
	<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>