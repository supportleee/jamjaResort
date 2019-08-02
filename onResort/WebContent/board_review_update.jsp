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
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/modern-business.css" rel="stylesheet">

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<script>
	$(document).ready(function() {
		$('#header').load('header.html');
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
			펜션소식 <small>이용후기</small>
		</h1>

		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.html">메인</a></li>
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
				<script>
					function deleteFile() {
						$('#file')
								.html(
										"<input type='file' id='upload' name='file'><br><div id='preview' style='width: 200px; max-width: 200px;'></div>");

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

					}
				</script>
				<script>
				function replaceChar() {
					var content = '<%=reviewdto.getContent()%>';
					console.log(content);
					var con = document.getElementById('content');
					con.value = content;
				}
				</script>
				<form method='post' action='board_review_write.jsp'
					enctype='multipart/form-data'>
					<table class='table'>
						<tr>
							<td>번호</td>
							<td class='two' style='vertical-align: middle'><input
								type='text' name='key' id='key' style="border: 0;" readonly
								value='<%=reviewdto.getId()%>'></td>
						</tr>
						<tr>
							<td>제목</td>
							<td class='two' style='vertical-align: middle'><input
								type='text' name='title' style="width: 100%" required
								maxlength='20' value='<%=reviewdto.getTitle()%>'></td>
						</tr>
						<tr>
							<td>일자</td>
							<td class='two' style="vertical-align: middle"><%=reviewdto.getDayOfRegister()%></td>
						</tr>
						<tr>
							<td>내용</td>
							<td class='two' style='vertical-align: middle'><textarea
									cols='50' rows='20' wrap='hard' name='content' id='content'
									required></textarea> <script>replaceChar();</script> <script
									type="text/javascript">
										$('#content').summernote({
											height : 300,
											popover : false
										// 왼쪽 상단에 이상한 버튼 뜨는 거 막아주기
										});
									</script></td>
						</tr>
						<tr>
							<td>파일</td>
							<td style='vertical-align: middle' id='file'>
								<%
									if (reviewdto.getImgname() != null) {
								%> <input type='text' name='filename' style='border: 0'
								value='<%=reviewdto.getOrgimgname()%>' readonly> <input
								type='button' class='btn btn-outline-dark' value='X'
								onclick='deleteFile()'> <%
 	} else {
 %> <input type='file' id='upload' name='file'><br>
								<div id='preview' style='width: 200px; max-width: 200px;'></div>
								<%
									}
								%>
							
						</tr>
						<tr>
							<td colspan='2' id='button' style="text-align: right"><input
								type='button' class="btn btn-outline-dark" value='취소'
								onclick="location.href='board_review_list.jsp'"> <input
								type='submit' class="btn btn-outline-primary" value='쓰기'></td>
						</tr>
					</table>
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

	<!-- Footer -->
	<footer class="py-5 bg-dark" id='footer'>
		<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


</body>
</html>
