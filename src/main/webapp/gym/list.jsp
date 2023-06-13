<%@page import="vo.Gym"%>
<%@page import="dao.GymDao"%>
<%@page import="dto.Pagination"%>
<%@page import="util.StringUtils"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	int pageNo = StringUtils.stringToInt(request.getParameter("page"), 1);

	GymDao gymDao = GymDao.getinstance();
	
	int totalPage = gymDao.totalPage();
	Pagination pagination = new Pagination(pageNo, totalPage);
	int begin = pagination.getBegin();
	int end = pagination.getEnd();
	List<Gym> gymList = gymDao.getGyms(begin, end);
	
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
	<jsp:param name="menu" value="헬스장"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">헬스장 리스트</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>전체 헬스장 목록을 확인하세요.</p>
			<table class="table table-sm">
				<colgroup>
					<col width="10%">
					<col width="30%">
					<col width="20%">
					<col width="20%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>헬스장명</th>
						<th>지역명</th>
						<th>전화번호</th>
					</tr>
				</thead>
				<tbody>
<%
	for (Gym gym : gymList) {
%>
					<tr>
						<td><%=gym.getNo() %></td>
						<td><a class="text-black text-decoration-none"><%=gym.getName()%></a></td>
						<td><%=gym.getLocationName()%></td>
						<td><%=gym.getTel()%> </td>
					</tr>
<%
	}
%>
				</tbody>
			</table>
			
			<nav>
				<ul class="pagination justify-content-center">
					<li class="page-item <%=pageNo <= 1 ? "disabled" : ""%>">
						<a href="list.jsp?page=<%=pageNo - 1 %>" class="page-link">이전</a>
					</li>
<%
	for(int num = pagination.getBeginPage(); num<=pagination.getEndPage(); num++){
%>					
					
					<li class="page-item <%=pageNo == num ? "active" : ""%>">
						<a href="list.jsp?page=<%=num %>"class="page-link"><%=num %></a>
					</li>
<%
	}
%>					
				
					
					<li class="page-item <%=pageNo >= pagination.getTotalPages() ? "disabled" : "" %>">
						<a href="list.jsp?page=<%=pageNo + 1 %>"class="page-link">다음</a>
					</li>
				</ul>
			</nav>
			
			<div class="text-end">
				<a href="insert.jsp" class="btn btn-primary btn-sm">헬스장 등록</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>