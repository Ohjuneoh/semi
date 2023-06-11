<%@page import="dao.CommentDao"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	String loginType = (String) session.getAttribute("loginType");
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	BoardDao boardDao = BoardDao.getInstance();
	Board board = boardDao.getBoardByNo(boardNo);
	CommentDao commentDao = CommentDao.getInstance();
	int commentCnt = commentDao.getCommentCnt(boardNo);

	if(!"manager".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=managerdeny&job=" + URLEncoder.encode("신고 게시글 조회", "utf-8"));
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
			<h1 class="border bg-light fs-4 p-2">신고 게시글 상세 정보</h1>
		</div>
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
				<button type="button" class="btn btn-outline-primary">복구</button>
				<button type="button" class="btn btn-outline-secondary">삭제</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>