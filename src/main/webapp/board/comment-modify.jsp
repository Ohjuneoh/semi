<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="vo.Comment"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="dao.CommentDao"%>
<%@ page contentType="application/json; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%
	String loginId = (String)session.getAttribute("loginId");
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("댓글수정", "utf-8"));
		return;
	}

	int cno = Integer.parseInt(request.getParameter("cno"));
	CommentDao commentDao = CommentDao.getInstance();
	Comment comm = commentDao.getCommentByNo(cno);
	
	if(!loginId.equals(comm.getUser().getId())) {
		response.sendRedirect("detail.jsp?err=notLoginUser&job=" + URLEncoder.encode("댓글수정", "utf-8"));
		return;
	}
	
	String content = request.getParameter("content");
	comm.setContent(content);
	comm.setUpdateDate(new Date());
	Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
	String newComment = gson.toJson(comm);
	System.out.println(newComment);
	
	out.write(newComment);
%>