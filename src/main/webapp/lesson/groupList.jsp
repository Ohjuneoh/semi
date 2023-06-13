<%@page import="dto.Pagination"%>
<%@page import="dao.GroupeLessonDao"%>
<%@page import="vo.Lesson"%>
<%@page import="java.util.List"%>
<%

	// 로그인정보 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");

	// 오류상황 - html에서 구현 (등록버튼 표현)
		// 로그인이 되지 않았을 경우
		// 로그인 타입이 강사가 아닌경우 
		
	// 페이징처리 
	int pageNo = StringUtils.stringToInt(request.getParameter("page"),1);
	
	GroupeLessonDao groupLessonDao = GroupeLessonDao.getinstance();
	int totalRows = groupLessonDao.getTotalRows();
	
	Pagination pagination = new Pagination(pageNo, totalRows);
	
	// 로직수행 (레슨 전체조회)
	List<Lesson> lessonList = groupLessonDao.getGroupLessons(pagination.getBegin(), pagination.getEnd());
	
	

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
	<jsp:param name="menu" value="그룹전체"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">그룹수업 목록</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>그룹수업 목록을 확인할 수 있습니다.</p>
			
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
						<th>강좌번호</th>
						<th>강좌명</th>
						<th>강사명</th>
						<th>강좌시간</th>
						<th>헬스장명</th>
					</tr>
				</thead>
				<tbody>
				
<% for (Lesson lesson : lessonList) { %>
					<tr>
						<td><%=lesson.getNo() %></td>
						<td><a href="groupDetailLesson.jsp?no=<%=lesson.getNo() %>"><%=lesson.getName() %></a></td>
						<td><%=lesson.getUser().getName() %></td>
						<td><%=lesson.getTime() %></td>
						<td><%=lesson.getGym().getName() %></td>
					</tr>
<% } %>
				</tbody>
			</table>
			<div class="row mb-3">
		<div class="col-12">
			<nav>
				<ul class="pagination justify-content-center">
					<li class="page-item <%=pageNo <= 1 ? "disabled" : "" %>">
						<a href="groupList.jsp?page=<%=pageNo -1 %>"class="page-link">이전</a>
					</li>
<%
	for(int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
					<li class="page-item <%=pageNo == num ? "active" : "" %>">
						<a href="groupList.jsp?page=<%=num%>"class="page-link"><%=num %></a>
					</li>
<% 
	}
%>
					<li class="page-item <%=pageNo >= pagination.getTotalPages() ? "disabled" : "" %>">
						<a href="groupList.jsp?page=<%=pageNo + 1 %>"class="page-link">다음</a>
					</li>
				</ul>
			</nav>
		</div>
	</div>
			<div class="text-end">
<% if(loginId != null && "trainer".equals(loginType)) { %>			
				<a href="groupForm.jsp" class="btn btn-primary btn-sm">새 수업 등록</a>
<% } %>

			</div>

		</div>
	</div>
</div>
</body>
</html>