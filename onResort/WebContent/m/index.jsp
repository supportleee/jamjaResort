<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv='Content-Type' content='text/html;charset=utf-8'>
<meta name='viewport' content='user-scalable=no, width=device-width, initial-scale=1, shrink-to-fit=no'> <!-- 모바일 넓이에 맞게 출력되도록 하는 태그 -->
<meta name='apple-mobile-web-app-capable' content='yes'> <!-- 아이폰일 경우 웹 애플리케이션을 전체 화면에서 작동시키기 위해 넣어줌 -->
<meta name='apple-mobile-web-app-status-bar-style' content='black'> <!-- 아이폰일 경우 상태바 막대가 검은색이 되도록 지정 -->
<meta http-equiv='Cache-Control' content='no-cache'> <!-- cache를 가져오지 않게 하며 항상 서버에 접속하도록 함 -->
<meta http-equiv='Pragma' content='no-cache'> <!-- cache를 가져오지 않게 하며 항상 서버에 접속하도록 함 -->
<meta http-equiv='Expires' content='0'> <!-- cache 만료일 지정 -->
<title>onResort_mobile</title>
<script type='text/javascript'>
	var orientationEvent; // 방향 전환 상태용 변수
	var uAgent = navigator.userAgent.toLowerCase(); // 디바이스의 os
	var mobilePhones = 'android';
	if (uAgent.indexOf(mobilePhones) != -1) {
		orientationEvent = "resize"; // 안드로이드는 resize로 들어옴
	} else {
		orientationEvent = "orientationchange"; // 아이폰은 orientationchange로 들어옴
	}
	
	// 화면 회전 이벤트 처리
	window.addEventListener(orientationEvent, function() {
		// alert("회전했어요!");
		location.href = '#'; // 화면 reload
	}, false); // bubble 단계에서 이벤트 포착

	var prevScreen = 0;
	var sv_prevScreen = 0;
	function prevShow() { // 뒤로가기 버튼 클릭 시
		ScreenShow(prevScreen);
	}

	var muCnt = 5; // 서브메뉴
	var scCnt = 14; // 화면

	// 메뉴버튼 눌렀을 때 메소드
	function fncShow(pos) {
		var i = 0;
		// 상세화면 페이지 모두 안보이게 처리
		for (i = 0; i < scCnt; i++) {
			var obj = document.getElementById("s" + i);
			obj.style.display = 'none';
		}
		// 메뉴버튼 객체 가져와서 눌린 버튼만 스타일 다르게 지정
		for (i = 0; i < muCnt; i++) {
			var obj = document.getElementById("menu" + i);
			var obj2 = document.getElementById("m" + i);
			if (i == pos) {
				obj.style.display = '';
				obj2.style.background = '#212529';
				obj2.style.color = 'white';
			} else {
				obj.style.display = 'none';
				obj2.style.background = '#EEEEEE';
				obj2.style.color = 'black';
			}
		}
	}

	var scCnt = 14;
	var ScrObj;

	var timer1;
	
	// 상세메뉴 클릭 시 동작하는 스크린 애니메이션
	function ScrAnimation() {
		var offset = -50;
		if (parseInt(ScrObj.style.left) > 10) {
			ScrObj.style.left = parseInt(ScrObj.style.left) + offset + "px";
			timer1 = setTimeout("ScrAnimation()", 1);
		} else {
			ScrObj.style.left = 5;
			clearTimeout(timer1);
		}
	}

	// 상세메뉴 클릭 시 동작. 스크린 보여주는 function
	function ScreenShow(pos) {
		var i = 0;
		// 모든 메뉴 페이지 막기
		for (i = 0; i < muCnt; i++) {
			var obj = document.getElementById("menu" + i);
			obj.style.display = 'none';
		}
		// 선택된 메뉴의 값 빼고 모두 가리기
		for (i = 0; i < scCnt; i++) {
			var obj = document.getElementById("s" + i);
			if (i == pos) {
				// 선택됐을 경우
				prevScreen = sv_prevScreen;
				sv_prevScreen = i;
				obj.style.display = '';
				obj.style.position = 'relative';
				obj.style.top = 35;
				obj.style.left = screen.width;
				obj.style.height = screen.height - 120;
				ScrObj = obj;
				ScrAnimation();
			} else {
				obj.style.display = 'none';
			}
		}
	}
	
	// 쿠키 만들기
	function setCookie(cname, cvalue, exdays) {
		var d = new Date();
		d.setTime(d.getTime() + (exdays * 24 * 60 * 1000)); // 쿠키 시간 설정하기
		var expires = "expires=" + d.toGMTString(); // 만료일은 설정한 시간으로 지정
		document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/"; // 쿠키 생성
	}

	// 쿠키 얻어오기
	function getCookie(cname) {
		var recent_visit = cname + "=";  // 넘어온 값으로 쿠키 키값 설정
		var decodedCookie = decodeURIComponent(document.cookie); // 쿠키값 decode하기
		var ca = decodedCookie.split(';'); // decode한 쿠키 ;로 자르기
		for (var i = 0; i < ca.length; i++) {
			var c = ca[i]; // 잘라진 쿠키 각 값 비교하기 위해 변수에 넣기
			while (c.charAt(0) == ' ') { // 첫글자가 공백이면 
				c = c.substring(1); // 2번째 글자부터로 다시 세팅
			}
			// 쿠키 키값 중에 recent_visit가 있으면
			if (c.indexOf(recent_visit) == 0) {
				// value값만 잘라서 return
				return c.substring(recent_visit.length, c.length);
			}
		}
		// 해당하는 쿠키가 없으면 "" return
		return "";
	}

	// 쿠키 확인하기
	function checkCookie() {
		var visit = getCookie("recent_visit"); // recent_visit라는 키값을 가진 쿠키 검색
		if (visit != "") { // 쿠키가 있으면
			$('#recent_visit').text("최근 방문일: " + visit); // 방문일 출력
			visit = timeForCookie(); // 방문한 시간으로 시간 재지정
			setCookie("recent_visit", visit, 365); // 재지정한 시간으로 쿠키 다시 만들기
		} else { // 쿠키가 없으면
			$('#recent_visit').text("첫 방문입니다.");
			visit = timeForCookie(); // 방문한 시간으로 시간 지정
			setCookie("recent_visit", visit, 365); // 지정한 시간으로 만료일 1년짜리 쿠키 만들기
		}
	}

	// 쿠키 세팅 시 사용하는 시간 지정 function
	function timeForCookie() {
		var d = new Date();
		// 현재 시간을 string 형태로 저장
		var current = d.getFullYear() + "-" + (d.getMonth() + 1) + "-"
				+ d.getDate() + " " + d.getHours() + ":" + d.getMinutes() + ":"
				+ d.getSeconds();
		console.log(current);
		return current;
	}
