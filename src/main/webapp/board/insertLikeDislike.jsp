<%@page import="vo.User"%>
<%@page import="vo.LikeDisLike"%>
<%@page import="dao.LikeDisLikeDao"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String type = request.getParameter("type");
	
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("게시글 보기", "utf-8"));
		return;
	}
	
	BoardDao boardDao = BoardDao.getInstance();
	Board board = boardDao.getBoardByNo(boardNo);
	
	if(!"N".equals(board.getDeleted())) {
		response.sendRedirect("list.jsp?err=deleteBoard");
		return;
	}
	
	LikeDisLikeDao likeDislikeDao = LikeDisLikeDao.getInstance();	
	LikeDisLike likeDislike = likeDislikeDao.getLikeDisLikeByNoId(boardNo, loginId);
	
	if(likeDislike != null) {
		response.sendRedirect("detail.jsp?boardNo=" + boardNo + "&err=likeDislike");
		return;
	}
	
	LikeDisLike saveLikeDislike = new LikeDisLike();
	saveLikeDislike.setBoard(new Board(boardNo));
	saveLikeDislike.setUser(new User(loginId));
	saveLikeDislike.setType(type);
	
	likeDislikeDao.insertLikeDisLike(saveLikeDislike);
		
	response.sendRedirect("detail.jsp?boardNo=" + boardNo);
%>