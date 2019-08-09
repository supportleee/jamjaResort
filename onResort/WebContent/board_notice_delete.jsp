<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="onResort.service.NoticeService"%>
<%@ page import="onResort.service.NoticeServiceImpl"%>
<%@ page import="onResort.dto.*"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>onResort</title>
</head>
<body>
	<%	
		// 파라미터로 넘어온 key값 받기
		String key = request.getParameter("key");
		// delete를 위한 service 사용을 위해 선언
		NoticeService noticeService = new NoticeServiceImpl();
		
		// 글 삭제 시 파일도 같이 삭제하기 위해 key로 selectOne해서 이미지 이름 얻기
		NoticeDto n = noticeService.selectOne(Integer.parseInt(key));
		String fileUrl = "upload/" + n.getImgname();
		if (fileUrl == null) // 이미지가 없으면 그냥 넘어가기
			return;
		
		boolean fileexists = true;
		try {
			// fileUrl을 이용해서 file 세팅
			ServletContext cxt = getServletConfig().getServletContext();
			String file = cxt.getRealPath(fileUrl);
			File fileEx = new File(file);
			if (fileEx.exists()) { // 파일이 존재하면
				fileEx.delete(); // 파일 지우기
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 파일 삭제 후 게시글 지우기
		noticeService.delete(Integer.parseInt(key));
		response.sendRedirect("board_notice_list.jsp"); // 게시글 삭제 후 게시글 목록으로 이동
	%>
</body>
</html>
