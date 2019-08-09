<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="onResort.service.Review_boardService"%>
<%@ page import="onResort.service.Review_boardServiceImpl"%>
<%@ page import="onResort.dto.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <!-- 모바일 넓이에 맞게 출력되도록 하는 태그 -->
<meta name="description" content="">
<meta name="author" content="">
<title>onResort</title>
</head>
<body>
	<%
		// service 사용을 위해 선언
		Review_boardService reviewService = new Review_boardServiceImpl();
		// insert에서 넘어온 파라미터 처리용 변수들
		String key = "";
		String title = "";
		String content = "";
		String fileName = "";
		String orgfileName = "";

		String uploadPath = request.getRealPath("upload"); // 업로드할 경로 설정

		try {
			// MultipartRequest를 통해 파일 업로드 처리
			MultipartRequest multi = new MultipartRequest(request, uploadPath, 10 * 1024 * 1024, "utf-8",
					new DefaultFileRenamePolicy()); // 파일 이름 중복 처리

			// 넘어온 파라미터 세팅
			key = multi.getParameter("key"); // 
			title = multi.getParameter("title");
			content = multi.getParameter("content");

			// key가 INSERT이면
			if (key.equals("INSERT")) {
				// 파일이름 세팅
				fileName = multi.getFilesystemName("file");
				orgfileName = multi.getOriginalFileName("file");
				// 받아온 값으로 dto 세팅
				Review_boardDto dto = new Review_boardDto(title, content, fileName, orgfileName);
				reviewService.insert(dto); // dto로 insert
				int n = reviewService.selectOneLastest(); // insert 후 바로 해당 게시글 보기 위해 최신 id 불러오기
				key = Integer.toString(n); 
			}
		} catch (Exception e) {
			e.getStackTrace();
			System.out.println(e);
		}
		// 불러온 key를 이용해서 해당 페이지로 redirect
		response.sendRedirect("board_review_view.jsp?key=" + key);
	%>
</body>
</html>
