<%@page import="java.util.List"%>

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
	<jsp:param name="menu" value="그룹레슨"/>
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
						<th>레슨시간</th>
					</tr>
				</thead>
				<tbody>
			
					<tr>
						<td>xxxx</td>
						<td><a href="detail.jsp?no=">xxx</a></td>
						<td>xxx</td>
						<td>xxx</td>
						<td>xxx</td>
					</tr>
				</tbody>
			</table>
			<div class="row mb-3">
		<div class="col-12">
			<nav>
				<ul class="pagination justify-content-center">
					<li class="page-item"><a class="page-link disabled" href="course-list.jsp?page=1">이전</a></li>
					<li class="page-item"><a class="page-link active" href="course-list.jsp?page=1">1</a></li>
					<li class="page-item"><a class="page-link" href="course-list.jsp?page=2">2</a></li>
					<li class="page-item"><a class="page-link" href="course-list.jsp?page=3">3</a></li>
					<li class="page-item"><a class="page-link" href="course-list.jsp?page=4">4</a></li>
					<li class="page-item"><a class="page-link" href="course-list.jsp?page=5">5</a></li>
					<li class="page-item"><a class="page-link" href="course-list.jsp?page=2">다음</a></li>
				</ul>
			</nav>
		</div>
	</div>
			
			<div class="text-end">
				<a href="groupform.jsp" class="btn btn-primary btn-sm">새 수업 등록</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>