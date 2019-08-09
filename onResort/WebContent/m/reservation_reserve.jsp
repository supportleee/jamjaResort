<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <!-- 모바일 넓이에 맞게 출력되도록 하는 태그 -->
<meta name="description" content="">
<meta name="author" content="">
<title>onResort</title>
<!-- Bootstrap core CSS -->
<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- jquery -->
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<%
	//넘어온 파라미터 뽑아내기
	String resv_date = request.getParameter("resv_date");
	String URL = request.getParameter("jump");
	String room = request.getParameter("room"); 
	int room_num = 0;
	if (room == null | room == "") { // 넘어온 값이 없으면
		// room_num=0;
	} else { // 넘어온 값이 있으면
		room_num = Integer.parseInt(room); // 넘어온 값으로 room_num 지정
	}
%>

<script type='text/javascript'>
	$(function() {
		// 셀렉트박스 selected 처리
		$("select").each(
				function() {
					var rel = $(this).attr("rel");
					$(this).find("option[value=" + rel + "]").attr("selected","selected");
				});
		$("input#resv_date").prop('min', function() {
			// 예약일의 최솟값을 예약당일로 설정하기
			return new Date().toJSON().split('T')[0];
		});
		$("input#resv_date").prop('max', function() {
			// 예약일의 최댓값을 예약당일+29일까지로 설정하기
			var today = new Date();
			today.setDate(today.getDate() + 29);
			return today.toJSON().split('T')[0];
		});
	});
	
	// 주소 입력했는지 확인하는 function
	function validation() {
		var postcode = $("#postcode").val();
		if (postcode == null | postcode == "") { // 우편번호가 비어있으면
			alert("주소검색을 통해 주소를 입력해주세요.");
			return false;
		}
		var roadAddress = $("#roadAddress").val();
		var detailAddress = $("#detailAddress").val();
		var extraAddress = $("#extraAddress").val();
		var result = roadAddress + " " + detailAddress + " " + extraAddress;
		$("#addr").val(result);
		var addr = $("#addr").val();
		return true;
	}
</script>
</head>
<body>
	<!-- Page Content -->
	<div class="container">

		<!-- Page Heading/Breadcrumbs -->
		<h1 class="my-2 mb-3">
			예약하기 <small style='font-size: 60%;'>예약하기</small>
		</h1>

		<ol class="breadcrumb">
			<li class="breadcrumb-item">메인</li>
			<li class="breadcrumb-item active">예약하기</li>
		</ol>
		<!-- Item Row -->
		<div class="row">
			<div class='col-md-12 mb-4'>
				<h3>예약하기</h3>
				<!-- 예약하기 버튼 눌렀을 때 validation() function으로 유효성 검사 후 return 값에 따라 처리 -->
				<form name='reservation' id='reservation' method='post' onsubmit='return validation();' action='reservation_write.jsp'>
					<div class='control-group form-group'>
						<div class='controls'>
							<label>성명 :</label> <input type='text' class='form-control' id='name' name='name' required placeholder='성명을 입력해주세요.' maxlength='10' pattern="[가-힣|a-z|A-Z]{1,10}">
						</div>
					</div>
					<div class='control-group form-group'>
						<div class='controls'>
							<label>예약일자 :</label> <input type='date' class='form-control' id='resv_date' name='resv_date' required value='<%=resv_date%>'>
						</div>
					</div>
					<div class='control-group form-group'>
						<div class='controls'>
							<label>예약방 :</label> <select name='room' rel='<%=room_num%>' class='form-control' required>
								<option value="">방 선택</option>
								<option value='1'>퍼스트클래스</option>
								<option value='2'>비즈니스</option>
								<option value='3'>이코노미</option>
							</select>
						</div>
					</div>
					<div class='control-group form-group'>
						<div class='controls'>
							<label>주소 :</label>
							<div class='input-group mb-3'>

								<input type='text' class='form-control' id='postcode' name='postcode' required placeholder='우편번호' aria-label="우편번호" readonly aria-describedby="addrSeachbtn">
								<div class='input-group-append'>
									<button class='btn btn-primary' type='button' onclick='execDaumPostcode()' id='addrSeachbtn'>주소 검색</button>
								</div>
							</div>
							<div class='mb-3'>
								<input type='text' class='form-control' id='roadAddress' name='roadAddress' required placeholder='도로명주소' readonly> <span id="guide" style="color: #999; display: none"></span>
							</div>
							<div class='input-group mb-3'>
								<input type='text' class="form-control" id='detailAddress' name='detailAddress' required placeholder='상세주소' pattern="[가-힣|a-z|A-Z|0-9]{1,20}"> <input type='text' class="form-control" id='extraAddress' name='extraAddress' placeholder='참고항목' readonly>
							</div>
							<input type='text' name='addr' id='addr' style='display: none;'>
						</div>
					</div>
					<div class='control-group form-group'>
						<div class='controls'>
							<label>전화번호 :</label> <input type='text' class='form-control' id='telnum' name='telnum' required placeholder='전화번호를 입력해주세요. ex)010-0000-0000 형태로 입력' pattern="(010)-\d{3,4}-\d{4}">
						</div>
					</div>
					<div class='control-group form-group'>
						<div class='controls'>
							<label>입금자명 :</label> <input type='text' class='form-control' id='in_name' name='in_name' required placeholder='입금자명을 입력해주세요.' pattern="[가-힣|a-z|A-Z]{1,10}" maxlength='10'>
						</div>
					</div>
					<div class='control-group form-group'>
						<div class='controls'>
							<label>남기실 말 :</label> <input type='text' class='form-control' id='comment' name='comment' placeholder='남기실 말을 입력해주세요. (100자 이내)' maxlength='100'>
						</div>
					</div>
					<input type='hidden' name='jump' value='<%=URL%>'>
					<button type='submit' class='btn btn-primary' id='reservationbtn'>예약하기</button>
				</form>
			</div>
		</div>
		<!-- /.row -->
	</div>
	<!-- /.container -->

	<!-- Bootstrap core JavaScript -->
	<script src="../vendor/jquery/jquery.min.js"></script>
	<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	
	<!-- daum address api -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
		function execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var roadAddr = data.roadAddress; // 도로명 주소 변수
							var extraRoadAddr = ''; // 참고 항목 변수

							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraRoadAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraRoadAddr += (extraRoadAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraRoadAddr !== '') {
								extraRoadAddr = ' (' + extraRoadAddr + ')';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('postcode').value = data.zonecode;
							document.getElementById("roadAddress").value = roadAddr;

							// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
							if (roadAddr !== '') {
								document.getElementById("extraAddress").value = extraRoadAddr;
							} else {
								document.getElementById("extraAddress").value = '';
							}

							var guideTextBox = document.getElementById("guide");
							// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
							if (data.autoRoadAddress) {
								var expRoadAddr = data.autoRoadAddress
										+ extraRoadAddr;
								guideTextBox.innerHTML = '(예상 도로명 주소 : '
										+ expRoadAddr + ')';
								guideTextBox.style.display = 'block';

							} else {
								guideTextBox.innerHTML = '';
								guideTextBox.style.display = 'none';
							}
						}
					}).open();
		}
	</script>
</body>
</html>