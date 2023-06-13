<%@page import="dao.BoardDao"%>
<%@page import="vo.User"%>
<%@page import="vo.Board"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	String loginType = (String) session.getAttribute("loginType");
	String cat = request.getParameter("category");
	String title = request.getParameter("title");
	String content = request.getParameter("content");

	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("게시글 작성", "utf-8"));
		return;
	}
	
	if(cat == null) {
		response.sendRedirect("form.jsp?err=formcat");
		return;
	}
	
	if(title == null) {
		response.sendRedirect("form.jsp?err=formtitle&job=" + URLEncoder.encode("제목", "utf-8"));
		return;
	}

	if(content == null) {
		response.sendRedirect("form.jsp?err=formcon&job=" + URLEncoder.encode("내용", "utf-8"));
		return;
	}
	
	Board board = new Board();
	board.setCategory(cat);
	board.setTitle(title);
	board.setContent(content);
	board.setType(loginType);
	board.setUser(new User(loginId));
	
	BoardDao boardDao = BoardDao.getInstance();
	boardDao.insertBoard(board);
	
	response.sendRedirect("list.jsp");
%>