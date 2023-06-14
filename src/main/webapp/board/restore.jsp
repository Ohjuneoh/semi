<%@page import="dao.BoardDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	String loginType = (String) session.getAttribute("loginType");
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("신고 게시글 복구", "utf-8"));
		return;
	}
	
	if(!"manager".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=managerdeny&job=" + URLEncoder.encode("신고 게시글 복구", "utf-8"));
		return;
	}
	
	BoardDao boardDao = BoardDao.getInstance();
	boardDao.deleteReportHistoryByNo(boardNo);
	
	response.sendRedirect("reportList.jsp");
%>