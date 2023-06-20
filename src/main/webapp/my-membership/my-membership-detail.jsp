<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="vo.MyMembership"%>
<%@page import="java.util.List"%>
<%@page import="dao.MyMembershipDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%

	String userId = (String) session.getAttribute("loginId");
	int myMembershipNo = Integer.parseInt(request.getParameter("my-membershipNo"));
	MyMembershipDao myMembershipDao = MyMembershipDao.getInstance();
	MyMembership myMembership = myMembershipDao.getMyMembershipDetail(userId, myMembershipNo);
	Date startDate = myMembership.getStartDate();
	LocalDate expirationDate = myMembership.getExpirationDate();
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int totalDays = myMembershipDao.getTotalDays(orderNo);
	int remainingDays = myMembershipDao.getRemainingDays(orderNo);

%>

<!doctype html>
<html lang="ko">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
<jsp:include page = "../nav.jsp">
	<jsp:param name = "menu" value="마이페이지"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">나의 이용권 상세 정보</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<table class="table table-bordered ">
				<colgroup>
					<col width="20%">
					<col width="30%">
					<col width="20%">
					<col width="40%">
				</colgroup>
				<tbody>
					<tr>
						<th class="table-dark">헬스장명</th>
						<td><%=myMembership.getMembership().getGym().getName()%></td>
						<th class="table-dark">이용권 종류</th>
						<td><%=myMembership.getMembership().getType() %></td>
					</tr>
					<tr>
						<th class="table-dark">이용권 이름</th>
						<td><%=myMembership.getMembership().getName() %></td>
						<th class="table-dark">이용권 상태</th>
<%
	if("Y".equals(myMembership.getStatus())){
%>						<td>이용가능</td>
<%
	} else if("N".equals(myMembership.getStatus())){
%>						<td>만료</td>
<% }
%>	
					</tr>
					<tr>
						<th class="table-dark">이용권 기간</th>
						<td><%=startDate %> ~ <%=expirationDate %></td>
						<th class="table-dark">잔여일수/총일수</th>
					<td><%=remainingDays %>/<%=totalDays %></td>
					</tr>
					<tr>
						<th class="table-dark">잔여횟수/총횟수</th>
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
						<th class="table-dark">주간이용횟수</th>
<%
	if(myMembership.getMembership().getNumOfUseWeek()== -1){
%>
						<td>무제한</td>
<% 		
	} else {
%>						<td><%=myMembership.getMembership().getNumOfUseWeek()%></td>
<%
	}
%>
					</tr>
					<tr>
						<th class="table-dark">1일이용횟수</th>
<%
	if(myMembership.getMembership().getNumOfUseDay()== -1){
%>
						<td>무제한</td>
<% 		
	} else {
%>						<td><%=myMembership.getMembership().getNumOfUseDay()%></td>
<%
	}
%>
						<th class="table-dark">이용권 중지 가능기간</th>
						<td><%=myMembership.getMembership().getNumOfPause() %>일</td>
					</tr>
				</tbody>
			</table>
			<div class="text-end">
				<a href="my-membership-list.jsp" class="btn btn-primary btn-sm">목록</a>
			</div>
		</div>
	</div>
 
</div>
</body>
</html>