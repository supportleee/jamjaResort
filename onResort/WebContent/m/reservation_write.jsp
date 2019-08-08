<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import='onResort.service.ReservationService'%>
<%@ page import='onResort.service.ReservationServiceImpl'%>
<%@ page import='onResort.dto.*'%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import='java.util.TimeZone'%>
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
			예약하기 <small>예약하기</small>
		</h1>

		<ol class="breadcrumb">
			<li class="breadcrumb-item">메인</li>
			<li class="breadcrumb-item active">예약하기</li>
		</ol>
		<!-- Item Row -->
		<div class="row">
			<div class='col-md-12 mb-4'>
				<%
					try {
						String URL = request.getParameter("jump");

						ReservationService resvService = new ReservationServiceImpl();
						String name_before_encoded = request.getParameter("name");
						String name_after_encoded = new String(name_before_encoded.getBytes("8859_1"), "utf-8");
						String resv_date = request.getParameter("resv_date");
						String room = request.getParameter("room");
						String postcode = request.getParameter("postcode");
						String roadAddress_before_encoded = request.getParameter("roadAddress");
						String roadAddress_after_encoded = new String(roadAddress_before_encoded.getBytes("8859_1"), "utf-8");
						String detailAddress_before_encoded = request.getParameter("detailAddress");
						String detailAddress_after_encoded = new String(detailAddress_before_encoded.getBytes("8859_1"),
								"utf-8");
						String extraAddress_before_encoded = request.getParameter("extraAddress");
						String extraAddress_after_encoded = new String(extraAddress_before_encoded.getBytes("8859_1"), "utf-8");
						String telnum = request.getParameter("telnum");
						String in_name_before_encoded = request.getParameter("in_name");
						String in_name_after_encoded = new String(in_name_before_encoded.getBytes("8859_1"), "utf-8");
						String comment_before_encoded = request.getParameter("comment");
						String comment_after_encoded = "";
						if (comment_before_encoded == null | comment_before_encoded == "") {
						} else {
							comment_after_encoded = new String(comment_before_encoded.getBytes("8859_1"), "utf-8");
						}

						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						sdf.setTimeZone(TimeZone.getTimeZone("UTC")); // KST -> UTC로 타임존 변경하기
						Date date = sdf.parse(resv_date);

						ReservationDto dto = new ReservationDto(name_after_encoded, date, Integer.parseInt(room), postcode,
								roadAddress_after_encoded, detailAddress_after_encoded, extraAddress_after_encoded, telnum,
								in_name_after_encoded, comment_after_encoded);
						int ret = resvService.insert(dto);
						if (ret == -1) {
				%>
				<div class='mb-4'>예약 처리에 오류가 발생했습니다. 다시 시도해주세요.</div>
				<div class='mb-4'>
					<input type='button' class='btn btn-primary' value='뒤로가기'
						onclick="history.back(-1);">
				</div>
				<%
					} else if (ret == -2) {
				%>
				<div class='mb-4'>이미 예약된 방입니다. 다른 날짜나 다른 방으로 예약하시기 바랍니다.</div>
				<div class='mb-4'>
					<input type='button' class='btn btn-primary' value='뒤로가기'
						onclick="history.back(-1);">
				</div>
				<%
					} else {
				%>
				<div class='mb-4'>
					[<%=resv_date%>]일 [<%
					if (Integer.parseInt(room) == 1) {
				%>퍼스트클래스<%
					} else if (Integer.parseInt(room) == 2) {
				%>비즈니스<%
					} else {
				%>이코노미<%
					}
				%>]룸 예약이 완료되었습니다.
				</div>
				<div class='mb-4'>
					<%
						if (URL == null | URL.equals("") | URL.equals("null")) {
					%><input type='button' class='btn btn-primary' value='예약상황'
						onclick="location.href='reservation_view.jsp'">
					<%
						} else {
					%><input type='button' class='btn btn-primary' value='예약상황'
						onclick="location.href='reservation_admin_allview.jsp'">
					<%
						}
					%>

				</div>
				<%
					}
					} catch (Exception e) {
						e.getStackTrace();
						System.out.println(e);
					}
				%>
			</div>
		</div>
	</div>
	<!-- /.container -->

	<!-- Bootstrap core JavaScript -->
	<script src="../vendor/jquery/jquery.min.js"></script>
	<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>