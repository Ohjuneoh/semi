<%@page import="vo.User"%>
<%@page import="vo.LikeDisLike"%>
<%@page import="dao.LikeDisLikeDao"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("게시글 평가", "utf-8"));
		return;
	}

	int boardNo = 0;
	try{
		boardNo = Integer.parseInt(request.getParameter("boardNo"));
	} catch(NumberFormatException num) {
		response.sendRedirect("list.jsp?err=invalid");
		return;
	}
	
	BoardDao boardDao = BoardDao.getInstance();
	Board board = boardDao.getBoardByNo(boardNo);
	if(!"N".equals(board.getDeleted())) {
		response.sendRedirect("list.jsp?err=deleteBoard");
		return;
	}
	
	String type = request.getParameter("type");
	LikeDisLikeDao likeDislikeDao = LikeDisLikeDao.getInstance();	
	LikeDisLike likeDislike = likeDislikeDao.getLikeDisLikeByNoId(boardNo, loginId);	
	
	if(likeDislike != null && type.equals(likeDislike.getType())) {
		likeDislikeDao.deleteLikeDisLikeByNOId(boardNo, loginId);	
		response.sendRedirect("detail.jsp?boardNo=" + boardNo);
		return;
	} else if(likeDislike != null && !type.equals(likeDislike.getType())) {
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