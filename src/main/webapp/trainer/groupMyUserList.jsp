<%@page import="dao.GroupReservationDao"%>
<%@page import="vo.Reservation"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	//로그인정보 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");
	
	// 오류상황
		// 로그인이 되지 않았을 경우
		// 로그인 타입이 강사가 아닌경우 
	if(loginId == null) {
	response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("나의 그룹레슨 회원목록 조회", "utf-8"));
		return;
	}
	if(!"trainer".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=trainerdeny&job=" + URLEncoder.encode("나의 그룹레슨 회원목록 조회", "utf-8"));
		return;
	}
	
	// 로직수행(강사의 그룹레슨 회원목록 조회)
	GroupReservationDao reservDao = GroupReservationDao.getInstance();
	List<Reservation> reservList = reservDao.getGroupMyUserByTrainerId(loginId);
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
	<jsp:param name="menu" value="회원관리"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">내 그룹레슨 회원 목록</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>내 그룹레슨 회원 목록을 확인할 수 있습니다.</p>
			<ul class="nav nav-tabs mb-3">
           		<li class="nav-item"><a class="nav-link" href="/semi/trainer/myUserList.jsp ">전체</a></li>
           		<li class="nav-item"><a class="nav-link" href="/semi/trainer/personalMyUserList.jsp">개인</a></li>
           		<li class="nav-item"><a class="nav-link active" href="/semi/trainer/groupMyUserList.jsp">그룹</a></li>
			</ul>
			<table class="table table-sm">
				<thead>
					<tr>
						<th>회원이름</th>
						<th>회원 이메일</th>
						<th>회원 전화번호</th>
						<th>가입일</th>
						<th>회원상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
<% 
	for(Reservation reserve : reservList) {
 %>
						<td style="width: 10%;"><a href="../user/userDetail.jsp?userId=<%=reserve.getUser().getId() %>"><%=reserve.getUser().getName() %></a></td>
						<td style="width: 36%;"><%=reserve.getUser().getEmail() %></td>
						<td style="width: 12%;"><%=reserve.getUser().getTel() %></td>
						<td style="width: 18%;"><%=reserve.getUser().getCreateDate() %></td>
<% 
	if ("Y".equals(reserve.getUser().getStatus())) { 
%>
						<td style="width: 12%;"><a class="btn btn-primary btn-sm">가입중</a></td>
<% 
	} else if("N".equals(reserve.getUser().getStatus())) { 
%>
						<td style="width: 12%;"><a class="btn btn-danger btn-sm">탈퇴</a></td>

<% } %>

					</tr>
<% 
	}
%>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>