</script>

<style type='text/css'>
.menu_li {
	text-align: left;
	vertical-align: middle;
	margin: 5px;
	padding: 10px;
	border: 2px;
	font-size: 16px;
	font-weight: lighter;
	list-style-type: none;
	background-color: #EEEEEE;
}

ul {
	text-align: left;
	vertical-align: middle;
	margin: 2px;
	padding: 10px;
	border: 2px;
	font-size: 16px;
}

tr, td {
	width: 80vh;
}

.h3_title {
	font-weight: bold;
}
</style>
</head>
<body>
	<div id='container' style='text-align: center; width: device-width; height: device-height;'>
		<!-- 고정된 메뉴바를 구현하기 위해 position을 fixed로 주기. 내용 부분을 덮기 위해 z-index:999를 줌 -->
		<div style='position: fixed; top: 0px; height: 40px; width: 100%; z-index: 999'>
			<div id='header1' style='background-color: #212529; height: 40px; width: 15%; float: left; vertical-align: middle' onclick='prevShow();'>
				<img src='back_btn.png' width='30px' height='30px' style='vertical-align: -webkit-baseline-middle' />
			</div>
			<div id='header2' style='background-color: #212529; color: white; height: 40px; width: 70%; float: left; display: flex; align-items: center; justify-content: center;'>ONResort</div>
			<div id='header3' style='background-color: #212529; height: 40px; width: 15%; float: left;' onclick='ScreenShow(0);'>
				<img src='home_btn.png' width='30px' height='30px' style='vertical-align: -webkit-baseline-middle'>
			</div>
		</div>
		<!-- 메뉴바와 footer 사이에 들어갈 내용물. 메뉴바만큼 margin-top주기 -->
		<div style='margin-bottom: 50px; width: 100%; overflow: auto;'>
			<div id='menu0' style='margin-top: 50px; height: 100%; display: none; width: device-width'>
				<h3 class='h3_title'>리조트소개</h3>
				<ul>
					<li class='menu_li' onclick='ScreenShow(0);'>온리조트</li>
					<li class='menu_li' onclick='ScreenShow(1);'>퍼스트클래스</li>
					<li class='menu_li' onclick='ScreenShow(2);'>비즈니스</li>
					<li class='menu_li' onclick='ScreenShow(3);'>이코노미</li>
				</ul>
				<br>
			</div>
			<div id='menu1' style='margin-top: 50px; height: 100%; display: none; width: device-width'>
				<h3 class='h3_title'>찾아오기</h3>
				<ul>
					<li class='menu_li' onclick='ScreenShow(4);'>찾아오는길</li>
					<li class='menu_li' onclick='ScreenShow(5);'>대중교통이용</li>
					<li class='menu_li' onclick='ScreenShow(6);'>자가용이용</li>
				</ul>
				<br>
			</div>
			<div id='menu2' style='margin-top: 50px; height: 100%; display: none; width: device-width'>
				<h3 class='h3_title'>주변명소</h3>
				<ul>
					<li class='menu_li' onclick='ScreenShow(7);'>높아산</li>
					<li class='menu_li' onclick='ScreenShow(8);'>온해수욕장</li>
					<li class='menu_li' onclick='ScreenShow(9);'>따끈온천</li>
				</ul>
				<br>
			</div>
			<div id='menu3' style='margin-top: 50px; height: 100%; display: none; width: device-width'>
				<h3 class='h3_title'>예약하기</h3>
				<ul>
					<li class='menu_li' onclick='ScreenShow(10);'>예약상황</li>
					<li class='menu_li' onclick='ScreenShow(11);'>예약하기</li>
				</ul>
				<br>
			</div>
			<div id='menu4' style='margin-top: 50px; height: 100%; display: none; width: device-width'>
				<h3 class='h3_title'>펜션소식</h3>
				<ul>
					<li class='menu_li' onclick='ScreenShow(12);'>리조트소식</li>
					<li class='menu_li' onclick='ScreenShow(13);'>이용후기</li>
				</ul>
				<br>
			</div>

			<div id='s0' style='display: none; width: device-width;'>
				<jsp:include page='intro.html' />
			</div>

			<div id='s1' style='display: none; width: device-width;'>
				<jsp:include page='about_firstClassRoom.html' />
			</div>

			<div id='s2' style='display: none; width: device-width;'>
				<jsp:include page='about_businessRoom.html' />
			</div>

			<div id='s3' style='display: none; width: device-width;'>
				<jsp:include page='about_economyRoom.html' />
			</div>

			<div id='s4' style='display: none;'>
				<jsp:include page='access_map.html' />
			</div>

			<div id='s5' style='display: none;'>
				<jsp:include page='access_publicTransport.html' />
			</div>

			<div id='s6' style='display: none;'>
				<jsp:include page='access_privateCar.html' />
			</div>

			<div id='s7' style='display: none;'>
				<jsp:include page='spot_mountain.html' />
			</div>

			<div id='s8' style='display: none;'>
				<jsp:include page='spot_beach.html' />
			</div>

			<div id='s9' style='display: none;'>
				<jsp:include page='spot_hotSpring.html' />
			</div>
		</div>

		<div id='s10' style='display: none;'>
			<iframe src='reservation_view.jsp' style='width: 100vw; height: 80vh' frameborder='0' border='0' bordercolor='white' marginwidth='0' marginheight='0' scrolling='yes' style='margin-top:45px'></iframe>
		</div>

		<div id='s11' style='display: none;'>
			<iframe src='reservation_reserve.jsp' style='width: 100vw; height: 80vh' frameborder='0' border='0' bordercolor='white' marginwidth='0' marginheight='0' scrolling='yes'></iframe>
		</div>

		<div id='s12' style='display: none;'>
			<iframe src='board_notice_list.jsp' style='width: 100vw; height: 80vh' frameborder='0' border='0' bordercolor='white' marginwidth='0' marginheight='0' scrolling='yes'></iframe>
		</div>

		<div id='s13' style='display: none;'>
			<iframe src='board_review_list.jsp' style='width: 100vw; height: 80vh' frameborder='0' border='0' bordercolor='white' marginwidth='0' marginheight='0' scrolling='yes'></iframe>
		</div>

		<!-- 고정된 footer를 구현하기 위해 position을 fixed로 함 -->
		<div style='position: fixed; bottom: 0px; background-color: #212529; height: 60px; width: 100%; text-align: center'>
			<div id='m0' onclick='fncShow(0);' style='position: absolute; left: 0%; color: white; background-color: #212529; height: 60px; width: 20%; float: left;'>
				<img src='m1_btn.png' width=30px height=30px style='margin-top: 8px;'><br> <font size=2>리조트소개</font>
			</div>

			<div id='m1' onclick='fncShow(1);' style='position: absolute; left: 20%; color: white; background-color: #212529; height: 60px; width: 20%; float: left;'>
				<img src='m2_btn.png' width=30px height=30px style='margin-top: 8px;'><br> <font size=2>찾아오기</font>
			</div>

			<div id='m2' onclick='fncShow(2);' style='position: absolute; left: 40%; color: white; background-color: #212529; height: 60px; width: 20%; float: left;'>
				<img src='m3_btn.png' width=30px height=30px style='margin-top: 8px;'><br> <font size=2>주변명소</font>
			</div>

			<div id='m3' onclick='fncShow(3);' style='position: absolute; color: white; left: 60%; background-color: #212529; height: 60px; width: 20%; float: left;'>
				<img src='m4_btn.png' width=30px height=30px style='margin-top: 8px;'><br> <font size=2>예약하기</font>
			</div>

			<div id='m4' onclick='fncShow(4);' style='position: absolute; left: 80%; color: white; background-color: #212529; height: 60px; width: 20%; float: left;'>
				<img src='m5_btn.png' width=30px height=30px style='margin-top: 8px;'><br> <font size=2>펜션소식</font>
			</div>
		</div>
		
		<!-- 로드될 때 s0 화면을 보여주기 위해 ScreenShow(0); 실행 -->
		<!-- 로드될 때 쿠키를 체크하기 -->
		<script>
			ScreenShow(0);
			checkCookie();
		</script>
	</div>

</body>
</html>