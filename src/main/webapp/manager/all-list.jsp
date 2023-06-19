<%@page import="dto.Pagination"%>
<%@page import="util.StringUtils"%>
<%@page import="java.util.List"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	UserDao userDao = UserDao.getinstance();
	int pageNo = StringUtils.stringToInt(request.getParameter("page"), 1);	
	int totalPages = userDao.getTotalPages();	
	Pagination pagination = new Pagination(pageNo, totalPages);
	int begin = pagination.getBegin();
	int end = pagination.getEnd();
	List<User> userList = userDao.getAllUsers(pagination.getBegin(), pagination.getEnd());
	
%>
<!doctype html>
<html lang="ko">
<head>
<title>회원/강사 목록</title>
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
	<jsp:param name="menu" value="관리자 페이지"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
			<ul class="nav nav-tabs mb-3">
           		<li class="nav-item"><a class="nav-link active" href="all-list">전체</a></li>
           		<li class="nav-item"><a class="nav-link" href="user-list.jsp">회원</a></li>
           		<li class="nav-item"><a class="nav-link" href="trainer-list.jsp">강사</a></li>
			</ul>
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">전체 회원 목록</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">		
			<table class="table table-sm">
				<colgroup>
					<col width="10%">
					<col width="20%">
					<col width="30%">
					<col width="20%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>분류</th>
						<th>이름</th>
						<th>상태</th>
						<th>등록일자</th>
					</tr>
				</thead>
				<tbody>
<%
	int count = 1; 
	for(User user : userList) {	
%>	
					<tr>
						<td><%= count++ %></td>
						<td><%=user.getType() %></td>
						<td><%=user.getName() %></td>
											
<%
	if("user".equals(user.getType()) && "Y".equals(user.getStatus())){
%>						<td><%="이용중" %></td>
<%
	} else if("user".equals(user.getType()) && "N".equals(user.getStatus())){
%>						<td><%="탈퇴" %></td>
<%
	} else if("trainer".equals(user.getType()) && "Y".equals(user.getStatus())){
%>						<td><%="재직중" %></td>
<%
	} else if("trainer".equals(user.getType()) && "N".equals(user.getStatus())){
%>						<td><%="퇴사" %></td>
<%
	} else if("manager".equals(user.getType()) && "Y".equals(user.getStatus())){
%>						<td><%="재직중" %></td>
<%
	} else if("manager".equals(user.getType()) && "N".equals(user.getStatus())){
%>						<td><%="퇴사" %></td>
<%
	}
%>					
						<td><%=user.getCreateDate()%></td>
					</tr>				
<%
	}
%>
				</tbody>
			</table>
<%
	if(totalPages != 0) {
%>
			<div class="row mb-3">
				<div class="col-12">
					<nav>
						<ul class="pagination justify-content-center">
							<li class="page-item <%=pageNo <= 1 ? "disabled" : "" %>">
								<a class="page-link" href="all-list.jsp?page=<%=pageNo - 1 %>">이전</a>
							</li>
<%
		for(int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
							<li class="page-item <%=pageNo == num ? "active" : "" %>">
								<a class="page-link" href="all-list.jsp?page=<%=num %>"><%=num %></a>
							</li>
<%
		}
%>					
							<li class="page-item" <%=pageNo >=pagination.getTotalPages() ? "disabled" : ""  %>">
								<a href="all-list.jsp?page=<%=pageNo + 1 %>" class="page-link">다음</a>
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