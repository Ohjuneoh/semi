<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="vo.Comment"%>
<%@page import="java.util.List"%>
<%@page import="dto.Pagination"%>
<%@page import="util.StringUtils"%>
<%@page import="dao.CommentDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("게시글 보기", "utf-8"));
		return;
	}
	
	CommentDao commentDao = CommentDao.getInstance();
	int boardNo = 0;
	int commentNo = 0;
	try {
		boardNo = Integer.parseInt(request.getParameter("boardNo"));
		commentNo = StringUtils.stringToInt(request.getParameter("comPage"), 1);
	} catch(NumberFormatException num) {
		response.sendRedirect("list.jsp?err=invalid");
		return;
	}
	
	int commentCnt = commentDao.getCommentCnt(boardNo);
	Pagination pagination = new Pagination(commentNo, commentCnt);
	int begin = pagination.getBegin();
	int end = pagination.getEnd();
	List<Comment> comments = commentDao.getComments(boardNo, begin, end);
	
	Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
	String text = gson.toJson(comments);
	out.write(text);
%>