<%@page import="dto.Pagination"%>
<%@page import="util.StringUtils"%>
<%@page import="vo.Comment"%>
<%@page import="java.util.List"%>
<%@page import="dao.CommentDao"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	String loginType = (String) session.getAttribute("loginType");
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String err = request.getParameter("err");
	String job = request.getParameter("job");
	
	BoardDao boardDao = BoardDao.getInstance();
	Board board = boardDao.getBoardByNo(boardNo);
	CommentDao commentDao = CommentDao.getInstance();
	int commentCnt = commentDao.getCommentCnt(boardNo);
	List<Comment> comments = commentDao.getComments(boardNo);

	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("게시글 보기", "utf-8"));
		return;
	}
	
	if(!loginId.equals(board.getUser().getId())) {
		board.setViewCnt(board.getViewCnt() + 1);
		boardDao.updateBoard(board);
	}
	
	if(!"N".equals(board.getDeleted())) {
		response.sendRedirect("list.jsp?err=deleteBoard");
		return;
	}
%>
<!doctype html>
<html lang="ko">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name="menu" value="게시글"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<nav class="nav">
  				<a class="nav-link" href="list.jsp">전체</a>
  				<a class="nav-link" href="chatList.jsp">잡담</a>
  				<a class="nav-link" href="infoList.jsp">정보</a>
  				<a class="nav-link" href="dealList.jsp">거래</a>
			</nav>
			<h1 class="border bg-light fs-4 p-2">게시글 상세 정보</h1>
		</div>
<%
	if("delete".equals(err)) {
%>
	<div class="alert alert-danger">
		<strong>잘못된 접근</strong> [<%=job %>]는 작성자만 사용가능한 서비스입니다.
	</div>
<%
	}
%>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<table class="table table-bordered">
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="10%">
					<col width="40%">
				</colgroup>
				<tbody>
					<tr>
						<th class="table-dark">제목</th>
						<td><%=board.getTitle() %></td>
						<th class="table-dark">작성자</th>
						<td><%=board.getUser().getId() %></td>
					</tr>
					<tr>
						<th class="table-dark">조회수</th>
						<td><%=board.getViewCnt() %></td>
						<th class="table-dark">댓글갯수</th>
						<td><%=commentCnt %></td>
					</tr>
					<tr>
						<th class="table-dark">등록일</th>
						<td><%=board.getCreateDate() %></td>
						<th class="table-dark">수정일자</th>
						<td><%=board.getUpdateDate() %></td>
					</tr>
					<tr>
						<th class="table-dark" style="vertical-align: middle;">내용</th>
						<td colspan="3" style="height: 200px"><%=board.getContent() %></td>
					</tr>
				</tbody>
			</table>
			<div class="text-center">
				<button type="button" class="btn btn-outline-primary">좋아요</button>
				<button type="button" class="btn btn-outline-secondary">싫어요</button>
			</div>
			<div class="text-end">
<%
	if(loginId.equals(board.getUser().getId())) {
%>
					<a href="delete.jsp?boardNo=<%=boardNo %>" class="btn btn-danger btn-sm">삭제</a>
					<a href="modifyForm.jsp?boardNo=<%=boardNo %>" class="btn btn-warning btn-sm">수정</a>
<%
	} else {
%>
		<div class="text-end">
			<a href="report.jsp?boardNo=" class="btn btn-danger btn-sm">신고</a>
		</div>
<%
	}
%>
			</div>
		</div>
	</div>
	<div class="row mb-3">
   		<div class="col-12">
			<form class="border bg-light p-2" method="post" action="../comment/insert.jsp">
				<input type="hidden" name="boardNo" value="<%=boardNo %>" />
 				<div class="row">
					<div class="col-11">
						<textarea rows="2" class="form-control" name="content"></textarea>
					</div>
					<div class="col-1">
						<button class="btn btn-outline-primary h-100">등록</button>
					</div>
				</div>
			</form>
   		</div>
   	</div>
<%
	for(Comment comment : comments)  {
%>
   	<div class="row mb-3">
   		<div class="col-12">
   			<div class="border p-2 mb-2">
	   			<div class="d-flex justify-content-between mb-1">
	   				<strong><%=comment.getUser().getId() %>
<%		
		if(board.getUser().getId().equals(comment.getUser().getId())) {
%>
						<span class="badge bg-success" >작성자</span>
<%
		}
%>
	   				</strong>
				</div>
				<div>
					<%=comment.getContent() %>
<%
		if(loginId.equals(comment.getUser().getId())){
%>
					<a href="../comment/delete.jsp?boardNo=<%=boardNo %>&comNo=<%=comment.getNo() %>" 
	   					class="btn btn-link text-danger text-decoration-none float-end"><i class="bi bi-trash"></i></a>
					<a href="../modifyForm.jsp?boardNo=<%=boardNo %>&comNo=<%=comment.getNo() %>" 
	   					class="btn btn-link text-decoration-none float-end"><i class="bi bi-brush-fill"></i></a>
<%
		}
%>
				</div>
			</div>
		</div>
	</div>
<%
	}
%>
</div>
</body>
</html>