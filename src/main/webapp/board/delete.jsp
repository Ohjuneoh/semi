<%@page import="java.util.Date"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	BoardDao boardDao = BoardDao.getInstance();
	Board board = boardDao.getBoardByNo(boardNo);

	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("게시글 삭제", "utf-8"));
		return;
	}
	
	if(!loginId.equals(board.getUser().getId())) {
		response.sendRedirect("detail.jsp?boardNo=" + boardNo + "&err=delete&job=" + URLEncoder.encode("게시글 삭제", "utf-8"));
		return;
	}
	
	board.setDeleted("Y");
	boardDao.updateBoard(board);
	
	response.sendRedirect("list.jsp");
%>