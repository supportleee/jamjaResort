<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import='java.io.*'%>
<%@ page import='com.oreilly.servlet.*'%>
<%@ page import='com.oreilly.servlet.multipart.*'%>
<%@ page import="onResort.service.Review_boardService"%>
<%@ page import="onResort.service.Review_boardServiceImpl"%>
<%@ page import="onResort.dto.*"%>
<%@ page import="java.util.List"%>
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

<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>


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
			펜션소식 <small>이용후기</small>
		</h1>

		<ol class="breadcrumb">
			<li class="breadcrumb-item">메인</li>
			<li class="breadcrumb-item active">이용후기</li>
		</ol>

		<div class='row'>
			<div class='col-md-12'>
				<%
					String uploadPath = request.getRealPath("upload");
					MultipartRequest multi = new MultipartRequest(request, uploadPath, 10 * 1024 * 1024, "utf-8",
							new DefaultFileRenamePolicy());
					String key = multi.getParameter("key");
					Review_boardService reviewService = new Review_boardServiceImpl();
					Review_boardDto reviewdto = reviewService.selectOne(Integer.parseInt(key));
				%>
				<form method='post' action='board_review_write.jsp'
					enctype='multipart/form-data' name='form' onsubmit='return fileCheck(document.form.file);'>
					<table class='table'>
						<tr>
							<td class='title'>번호</td>
							<td class='two' style='vertical-align: middle'>답글(insert)<input
								type='hidden' name='key' value='REINSERT'></td>
						</tr>
						<tr>
							<td>제목</td>
							<td class='two' style='vertical-align: middle'><input
								type='text' name='title' style="width: 100%" required
								maxlength='20'></td>
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
							<td class='two' style='vertical-align: middle'><textarea
									name='content' id='content' required></textarea> <script
									type="text/javascript">
										$('#content').summernote({
											height : 300,
											popover : false
										});
									</script></td>
						</tr>
						<tr>
							<td>파일</td>
							<td class='two' style='vertical-align: middle'><input
								type='file' id='upload' name='file'><br>
								<div id='preview' style='width: 200px; max-width: 200px;'></div></td>
						</tr>
						<tr>
							<td colspan='2' id='button' style='text-align: right'><input
								class="btn btn-outline-dark" type='button' value='취소'
								onclick="location.href='board_review_list.jsp'"> <input
								class="btn btn-outline-primary" type='submit' value='쓰기'></td>
						</tr>
					</table>
					<input type='hidden' name='rootid'
						value='<%=reviewdto.getRootid()%>'> <input type='hidden'
						name='relevel' value='<%=reviewdto.getRelevel() + 1%>'> <input
						type='hidden' name='recnt' value='<%=reviewdto.getRecnt() + 1%>'>
				</form>
			</div>
		</div>
		<script>
			var upload = document.querySelector('#upload');
			var preview = document.querySelector('#preview');

			upload.addEventListener('change', function(e) {
				var get_file = e.target.files;
				var image = null;
				if (document.getElementById("img_id")) {
					image = document.getElementById("img_id");
				} else {
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

				preview.appendChild(image);

			})
		</script>
	</div>

	<!-- Bootstrap core JavaScript -->
	<script src="../vendor/jquery/jquery.min.js"></script>
	<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>