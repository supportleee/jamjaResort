<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		$('#header').load('header.html');
		$('#footer').load('footer.html');
	});
</script>

<%
	String room = request.getParameter("room");
	int room_num = 0;
	if(room==null | room=="") {
		
	} else {
		room_num = Integer.parseInt(room);
	}
	
	String resv_date = request.getParameter("resv_date");
	%>

<script type='text/javascript'>
	$(function() {
		// 셀렉트박스 selected 처리
		$("select").each(
				function() {
					var rel = $(this).attr("rel");
					$(this).find("option[value=" + rel + "]").attr("selected",
							"selected");
				});
		$("input#resv_date").prop('min', function() {
			// 예약일의 최솟값을 예약당일로 설정하기
			return new Date().toJSON().split('T')[0];
		});
		$("input#resv_date").prop('max', function() {
			// 예약일의 최댓값을 예약당일+29일까지로 설정하기
			var today = new Date();
			today.setDate(today.getDate()+29);
			return today.toJSON().split('T')[0];
		});
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
			예약하기 <small>예약하기</small>
		</h1>

		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.html">메인</a></li>
			<li class="breadcrumb-item active">예약하기</li>
		</ol>
		<!-- Item Row -->
		<div class="row">
			<div class='col-md-12 mb-4'>
				<h3>예약하기</h3>
				<form name='reservation' id='reservation' method='post'
					action='reservation_write.jsp'>
					<div class='control-group form-group'>
						<div class='controls'>
							<label>성명 :</label> <input type='text' class='form-control'
								id='name' name='name' required placeholder='성명을 입력해주세요.'
								maxlength='10' pattern="[가-힣|a-z|A-Z]{1,10}">
						</div>
					</div>
					<div class='control-group form-group'>
						<div class='controls'>
							<label>예약일자 :</label> <input type='date' class='form-control'
								id='resv_date' name='resv_date' required value='<%=resv_date%>'>
						</div>
					</div>
					<div class='control-group form-group'>
						<div class='controls'>
							<label>예약방 :</label> <select name='room' rel='<%=room_num %>' class='form-control'
								required>
								<option value="">방 선택</option>
								<option value='1'>퍼스트클래스</option>
								<option value='2'>비즈니스</option>
								<option value='3'>이코노미</option>
							</select>
						</div>
					</div>
					<div class='control-group form-group'>
						<div class='controls'>
							<label>주소 :</label> <input type='text' class='form-control'
								id='addr' name='addr' required placeholder='주소를 입력해주세요.'
								maxlength='50'>
						</div>
					</div>
					<div class='control-group form-group'>
						<div class='controls'>
							<label>전화번호 :</label> <input type='text' class='form-control'
								id='telnum' name='telnum' required
								placeholder='전화번호를 입력해주세요. ex)010-0000-0000 형태로 입력'
								pattern="(010)-\d{3,4}-\d{4}">
						</div>
					</div>
					<div class='control-group form-group'>
						<div class='controls'>
							<label>입금자명 :</label> <input type='text' class='form-control'
								id='in_name' name='in_name' required placeholder='입금자명을 입력해주세요.' pattern="[가-힣|a-z|A-Z]{1,10}"
								maxlength='10'>
						</div>
					</div>
					<div class='control-group form-group'>
						<div class='controls'>
							<label>남기실 말 :</label> <input type='text' class='form-control'
								id='comment' name='comment'
								placeholder='남기실 말을 입력해주세요. (100자 이내)' maxlength='100'>
						</div>
					</div>
					<button type='submit' class='btn btn-primary' id='reservationbtn'>예약하기</button>
				</form>
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