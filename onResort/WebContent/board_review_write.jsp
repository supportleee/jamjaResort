<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>onResort</title>
</head>
<body>
	<%
		Review_boardService reviewService = new Review_boardServiceImpl();
		String key = "";
		String title = "";
		String content = "";
		String fileName = "";
		String orgfileName = "";

		String uploadPath = request.getRealPath("upload");

		try {
			MultipartRequest multi = new MultipartRequest(request, uploadPath, 10 * 1024 * 1024, "utf-8",
					new DefaultFileRenamePolicy());

			key = multi.getParameter("key");
			title = multi.getParameter("title");
			content = multi.getParameter("content");
			
			if (key.equals("INSERT")) {
				fileName = multi.getFilesystemName("file");
				orgfileName = multi.getOriginalFileName("file");
				Review_boardDto dto = new Review_boardDto(title, content, fileName, orgfileName);
				reviewService.insert(dto);
				int n = reviewService.selectOneLastest();
				key = Integer.toString(n);
			} else if (key.equals("REINSERT")) {
				fileName = multi.getFilesystemName("file");
				orgfileName = multi.getOriginalFileName("file");
				int rootid = Integer.parseInt(multi.getParameter("rootid"));
				int relevel = Integer.parseInt(multi.getParameter("relevel"));
				int recnt = Integer.parseInt(multi.getParameter("recnt"));
				reviewService
						.reinsert(new Review_boardDto(title, content, fileName, orgfileName, rootid, relevel, recnt));
				int n = reviewService.selectOneLastest();
				key = Integer.toString(n);
			} else {
				Review_boardDto r = reviewService.selectOne(Integer.parseInt(key));
				if(multi.getFilesystemName("file")!=null) {
					fileName = multi.getFilesystemName("file");
					orgfileName = multi.getOriginalFileName("file");
				} else {
					fileName = r.getImgname();
					orgfileName = r.getOrgimgname();
				}
				reviewService.update(Integer.parseInt(key),
						new Review_boardDto(title, content, fileName, orgfileName));
			}

		} catch (Exception e) {
			e.getStackTrace();
		}

		response.sendRedirect("board_review_view.jsp?key=" + key);
	%>
</body>
</html>