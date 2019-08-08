<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="onResort.service.Review_boardService"%>
<%@ page import="onResort.service.Review_boardServiceImpl"%>
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
		Review_boardService reviewService = new Review_boardServiceImpl();
		Review_boardDto r = reviewService.selectOne(Integer.parseInt(key));
		String fileUrl = "upload/" + r.getImgname();
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
		reviewService.delete(Integer.parseInt(key));
		response.sendRedirect("board_review_list.jsp");
	%>
</body>
</html>
