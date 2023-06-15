<%@page import="vo.User"%>
<%@page import="vo.ReportHistory"%>
<%@page import="dao.BoardDao"%>
<%@page import="vo.Board"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("게시글 신고", "utf-8"));
		return;
	}

	int boardNo = 0;
	try {
		boardNo = Integer.parseInt(request.getParameter("boardNo"));
	} catch(NumberFormatException num) {
		response.sendRedirect("list.jsp?err=invalid");
		return;
	}
	
	String reportContent = request.getParameter("report");
	if(reportContent == null) {
		response.sendRedirect("detail.jsp?boardNo=" + boardNo + "&err=reportNull");
		return;
	}
	
	BoardDao boardDao = BoardDao.getInstance();
	ReportHistory repHistory = boardDao.getReportHistoryByNoId(boardNo, loginId);	
	if(repHistory != null) {
		response.sendRedirect("detail.jsp?boardNo=" + boardNo + "&err=overlap");
		return;
	}
	
	Board board = boardDao.getBoardByNo(boardNo);
	if(loginId.equals(board.getUser().getId())) {
		response.sendRedirect("detail.jsp?boardNo=" + boardNo + "&err=yourBoard");
		return;
	}

	if("manager".equals(board.getType())) {
		response.sendRedirect("detail.jsp?boardNo=" + boardNo + "&err=notice");
		return;
	}
	
	ReportHistory rep = new ReportHistory();
	rep.setBoard(new Board(boardNo));
	rep.setUser(new User(loginId));								// 신고한 유저 아이디
	rep.setReportUser(new User(board.getUser().getId()));		// 신고당한 유저 아이디
	rep.setContent(reportContent);
	
	boardDao.insertReportHistory(rep);
	
	response.sendRedirect("list.jsp");
%>