<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv='Content-Type' content='text/html;charset=utf-8'>
<meta name='viewport'
	content='user-scalable=no, width=device-width, initial-scale=1, shrink-to-fit=no'>
<meta name='apple-mobile-web-app-capable' content='yes'>
<meta name='apple-mobile-web-app-status-bar-style' content='black'>
<meta http-equiv='Cache-Control' content='no-cache'>
<meta http-equiv='Expires' content='0'>
<meta http-equiv='Pragma' content='no-cache'>
<title>onResort_mobile</title>
<script type='text/javascript'>
	var orientationEvent;
	var uAgent = navigator.userAgent.toLowerCase();
	var mobilePhones = 'android';
	if (uAgent.indexOf(mobilePhones) != -1) {
		orientationEvent = "resize"; // 안드로이드는 resize로 들어옴
	} else {
		orientationEvent = "orientationchange"; // 아이폰은 orientationchange로 들어옴
	}
	window.addEventListener(orientationEvent, function() {
		// alert("회전했어요!");
		location.href = '#';
	}, false);

	var prevScreen = 0;
	var sv_prevScreen = 0;
	function prevShow() {
		ScreenShow(prevScreen);
	}

	var muCnt = 5; // 서브메뉴
	var scCnt = 14; // 화면

	function fncShow(pos) {
		var i = 0;
		for (i = 0; i < scCnt; i++) {
			var obj = document.getElementById("s" + i);
			obj.style.display = 'none';
		}
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

	function ScreenShow(pos) {

		var i = 0;
		// 모든 메뉴 페이지 막기
		for (i = 0; i < muCnt; i++) {
			var obj = document.getElementById("menu" + i);
			obj.style.display = 'none';
		}
		for (i = 0; i < scCnt; i++) {
			var obj = document.getElementById("s" + i);
			if (i == pos) {
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
	
	window.addEventListener("load", function() {

		setTimeout(scrollTo, 0, 0, 1);

	}, false);



</script>
<style type='text/css'>
li {
	text-align: left;
	vertical-align: middle;
	margin: 5;
	padding: 10;
	height: 20;
	border: 2px;
	solid: red;
	font-size: 16px
}

ul {
	text-align: left;
	vertical-align: middle;
	margin: 2;
	padding: 10;
	height: 20;
	border: 2px;
	solid: red;
	font-size: 16px
}

tr, td {
	width: 80vh;
}
</style>
</head>
<body>
	<div id='container'
		style='text-align: center; width: device-width; height: device-height;'>
		<div
			style='position: fixed; top: 0px; height: 40px; width: 100%; z-index: 999'>
			<div id='header1'
				style='background-color: #212529; height: 40px; width: 15%; float: left; vertical-align: middle'
				onclick='prevShow();'>
				<img src='back_btn.png' width='30px' height='30px'
					style='vertical-align: -webkit-baseline-middle' />
			</div>
			<div id='header2'
				style='background-color: #212529; color: white; height: 40px; width: 70%; float: left; display: flex; align-items: center; justify-content: center;'>
				ONResort</div>
			<div id='header3'
				style='background-color: #212529; height: 40px; width: 15%; float: left;'
				onclick='ScreenShow(0);'>
				<img src='home_btn.png' width='30px' height='30px'
					style='vertical-align: -webkit-baseline-middle'>
			</div>
		</div>

		<div style='margin-bottom: 50px; width: 100%; overflow: auto;'>
			<div id='menu0'
				style='margin-top: 50px; height: 100%; display: none; width: device-width'>
				<h3>리조트소개</h3>
				<ul>
					<li onclick='ScreenShow(0);'>온리조트</li>
					<li onclick='ScreenShow(1);'>퍼스트클래스</li>
					<li onclick='ScreenShow(2);'>비즈니스</li>
					<li onclick='ScreenShow(3);'>이코노미</li>
				</ul>
				<br>
			</div>
			<div id='menu1'
				style='margin-top: 50px; height: 100%; display: none; width: device-width'>
				<h3>찾아오기</h3>
				<ul>
					<li onclick='ScreenShow(4);'>찾아오는길</li>
					<li onclick='ScreenShow(5);'>대중교통이용</li>
					<li onclick='ScreenShow(6);'>자가용이용</li>
				</ul>
				<br>
			</div>
			<div id='menu2'
				style='margin-top: 50px; height: 100%; display: none; width: device-width'>
				<h3>주변명소</h3>
				<ul>
					<li onclick='ScreenShow(7);'>높아산</li>
					<li onclick='ScreenShow(8);'>온해수욕장</li>
					<li onclick='ScreenShow(9);'>따끈온천</li>
				</ul>
				<br>
			</div>
			<div id='menu3'
				style='margin-top: 50px; height: 100%; display: none; width: device-width'>
				<h3>예약하기</h3>
				<ul>
					<li onclick='ScreenShow(10);'>예약상황</li>
					<li onclick='ScreenShow(11);'>예약하기</li>
				</ul>
				<br>
			</div>
			<div id='menu4'
				style='margin-top: 50px; height: 100%; display: none; width: device-width'>
				<h3>펜션소식</h3>
				<ul>
					<li onclick='ScreenShow(12);'>리조트소식</li>
					<li onclick='ScreenShow(13);'>이용후기</li>
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
			<iframe src='reservation_view.jsp' style='width: 100vw; height: 80vh'
				frameborder='0' border='0' bordercolor='white' marginwidth='0'
				marginheight='0' scrolling='yes' style='margin-top:45px'></iframe>
		</div>

		<div id='s11' style='display: none;'>
			<iframe src='reservation_reserve.jsp'
				style='width: 100vw; height: 80vh' frameborder='0' border='0'
				bordercolor='white' marginwidth='0' marginheight='0' scrolling='yes'></iframe>
		</div>

		<div id='s12' style='display: none;'>
			<iframe src='board_notice_list.jsp'
				style='width: 100vw; height: 80vh' frameborder='0' border='0'
				bordercolor='white' marginwidth='0' marginheight='0' scrolling='yes'></iframe>
		</div>

		<div id='s13' style='display: none;'>
			<iframe src='board_review_list.jsp'
				style='width: 100vw; height: 80vh' frameborder='0' border='0'
				bordercolor='white' marginwidth='0' marginheight='0' scrolling='yes'></iframe>
		</div>




		<div
			style='position: fixed; bottom: 0px; background-color: #212529; height: 60px; width: 100%; text-align: center'>
			<div id='m0' onclick='fncShow(0);'
				style='position: absolute; left: 0%; color: white; background-color: #212529; height: 60px; width: 20%; float: left;'>
				<img src='m1_btn.png' width=30px height=30px
					style='margin-top: 8px;'><br> <font size=2>리조트소개</font>
			</div>

			<div id='m1' onclick='fncShow(1);'
				style='position: absolute; left: 20%; color: white; background-color: #212529; height: 60px; width: 20%; float: left;'>
				<img src='m2_btn.png' width=30px height=30px
					style='margin-top: 8px;'><br> <font size=2>찾아오기</font>
			</div>

			<div id='m2' onclick='fncShow(2);'
				style='position: absolute; left: 40%; color: white; background-color: #212529; height: 60px; width: 20%; float: left;'>
				<img src='m3_btn.png' width=30px height=30px
					style='margin-top: 8px;'><br> <font size=2>주변명소</font>
			</div>

			<div id='m3' onclick='fncShow(3);'
				style='position: absolute; color: white; left: 60%; background-color: #212529; height: 60px; width: 20%; float: left;'>
				<img src='m4_btn.png' width=30px height=30px
					style='margin-top: 8px;'><br> <font size=2>예약하기</font>
			</div>

			<div id='m4' onclick='fncShow(4);'
				style='position: absolute; left: 80%; color: white; background-color: #212529; height: 60px; width: 20%; float: left;'>
				<img src='m5_btn.png' width=30px height=30px
					style='margin-top: 8px;'><br> <font size=2>펜션소식</font>
			</div>
		</div>
		<script>
			ScreenShow(0);
		</script>
	</div>

</body>
</html>