<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		String key = request.getParameter("key");
		NoticeService noticeService = new NoticeServiceImpl();
		NoticeDto n = noticeService.selectOne(Integer.parseInt(key));
		String fileUrl = "upload/" + n.getImgname();
		if (fileUrl == null)
			return;

		boolean fileexists = true;
		try {
			ServletContext cxt = getServletConfig().getServletContext();
			String file = cxt.getRealPath(fileUrl);
			File fileEx = new File(file);
			if (fileEx.exists()) {
				fileEx.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		noticeService.delete(Integer.parseInt(key));
		response.sendRedirect("board_notice_list.jsp");
	%>
</body>
</html>
