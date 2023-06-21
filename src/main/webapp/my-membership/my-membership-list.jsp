<%@page import="dto.Pagination"%>
<%@page import="util.StringUtils"%>
<%@page import="vo.Membership"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="vo.MyMembership"%>
<%@page import="dao.MyMembershipDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String userId = (String) session.getAttribute("loginId");
	MyMembershipDao myMembershipDao = MyMembershipDao.getInstance();
	
	int pageNo = StringUtils.stringToInt(request.getParameter("page"), 1);
	int totalRows = myMembershipDao.getTotalRows();
	Pagination pagination = new Pagination(pageNo, totalRows);
	int begin = pagination.getBegin();
	int end = pagination.getEnd();
	List<MyMembership> myMembershipList = myMembershipDao.getAllMyMembership(userId, begin, end);

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
	<jsp:param name="menu" value="마이페이지"/>
</jsp:include>
<div class="container">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">나의 이용권 목록</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>내가 구매한 이용권 목록을 확인하세요</p>
			<table class="table">
				<thead>
					<tr class="table-dark">
						<th style="width: 10%;">헬스장명</th>
						<th style="width: 10%;">이용권 종류</th>
						<th style="width: 25%;">이용권 이름</th>
						<th style="width: 10%;">이용권 상태</th>
						<th style="width: 20%;">이용 기간</th>
						<th style="width: 15%;">잔여횟수/총횟수</th>
						<th style="width: 10%;"> </th>
					</tr>	
				</thead>
				<tbody>
			
					<tr>
<% for(MyMembership myMembership : myMembershipList){
	Date startDate = myMembership.getStartDate();
	LocalDate expirationDate = myMembership.getExpirationDate();
	int orderNo = myMembership.getOrder().getNo();
	
%>

						<td><%=myMembership.getMembership().getGym().getName()%></td>
<%
	if("PL".equals(myMembership.getMembership().getType())){
%>
						<td>개인레슨</td>
 <%
	} else if("GL".equals(myMembership.getMembership().getType())){
 %> 					<td>그룹레슨</td>
 <%
	} else if("Health".equals(myMembership.getMembership().getType())){
 %>						<td>시설이용</td>
 <%
	} else if("Option".equals(myMembership.getMembership().getType())){
 %>						<td>옵션이용</td>
 <% }
 %>
						<td><%=myMembership.getMembership().getName()%></td>
<%
	if("Y".equals(myMembership.getStatus())){
%>						<td>이용가능</td>
<% } else if("N".equals(myMembership.getStatus())){
%>						<td>만료</td>
<%						
	}
%>			
						<td><%=startDate%> ~ <%=expirationDate %></td>
<%
	if(myMembership.getCount()== -1 && myMembership.getMembership().getCount()== -1){
%>
						<td>무제한/무제한</td>
<% 		
	} else {
%>						<td><%=myMembership.getCount()%>/<%=myMembership.getMembership().getCount() %></td>
<%
	}
%>
						<td>
  							<a href="my-membership-detail.jsp?my-membershipNo=<%=myMembership.getNo() %>&orderNo=<%=myMembership.getOrder().getNo() %>" class="btn btn-outline-dark btn-xs">상세정보</a>
						</td>
						
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
					<a href="my-membership-list.jsp?page=<%=pageNo -1 %>" class="page-link">이전</a>
				</li>
<%
	for(int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++){
%>				<li class="page-item <%=pageNo == num ? "active" : ""%>">   <%--disabled/enabled/selected/active 등등 이와 같은 종류는 모두 삼항연산자 --%>
					<a href="my-membership-list.jsp?page=<%=num %>" class="page-link"><%=num %></a>
				</li>
<%
	}
%>						
				<li class="page-item "<%=pageNo >= pagination.getTotalPages() ? "disabled" : "" %>">
					<a href="my-membership-list.jsp?page=<%=pageNo + 1 %>" class="page-link">다음</a>
				</li>
			</ul>
			</nav>
		</div>
	</div>
		</div>
	</div>
</div>
</body>
</html>