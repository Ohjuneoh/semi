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
	
	int comNo = 0;
	try {
		comNo = Integer.parseInt(request.getParameter("cno"));
	} catch(NumberFormatException num) {
		response.sendRedirect("list.jsp?err=invalid");
		return;
	}

	CommentDao commentDao = CommentDao.getInstance();
	Comment com = commentDao.getCommentByNo(comNo);
	
	if(!loginId.equals(com.getUser().getId())) {
		out.write("{\"deleted\":false}");
	} else {		
		commentDao.deleteCommentByNo(comNo);
		out.write("{\"deleted\":true}");
	}	
%>