<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@page import="util.StringUtils"%>
<%@page import="vo.Reservation"%>
<%@page import="dao.GroupReservationDao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dto.Pagination"%>
<%@page import="dao.GroupLessonDao"%>
<%@page import="vo.Lesson"%>
<%@page import="java.util.List"%>
<%
	// 로그인정보 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");
	
	// 오류사항: 로그인이 되지않았거나, 타입이 강사가아니면 조회불가능
	if(loginId == null) {
	response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("전체 회원조회", "utf-8"));
		return;
	}
	if(!"trainer".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=trainerdeny&job=" + URLEncoder.encode("전체 회원조회", "utf-8"));
		return;
	}
	
	// 페이징처리
	int pageNo = StringUtils.stringToInt(request.getParameter("page"),1);
	
	UserDao userDao = UserDao.getinstance();
	int totalRows = userDao.getTotalUserRows();
	
	Pagination pagination = new Pagination(pageNo, totalRows);
	
	// 로직수행 (User타입 전체조회)
	List<User> userList = userDao.getAllUserByUserType(pagination.getBegin(), pagination.getEnd());
	
%>
<%@page import="util.StringUtils"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
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
	<jsp:param name="menu" value="회원관리" />
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">전체 회원목록</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>전체 회원목록을 확인할 수 있습니다.</p>
			<table class="table table-sm">
				<colgroup>
					<col width="15%">
					<col width="20%">
					<col width="25%">
					<col width="20%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th>회원 이름</th>
						<th>회원 이메일</th>
						<th>회원 전화번호</th>
						<th>가입일</th>
						<th>회원상태</th>
					</tr>
				</thead>
				<tbody>
				
<% 
	for (User user : userList) { 
%>
					<tr>
						<td><a href="../user/userDetail.jsp?userId=<%=user.getId() %>"><%=user.getName() %></a></td>
						<td><%=user.getEmail() %></td>
						<td><%=user.getTel() %></td>
						<td><%=user.getCreateDate() %></td>
<% if ("Y".equals(user.getStatus())) { %>
						<td><a class="btn btn-primary btn-sm">가입중</a></td>
<% } else if ("N".equals(user.getStatus())) { %>
						<td><a class="btn btn-danger btn-sm">탈퇴</a></td>
<% } %>
					</tr>
<% 	
	}
 %>
				</tbody>
			</table>
<% if (totalRows != 0) { %>
			<div class="row mb-3">
		<div class="col-12">
			<nav>
				<ul class="pagination justify-content-center">
					<li class="page-item <%=pageNo <= 1 ? "disabled" : "" %>">
						<a href="groupUserMyLessonList.jsp?page=<%=pageNo -1 %>"class="page-link">이전</a>
					</li>
<%
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
					<li class="page-item <%=pageNo == num ? "active" : "" %>">
						<a href="groupUserMyLessonList.jsp?page=<%=num%>"class="page-link"><%=num %></a>
					</li>
<% 
	}
%>
					<li class="page-item <%=pageNo >= pagination.getTotalPages() ? "disabled" : "" %>">
						<a href="groupUserMyLessonList.jsp?page=<%=pageNo + 1 %>"class="page-link">다음</a>
					</li>
				</ul>
			</nav>
		</div>
	</div>
		</div>
<% } %>
	</div>
</div>
</body>
</html>