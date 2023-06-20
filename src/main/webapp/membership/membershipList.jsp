<%@page import="dto.Pagination"%>
<%@page import="vo.Membership"%>
<%@page import="dao.MembershipDao"%>
<%@page import="java.util.List"%>

<%@page import="util.StringUtils"%>
<%
	String loginId = (String) session.getAttribute("loginId");

	int pageNo = StringUtils.stringToInt(request.getParameter("page"), 1);

	MembershipDao membershipDao = MembershipDao.getInstance();
	int totalPage = membershipDao.totalPage();
	
	Pagination pagination = new Pagination(pageNo, totalPage);
	
	int begin = pagination.getBegin();
	int end = pagination.getEnd();
	
	
	List<Membership> membershipList = membershipDao.getAllMembership(begin, end);
	String loginType = (String) session.getAttribute("loginType");
	

	
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
			<h1 class="border bg-light fs-4 p-2">이용권 구매하기</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>다양한 이용권을 확인해보세요.</p>
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
<%
	if("PL".equals(membership.getType())){
%>
						<td>개인레슨</td>
 <%
	} else if("GL".equals(membership.getType())){
 %> 					<td>그룹레슨</td>
 <%
	} else if("Health".equals(membership.getType())){
 %>						<td>시설이용</td>
 <%
	} else if("Option".equals(membership.getType())){
 %>						<td>옵션이용</td>
 <% }
 %>
						<td><%=membership.getName()%></td>
						<td><%=membership.getPrice()%>원</td>
						<td style="font-weight: bold; color:#B22222;"><%=membership.getDiscountedPrice() %>원</td>
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
				<li class="page-item <%=pageNo <=1 ? "disabled" : "" %>">
					<a href="membershipList.jsp?page=<%=pageNo -1 %>" class="page-link">이전</a>
				</li>
<%
	for(int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++){
%>				<li class="page-item <%=pageNo == num ? "active" : ""%>">   <%--disabled/enabled/selected/active 등등 이와 같은 종류는 모두 삼항연산자 --%>
					<a href="membershipList.jsp?page=<%=num %>" class="page-link"><%=num %></a>
				</li>
<%
	}
%>						
				<li class="page-item "<%=pageNo >= pagination.getTotalPages() ? "disabled" : "" %>">
					<a href="membershipList.jsp?page=<%=pageNo + 1 %>" class="page-link">다음</a>
				</li>
			</ul>
			</nav>
		</div>
	</div>
<%
	if("manager".equals(loginType)){
%>		
			<div class="text-end">
				<a href="membership-form.jsp" class="btn btn-primary btn-sm">이용권 등록</a>
			</div>
<%
	}
%>
		</div>
	</div>
</div>
</body>
</html>