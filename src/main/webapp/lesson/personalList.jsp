<%@page import="vo.Lesson"%>
<%@page import="dto.Pagination"%>
<%@page import="dao.PersonalLessonDao"%>
<%@page import="java.util.List"%>
<%@page import="util.StringUtils"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 요청 URL- http://localhost/semi/personalList.jsp
	int pageNo = StringUtils.stringToInt(request.getParameter("page"), 1);

	PersonalLessonDao lessonDao =PersonalLessonDao.getinstance();
	// 전체 데이터 갯수 조회하기
	int totalRows =lessonDao.getTotalRows();
	
	Pagination pagination = new Pagination(pageNo, totalRows);
	
	// 데이터 조회하기
	List<Lesson> lessonList =lessonDao.getPersonalLesson(pagination.getBegin(), pagination.getEnd());
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
	<jsp:param name="menu" value="개인레슨"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">개인수업 목록</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>개인수업 목록을 확인하세요</p>
			
			<table class="table table-sm">
				<colgroup>
					<col width="10%">
					<col width="15%">
					<col width="15%">
					<col width="35%">
					<col width="10%">
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
	for(Lesson lesson: lessonList){	
%>		
					<tr>
						<td><%=lesson.getNo() %></td>
						<td><a href="personalDetailLesson.jsp?no=<%=lesson.getNo() %>"><%=lesson.getName() %></a></td>
						<td><%=lesson.getUser().getName() %></td>
						<td><%=lesson.getTime() %></td>
						<td><%=lesson.getGym().getName() %></td>
					</tr>
<%
	}
%>					
				</tbody>
			</table>
			<nav>
				<ul class="pagination justify-content-center">
					<li class="page-item <%=pageNo <= 1 ? "disabled" : ""%>">
						<a href="personalList.jsp?page=<%=pageNo - 1 %>" class="page-link">이전</a>
					</li>
<%
	for(int num = pagination.getBeginPage(); num<=pagination.getEndPage(); num++){
%>					
					
					<li class="page-item <%=pageNo == num ? "active" : ""%>">
						<a href="personalList.jsp?page=<%=num %>"class="page-link"><%=num %></a>
					</li>
<%
	}
%>					
				
					
					<li class="page-item <%=pageNo >= pagination.getTotalPages() ? "disabled" : "" %>">
						<a href="personalList.jsp?page=<%=pageNo + 1 %>"class="page-link">다음</a>
					</li>
				</ul>
			</nav>
			
			<div class="text-end">
				<a href="personalForm.jsp" class="btn btn-primary btn-sm">새 수업 등록</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>