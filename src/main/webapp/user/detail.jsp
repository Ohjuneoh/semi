<%@page import="java.io.ObjectInputFilter.Status"%>
<%@page import="vo.Point"%>
<%@page import="dao.PointDao"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<%
	//요청 파라미터 조회
	String loginType = (String)session.getAttribute("loginType");
	String loginId = (String)session.getAttribute("loginId");
	
	String err = request.getParameter("err");
	
	//업무 로직 수행
	UserDao userDao = UserDao.getinstance();
	User user = userDao.getUserById(loginId);
	
	PointDao pointDao = PointDao.getinstance();
	Point point = pointDao.getPointById(loginId);

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
	<jsp:param name="menu" value="회원"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">상세 정보</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>회원의 상세정보를 확인하세요.</p>
<%
	if("fail".equals(err)){
%>
			<div class="alert alert-danger">
				<strong>삭제 실패</strong> 사용중인 고객은 삭제할 수 없습니다.
			</div>
<%
	}
%>
			
			<table class="table table-bordered">
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="10%">
					<col width="40%">
				</colgroup>
				<tbody>
					<tr>
						<th class="table-dark">아이디</th>
						<td><%=user.getId()%></td>
						<th class="table-dark">이름</th>
						<td><%=user.getName()%></td>
					</tr>
					<tr>
						<th class="table-dark">전화번호</th>
						<td><%=user.getTel()%></td>
						<th class="table-dark">이메일</th>
						<td><%=user.getEmail()%></td>
					</tr>
					<tr>
						<th class="table-dark">포인트</th>
<%
    if (point == null) {
        point = new Point();
        point.setCurrentPoint(0);
    }
%>
						<td><%=point.getCurrentPoint()%></td>
						<th class="table-dark">탈퇴여부</th>
						<td>
<%
	if("Y".equals(user.getStatus())){
%>
							<span class="badge text-bg-primary">사용중</span>
<%
	}else if("N".equals(user.getStatus())){
%>
							<span class="badge text-bg-secondary">휴면계정</span>
<%
	}
%>
						</td>
					</tr>
					<tr>
						<th class="table-dark">가입일자</th>
						<td><%=user.getCreateDate()%></td>
						<th class="table-dark">수정일자</th>
						<td><%=user.getUpdateDate()%></td>
					</tr>
				</tbody>
			</table>
			<div class="text-end">
<% 
	if("N".equals(user.getStatus())){
%>
				<a href="delete.jsp?id=<%=user.getId()%>" class="btn btn-danger btn-sm">회원탈퇴</a>
<% 
	}
%>
				<a href="modifyForm.jsp?id=<%=user.getId()%>" class="btn btn-warning btn-sm">수정</a>
<%
	if("Y".equals(user.getStatus())){
%>				
				<a href="disable.jsp?id=<%=user.getId()%>" class="btn btn-danger btn-sm">계정휴면</a>
<%
	} else{
%>
				<a href="enable.jsp?id=<%=user.getId()%>" class="btn btn-primary btn-sm">계정휴면해제</a>
<%
	}
%>
			</div>
		</div>
	</div>
</div>
</body>
</html>