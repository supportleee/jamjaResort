<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="onResort.service.NoticeService"%>
<%@ page import="onResort.service.NoticeServiceImpl"%>
<%@ page import="onResort.dto.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
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

</head>
<body>
	<!-- Navigation -->
	<div id='header'></div>

	<!-- Page Content -->
	<div class="container">
		<!-- Page Heading/Breadcrumbs -->
		<h1 class="mt-4 mb-3">
			펜션소식 <small>펜션소식</small>
		</h1>

		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.html">메인</a></li>
			<li class="breadcrumb-item active">펜션소식</li>
		</ol>

		<div class='row'>
			<div class='col-md-12'>
				<%
					NoticeService noticeService = new NoticeServiceImpl();
					List<NoticeDto> notices = noticeService.selectAll();
					SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
					int totCnt = 0; // 레코드 전체 수
					int totalPage = 0; // 총 페이지 수
					int pageCnt = 5; // 한 페이지에 보여질 게시물 수
					int pageGroup = 5; // 한 페이지에 보여질 페이지 수
					// 현재 보이는 페이지
					int currentPage = (request.getParameter("pageNo")) == null ? 1
							: Integer.parseInt(request.getParameter("pageNo"));
					// 현재 보이는 페이지 그룹의 시작번호
					int startPageNum = currentPage % pageGroup == 0 ? (currentPage / pageGroup - 1) * pageGroup + 1
							: (currentPage / pageGroup) * pageGroup + 1;
					// 현재 보이는 페이지 그룹의 마지막번호+1
					int endPageNum = startPageNum + pageGroup;
					int LineCnt = 1; // 읽은 줄 수 저장할 변수 선언
					int fromPT = 0; // 시작 카운트

					String fromString = request.getParameter("from");
					String cntString = request.getParameter("cnt");
					// 파라미터가 없을 때
					if (fromString == null && cntString == null) {
						fromPT = 1;
						pageCnt = 5;
					} else {
						fromPT = Integer.parseInt(fromString);
						pageCnt = Integer.parseInt(cntString);
					}
					totCnt = notices.size();
					totalPage = totCnt / pageCnt + (totCnt % pageCnt == 0 ? 0 : 1);
				%>
				<table class="table table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>조회수</th>
							<th>등록일</th>
						</tr>
					<thead>
					<tbody>
						<%
							for (NoticeDto item : notices) {
								if (LineCnt < fromPT) {
									LineCnt++;
									continue;
								}
								if (LineCnt > fromPT + pageCnt - 1)
									break;
								String replaced_title = item.getTitle();
								if(replaced_title.contains("<")){
									replaced_title = replaced_title.replace("<","&lt;");
								}
								if(replaced_title.contains(">")) {
									replaced_title = replaced_title.replace(">","&gt;");
								}
								if(replaced_title.contains(" ")) {
									replaced_title = replaced_title.replace(" ","&nbsp;");
								}
								System.out.println(replaced_title);
						%>
						<tr>
							<td><%=item.getId()%></td>
							<td><a href="board_notice_view.jsp?key=<%=item.getId()%>"><%=replaced_title%>
							
							<%if(date.format(item.getDayOfRegister()).equals(date.format(new Date()))) {
										%>&nbsp;<img src='image/new.png'><%}%></a></td>
							<td><%=item.getViewcnt()%></td>
							<td><%=item.getDayOfRegister()%></td>
						</tr>
					</tbody>
					<%
						LineCnt++;
						}
					%>
					<tr>
						<td id='button_cell' colspan='4' style='text-align: right'><input
							type='button' value='신규' class="btn btn-outline-primary"
							onclick="location.href='board_notice_insert.jsp'"></td>
					</tr>
				</table>
				<div id='pageNum' style='margin-bottom:16px; text-align:center'>
					<%
						if (startPageNum - pageGroup > 0) {
					%>
					<a class='a' href='?pageNo=1&from=1&cnt=<%=pageCnt%>'>&lt;&lt;</a>&nbsp;
					<a class='a'
						href='?pageNo=<%=(startPageNum - 1)%>&from=<%=((startPageNum - 2) * pageCnt + 1)%>&cnt=<%=pageCnt%>'>&lt;</a>&nbsp;

					<%
						}
						for (int i = startPageNum; i < endPageNum; i++) {
							if (i <= totalPage) {
								if (i != currentPage) {
					%>
					<a class='a'
						href='?pageNo=<%=i%>&from=<%=((i - 1) * pageCnt + 1)%>&cnt=<%=pageCnt%>'><%=i%></a>&nbsp;
					<%
						} else {
					%>
					<b><%=i%></b>&nbsp;
					<%
						}
							}
						}
						if (endPageNum <= totalPage) {
					%>
					<a class='a'
						href='?pageNo=<%=endPageNum%>&from=<%=((endPageNum - 1) * pageCnt + 1)%>&cnt=<%=pageCnt%>'>&gt;</a>&nbsp;
					<a class='a'
						href='?pageNo=<%=totalPage%>&from=<%=((totalPage - 1) * pageCnt + 1)%>&cnt=<%=pageCnt%>'>&gt;&gt;</a>&nbsp;
					<%
						}
					%>
				</div>
			</div>

		</div>
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