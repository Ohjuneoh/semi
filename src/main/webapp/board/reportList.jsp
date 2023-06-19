<%@page import="java.net.URLEncoder"%>
<%@page import="dto.Pagination"%>
<%@page import="dao.CommentDao"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@page import="java.util.List"%>
<%@page import="util.StringUtils"%>
<%@page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String)session.getAttribute("loginId");
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("신고 게시판 조회", "utf-8"));
		return;
	}
	
	String loginType = (String)session.getAttribute("loginType");
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
<style type="text/css">
	.btn.btn-xs {--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;}
</style>
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name="menu" value="게시판"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">신고 게시글 목록</h1>
		</div>
<%
	String err = request.getParameter("err");

	if("invalid".equals(err)) {
%>
	<div class="alert alert-danger">
		<strong>잘못된 접근</strong> 정상적인 URL이 아닙니다.
	</div>
<%
	}
%>
	</div>
	<div class="row mb-3">
		<div class="col-12">		
			<table class="table table-sm">
				<colgroup>
					<col width="10%">
					<col width="45%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
<%
	int pageNo = StringUtils.stringToInt(request.getParameter("page"), 1);
	BoardDao boardDao = BoardDao.getInstance();
	int totalReportPage = boardDao.totalReportPage();	
	Pagination pagination = new Pagination(pageNo, totalReportPage);	
	int begin = pagination.getBegin();
	int end = pagination.getEnd();	
	List<Board> reports = boardDao.getReportBoards(begin, end);
	
	if(totalReportPage == 0) {

%>
					<tr>
						<td colspan="4" style="color: gray">신고내역이 존재하지 않습니다.</td>
					</tr>
<%
	}
	
	for(Board report : reports) {
%>
					<tr>
						<td><%=report.getNo() %></td>
						<td><a href="reportDetail.jsp?boardNo=<%=report.getNo() %>"><%=report.getTitle() %></a></td>
						<td><%=report.getUser().getId() %></td>
						<td><%=report.getCreateDate() %></td>
					</tr>
<%
	}
%>
				</tbody>
			</table>
<%
	if(totalReportPage != 0) {
%>
			<div class="row mb-3">
				<div class="col-12">
					<nav>
						<ul class="pagination justify-content-center">
							<li class="page-item <%=pageNo <= 1 ? "disabled" : "" %>">
								<a class="page-link" href="<%=pageNo - 1 %>">이전</a>
							</li>
<%
		for(int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
							<li class="page-item <%=num == pageNo ? "active" : "" %>">
								<a class="page-link" href="reportList.jsp?page=<%=num %>"><%=num %></a>
							</li>
<%
		}
%>					
							<li class="page-item <%=pageNo >= pagination.getTotalPages() ? "disabled" : "" %>">
								<a class="page-link" href="<%=pageNo + 1 %>">다음</a>
							</li>
						</ul>
					</nav>
				</div>
			</div>
<%
	}
%>
		</div>
	</div>
</div>
</body>
</html>