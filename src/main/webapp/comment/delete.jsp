<%@page import="vo.Comment"%>
<%@page import="dao.CommentDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("댓글삭제", "utf-8"));
		return;
	}
	
	int boardNo = 0;
	int comNo = 0;
	try {
		boardNo = Integer.parseInt(request.getParameter("boardNo"));
		comNo = Integer.parseInt(request.getParameter("comNo"));
	} catch(NumberFormatException num) {
		response.sendRedirect("reportList.jsp?err=invalid");
		return;
	}

	CommentDao commentDao = CommentDao.getInstance();
	Comment com = commentDao.getCommentByNo(comNo);
	if(!loginId.equals(com.getUser().getId())) {
		response.sendRedirect("../board/detail.jsp?boardNo=" + boardNo + "&err=delete&job=" + URLEncoder.encode("댓글삭제", "utf-8"));
		return;
	}
	
	commentDao.deleteCommentByNo(comNo);
	
	response.sendRedirect("../board/detail.jsp?boardNo=" + boardNo);
%>