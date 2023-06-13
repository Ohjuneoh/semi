<%@page import="vo.Membership"%>
<%@page import="dao.MembershipDao"%>
<%@page import="java.util.List"%>

<%@page import="util.StringUtils"%>
<%
	MembershipDao membershipDao = new MembershipDao();
	
	List<Membership> membershipList = membershipDao.getAllMembership();
	

	
%>

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
	<jsp:param name="menu" value="이용권"/>
</jsp:include>
<div class="container">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">이용권 목록</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>이용권을 확인하세요</p>
			<table class="table">
				<thead>
					<tr class="table-dark">
						<th style="width: 10%;">NO</th>
						<th style="width: 10%;">속성</th>
						<th style="width: 10%;">종류</th>
						<th style="width: 30%;">이름</th>
						<th style="width: 15%;">가격</th>
						<th style="width: 15%;">할인가격</th>
						<th style="width: 10%;"></th>
					</tr>	
				</thead>
				<tbody>
			
					<tr>
<% for(Membership membership : membershipList){
%>
						<td><%=membership.getNo()%></td>
						<td><%=membership.getCat()%></td>
						<td><%=membership.getType()%></td>
						<td><%=membership.getName()%></td>
						<td><%=membership.getPrice()%>원</td>
						<td><%=membership.getDiscountedPrice() %>원</td>
						<td><a href="membership-detail.jsp?membershipNo=<%=membership.getNo() %>" class="btn btn-outline-dark btn-xs">상세정보</a></td>
					</tr>
<%
}
%>
					
				</tbody>
			</table>
			<div class="row mb-3">
		<div class="col-12">
			<nav>
				<ul class="pagination justify-content-center">
					<li class="page-item"><a class="page-link disabled" href="membershipList.jsp?page=1">이전</a></li>
					<li class="page-item"><a class="page-link active" href="membershipList.jsp?page=1">1</a></li>
					<li class="page-item"><a class="page-link" href="membershipList.jsp?page=2">2</a></li>
					<li class="page-item"><a class="page-link" href="membershipList.jsp?page=3">3</a></li>
					<li class="page-item"><a class="page-link" href="membershipList.jsp?page=4">4</a></li>
					<li class="page-item"><a class="page-link" href="membershipList.jsp?page=5">5</a></li>
					<li class="page-item"><a class="page-link" href="membershipList.jsp?page=2">다음</a></li>
				</ul>
			</nav>
		</div>
	</div>
			
			<div class="text-end">
				<a href="membership-form.jsp" class="btn btn-primary btn-sm">이용권 등록</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>