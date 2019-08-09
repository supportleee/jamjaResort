<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import='java.io.*'%>
<%@ page import='com.oreilly.servlet.*'%>
<%@ page import='com.oreilly.servlet.multipart.*'%>
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
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>

<!-- summernote -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>


<script>
	/* 업로드 체크 */
	function fileCheck(file) {
		// 사이즈체크
		var maxSize = 10 * 1024 * 1024 //10MB
		var fileSize = 0;

		// 브라우저 확인
		var browser = navigator.appName;

		// 익스플로러일 경우
		if (browser == "Microsoft Internet Explorer") {
			var oas = new ActiveXObject("Scripting.FileSystemObject");
			fileSize = oas.getFile(file.value).size;
		}
		// 익스플로러가 아닐경우
		else {
			fileSize = file.files[0].size;
		}

		if (fileSize > maxSize) {
			alert("파일사이즈 : " + fileSize + ", 최대파일사이즈 : 10MB");
			alert("첨부파일 사이즈는 10MB 이내로 등록 가능합니다.    ");
			return false;
		}

		return true;
	}
</script>
</head>

<body>
	<!-- Page Content -->
	<div class="container">
		<!-- Page Heading/Breadcrumbs -->
		<h1 class="my-2 mb-3">
			펜션소식 <small style='font-size: 60%;'>이용후기</small>
		</h1>

		<ol class="breadcrumb">
			<li class="breadcrumb-item">메인</li>
			<li class="breadcrumb-item active">이용후기</li>
		</ol>

		<div class='row' style='margin-bottom: 40px'>
			<div class='col-md-12'>
				<!-- 게시글 등록 전 fileCheck()메소드를 통해 파일 크기 제한 -->
				<form method='post' action='board_review_write.jsp' enctype='multipart/form-data' name='form' onsubmit='return fileCheck(document.form.file);'>
					<table class='table'>
						<tr>
							<td class='title'>번호</td>
							<td class='two' style='vertical-align: middle'>신규(insert)<input type='hidden' name='key' value='INSERT'></td>
						</tr>
						<tr>
							<td>제목</td>
							<td class='two' style='vertical-align: middle'><input type='text' name='title' style="width: 100%" required maxlength='20'></td>
						</tr>
						<tr>
							<td>일자</td>
							<td class='two' style='vertical-align: middle'>
								<%
									java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
									String today = formatter.format(new java.util.Date());
									out.println(today);
								%>
							</td>
						</tr>
						<tr>
							<td>내용</td>
							<!-- open Editor 사용하기(summernote) -->
							<td class='two' style='vertical-align: middle'>
								<textarea name='content' id='content' required></textarea> 
									<script type="text/javascript">
										$('#content').summernote({
											height : 300,
											popover : false
										});
									</script>
							</td>
						</tr>
						<tr>
							<td>파일</td>
							<td class='two' style='vertical-align: middle'>
								<input type='file' id='upload' name='file'><br>
								<!-- 업로드한 파일 미리보기용 div -->
								<div id='preview' style='width: 200px; max-width: 200px;'></div>
							</td>
						</tr>
						<tr>
							<td colspan='2' id='button' style='text-align: right'>
								<input class="btn btn-outline-dark" type='button' value='취소' onclick="location.href='board_review_list.jsp'"> 
								<input class="btn btn-outline-primary" type='submit' value='쓰기'>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<!-- 파일 업로드 시 미리보기를 위한 script -->
		<script>
			var upload = document.querySelector('#upload');
			var preview = document.querySelector('#preview');

			// file이 선택될 때 Liestener를 통해 function 실행
			upload.addEventListener('change', function(e) {
				var get_file = e.target.files;
				
				// 선택한 파일을 바꾸고 새로운 파일이 선택됐을 때 태그를 그대로 유지해줌
				var image = null;
				if (document.getElementById("img_id")) { // 이미 img_id라는 id값이 있는 경우
					image = document.getElementById("img_id");
				} else { // 없는 경우 img 태그 만들어주기
					image = document.createElement('img');
				}
				
				image.style = "width:200px; max-width:200px;";
				image.id = "img_id";
				
				/* FileReader 객체 생성 */
				var reader = new FileReader();
				
				reader.onload = (function(aImg) {
					console.log(1);

					return function(e) {
						console.log(3);
						aImg.src = e.target.result;
					}
				})(image)

				if (get_file) {
					reader.readAsDataURL(get_file[0]);
					console.log(2);
				}
				
				// 미리보기용 div에 이미지 넣기
				preview.appendChild(image);

			})
		</script>
	</div>

	<!-- Bootstrap core JavaScript -->
	<script src="../vendor/jquery/jquery.min.js"></script>
	<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>