<%@page import="dto.Pagination"%>
<%@page import="dao.CommentDao"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@page import="java.util.List"%>
<%@page import="util.StringUtils"%>
<%@page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	BoardDao boardDao = BoardDao.getInstance();
	CommentDao commentDao = CommentDao.getInstance();
	String cat = "deal";
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
<style type="text/css">
	.btn.btn-xs {--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;}
</style>
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name="menu" value="커뮤니티"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<p>거래 게시판</p>
			<ul class="nav nav-tabs mb-3">
           		<li class="nav-item"><a class="nav-link " href="list.jsp">전체</a></li>
           		<li class="nav-item"><a class="nav-link" href="chatList.jsp">잡담</a></li>
           		<li class="nav-item"><a class="nav-link" href="infoList.jsp">정보</a></li>
           		<li class="nav-item"><a class="nav-link active" href="dealList.jsp">거래</a></li>
			</ul>

		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">게시글 목록</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">		
			<table class="table table-sm">
				<colgroup>
					<col width="10%">
					<col width="45%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>리뷰갯수</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
<%
	List<Board> notices = boardDao.getNoticesByCat(cat);
	for(Board notice : notices) {
		int commentCnt = commentDao.getCommentCnt(notice.getNo());
%>
					<tr style="background-color:LightGray; font-weight: bold; color: white">
						<td><%=notice.getNo() %></td>
						<td><a href="detail.jsp?boardNo=<%=notice.getNo()%>" class="text-white text-decoration-none"><%=notice.getTitle() %></a></td>
						<td>
							<%=notice.getUser().getId() %>
							<span class="badge rounded-pill text-bg-warning">관리자</span>
						</td>
						<td><%=commentCnt %></td>
						<td><%=notice.getCreateDate() %></td>
					</tr>
<%
	}

	int pageNo = StringUtils.stringToInt(request.getParameter("page"), 1);	
	int totalPage = boardDao.totalPageByCat(cat);	
	Pagination pagination = new Pagination(pageNo, totalPage);	
	int begin = pagination.getBegin();
	int end = pagination.getEnd();
	List<Board> boards = boardDao.getBoardsByCat(cat, begin, end);
	
	if(totalPage == 0 && notices.isEmpty()) {
%>
					<tr>
						<td colspan="5" style="color: gray; text-align: center;">게시글이 존재하지 않습니다.</td>
					</tr>
<%
	}

	for(Board board : boards) {
		int commentCnt = commentDao.getCommentCnt(board.getNo());
%>
					<tr>
						<td><%=board.getNo() %></td>
						<td><a href="detail.jsp?boardNo=<%=board.getNo()%>" class="text-black text-decoration-none"><%=board.getTitle() %></a></td>
						<td><%=board.getUser().getId() %></td>
						<td><%=commentCnt %></td>
						<td><%=board.getCreateDate() %></td>
					</tr>
<%
	}
%>
				</tbody>
			</table>
<%
	if(totalPage != 0) {
%>
			<div class="row mb-3">
				<div class="col-12">
					<nav>
						<ul class="pagination justify-content-center">
							<li class="page-item <%=pageNo <= 1 ? "disabled" : "" %>">
								<a class="page-link" href="dealList.jsp?page=<%=pageNo - 1 %>">이전</a>
							</li>
<%
		for(int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
							<li class="page-item <%=num == pageNo ? "active" : "" %>">
								<a class="page-link" href="dealList.jsp?page=<%=num %>"><%=num %></a>
							</li>
<%
		}
%>					
							<li class="page-item <%=pageNo >= pagination.getTotalPages() ? "disabled" : "" %>">
								<a class="page-link" href="dealList.jsp?page=<%=pageNo + 1 %>">다음</a>
							</li>
						</ul>
					</nav>
				</div>
			</div>
<%
	}
	
	String loginId = (String) session.getAttribute("loginId");
	if (loginId != null) {
%>	
		<div class="text-end">
			<a href="form.jsp" class="btn btn-primary btn-sm">새 게시글 등록</a>
			<input type="hidden" name="category" value="deal">
		</div>
<%
	}
%>
	</div>
	</div>
</div>
</body>
</html>