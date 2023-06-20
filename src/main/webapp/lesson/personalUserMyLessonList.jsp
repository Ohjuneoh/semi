<%@page import="dao.PersonalReservationDao"%>
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
	
	// 오류상황
		// 로그인이 되지 않았을 경우
		// 로그인 타입이 강사가 아닌경우 
	if(loginId == null) {
	response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("개인레슨 조회", "utf-8"));
		return;
	}
	if(!"user".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=trainerdeny&job=" + URLEncoder.encode("개인레슨 조회", "utf-8"));
		return;
	}
		
	// 페이징처리 
	int pageNo = StringUtils.stringToInt(request.getParameter("page"),1);
	
	PersonalReservationDao personalReservationDao = PersonalReservationDao.getInstance();
	int totalRows = personalReservationDao.getAllTotalMyRows(loginId);
	
	Pagination pagination = new Pagination(pageNo, totalRows);
	
	// 로직수행 (신청 조회)
	PersonalReservationDao reserveDao = PersonalReservationDao.getInstance();
	List<Reservation> reserveList = reserveDao.getPersonalMyReservationsById(loginId, pagination.getBegin(), pagination.getEnd());
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
	<jsp:param name="menu" value="마이페이지"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">내 개인레슨 목록</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>내 개인레슨 목록을 확인할 수 있습니다.</p>
			<ul class="nav nav-tabs mb-3">
           		<li class="nav-item"><a class="nav-link" href="/semi/lesson/AllUserMyLessonList.jsp">전체</a></li>
           		<li class="nav-item"><a class="nav-link active" href="/semi/lesson/personalUserMyLessonList.jsp">개인</a></li>
           		<li class="nav-item"><a class="nav-link" href="/semi/lesson/groupUserMyLessonList.jsp">그룹</a></li>
			</ul>
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
						<th>레슨번호</th>
						<th>레슨명</th>
						<th>강사명</th>
						<th>레슨시간</th>
						<th>헬스장명</th>
					</tr>
				</thead>
				<tbody>
				
<% 
	for (Reservation reserve : reserveList) { 
%>
					<tr>
						<td><%=reserve.getLesson().getNo() %></td>
						<td><a href="personalDetailLesson.jsp?lessonNo=<%=reserve.getLesson().getNo() %>"><%=reserve.getLesson().getName() %></a></td>
						<td><%=reserve.getUser().getName() %></td>
						<td><%=reserve.getLesson().getTime() %></td>
						<td><%=reserve.getLesson().getGym().getName() %></td>
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
						<a href="personalUserMyLessonList.jsp?page=<%=pageNo -1 %>"class="page-link">이전</a>
					</li>
<%
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
					<li class="page-item <%=pageNo == num ? "active" : "" %>">
						<a href="personalUserMyLessonList.jsp?page=<%=num%>"class="page-link"><%=num %></a>
					</li>
<% 
	}
%>
					<li class="page-item <%=pageNo >= pagination.getTotalPages() ? "disabled" : "" %>">
						<a href="personalUserMyLessonList.jsp?page=<%=pageNo + 1 %>"class="page-link">다음</a>
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