<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import='onResort.service.ReservationService'%>
<%@ page import='onResort.service.ReservationServiceImpl'%>
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
<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

</head>
<body>


	<!-- Page Content -->
	<div class="container">

		<!-- Page Heading/Breadcrumbs -->
		<h1 class="my-2 mb-3">
			예약하기 <small>예약상황</small>
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
							<th>예약가능일</th>
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
							%><td><a href='reservation_reserve.jsp?resv_date=<%=resv_arr[i][0]%>&room=<%=j-1 %>'>예약가능</a></td>
							<%
								} else {
							%>
							<td><%=resv_arr[i][j]%></td>
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


	<!-- Bootstrap core JavaScript -->
	<script src="../vendor/jquery/jquery.min.js"></script>
	<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>