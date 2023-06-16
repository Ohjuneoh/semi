<%@page import="dao.BoardDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("신고 게시글 복구", "utf-8"));
		return;
	}
	
	String loginType = (String) session.getAttribute("loginType");
	if(!"manager".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=managerdeny&job=" + URLEncoder.encode("신고 게시글 복구", "utf-8"));
		return;
	}
	
	int boardNo = 0;
	try {
		boardNo = Integer.parseInt(request.getParameter("boardNo"));
	} catch(NumberFormatException num) {
		response.sendRedirect("reportList.jsp?err=invalid");
		return;
	}
	BoardDao boardDao = BoardDao.getInstance();
	boardDao.deleteReportHistoryByNo(boardNo);
	
	response.sendRedirect("reportList.jsp");
%>