<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="onResort.service.Review_boardService"%>
<%@ page import="onResort.service.Review_boardServiceImpl"%>
<%@ page import="onResort.dto.*"%>
<%@ page import="java.util.List"%>
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
		<div class='row'>
			<div class='col-md-12'>
				<%
					// list에서 넘어온 key값으로 조회수 update, selectOne 해오기
					String key = request.getParameter("key");
					Review_boardService reviewService = new Review_boardServiceImpl();
					reviewService.updateViewcnt(Integer.parseInt(key));
					Review_boardDto reviewdto = reviewService.selectOne(Integer.parseInt(key));
					// 제목 출력부에 태그가 들어있을 경우 변환해서 보여주기
					String replaced_title = reviewdto.getTitle();
					if (replaced_title.contains("<")) {
						replaced_title = replaced_title.replace("<", "&lt;");
					}
					if (replaced_title.contains(">")) {
						replaced_title = replaced_title.replace(">", "&gt;");
					}
					if (replaced_title.contains(" ")) {
						replaced_title = replaced_title.replace(" ", "&nbsp;");
					}
				%>
				<form method='post' enctype='multipart/form-data'>
					<table class='table'>
						<tr>
							<td>번호</td>
							<td class='two'><input type='text' name='key' id='key' style='border: 0' value='<%=reviewdto.getId()%>' readonly></td>
						</tr>
						<tr>
							<td>제목</td>
							<td class='two'><%=replaced_title %></td>

						</tr>
						<tr>
							<td>일자</td>
							<td class='two'><%=reviewdto.getDayOfRegister()%></td>
						</tr>
						<tr>
							<td>조회</td>
							<td class='two'><%=reviewdto.getViewcnt()%></td>
						</tr>
						<tr>
							<td>내용</td>
							<td class='two'><%=reviewdto.getContent()%></td>
						</tr>
						<tr>
							<td>파일</td>
							<td class='two'>
								<%
									// 파일 이름이 있으면 파일 이름 출력하고 링크 달아서 다운로드 가능하게 하기
									if (reviewdto.getImgname() != null) {
								%> <a href="../upload/<%=reviewdto.getImgname()%>" download><%=reviewdto.getOrgimgname()%></a> 
								<%
									// 파일 이름이 없으면 파일없음으로 출력
 									} else {
 								%> 파일 없음 
 								<%
								 	}
 								%>
							</td>
						</tr>
						<tr>
							<td class='two' colspan='2' id='button' style='text-align: right'>
								<input type='button' class='btn btn-outline-primary' value='목록' onclick="location.href='board_review_list.jsp'"> 
							<%
								// 세션 체크해서 있으면 관리자가 수정,삭제,답글 기능을 사용할 수 있도록 버튼 보이기
 								String loginOK = null;

 								loginOK = (String) session.getAttribute("login_ok");
 								if (loginOK != null && loginOK.equals("yes")) {
 							%>
 								<input class='btn btn-outline-primary' type='submit' value='수정' formaction='board_review_update.jsp'> 
 								<input class='btn btn-outline-primary' type='button' value='삭제' onclick="location.href='board_review_delete.jsp?key=<%=reviewdto.getId()%>'"> 
 								<input class='btn btn-outline-primary' type='submit' value='답글' formaction='board_review_reinsert.jsp'> 
 							<%
 								}
 							%>
 							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<!-- Bootstrap core JavaScript -->
	<script src="../vendor/jquery/jquery.min.js"></script>
	<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>