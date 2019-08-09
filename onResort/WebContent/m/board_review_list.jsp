<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="onResort.service.Review_boardService"%>
<%@ page import="onResort.service.Review_boardServiceImpl"%>
<%@ page import="onResort.dto.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
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
<style>
.table {
	table-layout: fixed; /* 테이블의 각 행과 열이 고정되도록 함 */
}

.table .title {
	width: 40vw;
	white-space: nowrap; /* 내용이 길어 넘어갈 경우 줄바꿈하지 않도록 함 */
	overflow: hidden; /* 내용이 넘어갈 경우 숨기기 */
	text-overflow: ellipsis; /*내용이 넘어갈 경우 ...으로 표시 */
	padding-right: .75rem;
	text-align: left;
}

.table td, .table th {
	vertical-align: middle;
	text-align: center;
	padding-top: .75rem;
	padding-bottom: .75rem;
	padding-left: 0;
	padding-right: 0;
	padding-top: .75rem;
}
</style>
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
					Review_boardService reviewService = new Review_boardServiceImpl(); // service를 사용하기 위해 선언
					List<Review_boardDto> reviews = reviewService.selectAll(); // 모든 값 select해오기
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
					} else { // 파라미터가 있을 때
						fromPT = Integer.parseInt(fromString);
						pageCnt = Integer.parseInt(cntString);
					}
					totCnt = reviews.size();
					totalPage = totCnt / pageCnt + (totCnt % pageCnt == 0 ? 0 : 1);
				%>
				<table class="table table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th style='width: 50vw'>제목</th>
							<th>조회</th>
							<th>등록일</th>
						</tr>
					<thead>
					<tbody>
						<%
							// 받아온 리스트 사이즈만큼 실행
							for (Review_boardDto item : reviews) {
								// 출력해야할 부분이 아직 안왔으면 반복문 실행하지 않고 지나감
								if (LineCnt < fromPT) {
									LineCnt++;
									continue;
								}
								// 출력해야할 부분이 지나면 반복문 탈출
								if (LineCnt > fromPT + pageCnt - 1)
									break;
								// 제목 출력부에 태그가 들어있을 경우 변환해서 보여주기
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
						%>
						<tr>
							<td class='num'><%=item.getId()%></td>
							
							<td class='title'><a href="board_review_view.jsp?key=<%=item.getId()%>"> 
							<% 
								// 답글일 경우 글 앞에 공백과 re를 붙여줘야 함
								String title = "";
									if (item.getRelevel() > 0) { // relevel이 0보다 크면 답글이라는 의미
										for (int i = 0; i < item.getRelevel(); i++) {
											// 답글 수준만큼 빈칸 넣어줌
											title += "&nbsp;&nbsp;&nbsp;";
										}
										out.println(title); // 완성된 빈칸 출력
							%> 
								<img src='../image/re_icon.gif'>&nbsp;
							<%
									}
								out.println(replaced_title);
								
								// 날짜가 오늘 날짜와 같으면 N 표시 해주기
								if(date.format(item.getDayOfRegister()).equals(date.format(new Date()))) {
							%>
								&nbsp;<img src='../image/new.png'> 
							<%
								}
							%></a></td>
							<td><%=item.getViewcnt()%></td>
							<td><%=item.getDayOfRegister()%></td>
						</tr>
					</tbody>
						<%
						LineCnt++;
							}
						%>
					<tr>
						<td id='button_cell' colspan='4' style='text-align: right'>
						<input type='button' value='신규' class="btn btn-outline-primary" onclick="location.href='board_review_insert.jsp'">
						</td>
					</tr>
				</table>
				
				<!-- 페이지 표시하는 부분 -->
				<div id='pageNum' style='margin-bottom: 16px; text-align: center'>
					<%
						// pageGroup보다 시작번호가 큰 경우 <<, < 버튼 넣어주기
						if (startPageNum - pageGroup > 0) {
					%>
					<a class='a' href='?pageNo=1&from=1&cnt=<%=pageCnt%>'>&lt;&lt;</a>&nbsp; 
					<a class='a' href='?pageNo=<%=(startPageNum - 1)%>&from=<%=((startPageNum - 2) * pageCnt + 1)%>&cnt=<%=pageCnt%>'>&lt;</a>&nbsp;

					<%
						}
						// 페이지 그룹 만들어주기
						for (int i = startPageNum; i < endPageNum; i++) {
							if (i <= totalPage) {
								// 눌린 페이지가 아닌 경우
								if (i != currentPage) {
					%>
					<a class='a' href='?pageNo=<%=i%>&from=<%=((i - 1) * pageCnt + 1)%>&cnt=<%=pageCnt%>'><%=i%></a>&nbsp;
					<%
						// 눌린 페이지일 경우 링크 빼기
						} else {
					%>
					<b><%=i%></b>&nbsp;
					<%
						}
							}
						}
						// 전체 페이지보다 페이지그룹의 마지막번호가 작으면 >, >> 넣어주기
						if (endPageNum <= totalPage) {
					%>
					<a class='a' href='?pageNo=<%=endPageNum%>&from=<%=((endPageNum - 1) * pageCnt + 1)%>&cnt=<%=pageCnt%>'>&gt;</a>&nbsp; 
					<a class='a' href='?pageNo=<%=totalPage%>&from=<%=((totalPage - 1) * pageCnt + 1)%>&cnt=<%=pageCnt%>'>&gt;&gt;</a>&nbsp;
					<%
						}
					%>
				</div>
			</div>

		</div>
	</div>


	<!-- Bootstrap core JavaScript -->
	<script src="../vendor/jquery/jquery.min.js"></script>
	<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>