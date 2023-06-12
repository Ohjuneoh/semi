<%@page import="dao.CommentDao"%>
<%@page import="vo.User"%>
<%@page import="vo.Board"%>
<%@page import="vo.Comment"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String content = request.getParameter("content");
	
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("댓글쓰기", "utf-8"));
		return;
	}
	
	Comment comment = new Comment();
	comment.setBoard(new Board(boardNo));
	comment.setContent(content);
	comment.setUser(new User(loginId));
	
	CommentDao commentDao = CommentDao.getInstance();
	commentDao.insertComment(comment);
	
	response.sendRedirect("../board/detail.jsp?boardNo=" + boardNo);
%>