<%@page import="java.net.URLEncoder"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String cat = request.getParameter("category");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	BoardDao boardDao = BoardDao.getInstance();
	Board board = boardDao.getBoardByNo(boardNo);
	
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("게시글 수정", "utf-8"));
		return;
	}
	
	if(!loginId.equals(board.getUser().getId())) {
		response.sendRedirect("detail.jsp?boardNo=" + boardNo + "&err=delete&job=" + URLEncoder.encode("게시글 수정", "utf-8"));
		return;
	}
	
	if(!"N".equals(board.getDeleted())) {
		response.sendRedirect("list.jsp?err=deleteBoard");
		return;
	}
	
	board.setCategory(cat);
	board.setTitle(title);
	board.setContent(content);
	
	boardDao.updateBoard(board);
	
	response.sendRedirect("detail.jsp?boardNo=" + boardNo);
%>