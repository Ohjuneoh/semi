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
			<h3>나의 이용권 상세정보를 확인하세요.</h3>
			
			<table class="table table-bordered ">
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="10%">
					<col width="40%">
				</colgroup>
				<tbody>
					<tr>
						<th>헬스장명</th>
						<td><%=myMembership.getMembership().getGym().getName()%></td>
						<th>이용권 종류</th>
						<td><%=myMembership.getMembership().getType() %></td>
					</tr>
					<tr>
						<th>이용권 이름</th>
						<td><%=myMembership.getMembership().getName() %></td>
						<th>이용권 상태</th>
						<td><%=myMembership.getStatus()%></td>
					</tr>
					<tr>
						<th>이용권 기간</th>
						<td><%=startDate%> ~ <%=expirationDate %></td>
						<th>잔여일수/총일수</th>
						<td> </td>
					</tr>
					<tr>
						<th>잔여횟수/총횟수</th>
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
						<th>주간이용횟수</th>
						<td><%=myMembership.getMembership().getNumOfUseWeek() %></td>
					</tr>
					<tr>
						<th>1일이용횟수</th>
						<td><%=myMembership.getMembership().getNumOfUseDay() %></td>
						<th>이용권 중지 가능 횟수</th>
						<td><%=myMembership.getMembership().getNumOfPause() %></td>
					</tr>
				</tbody>
			</table>
			<div class="text-end">
				 
				
				<span class="btn btn-warning btn-sm">수정</span>
				<a href="my-membership-list.jsp" class="btn btn-primary btn-sm">목록</a>
			</div>
		</div>
	</div>
 
</div>
</body>
</html>