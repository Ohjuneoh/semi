<%@page import="dao.UserDao"%>
<%@page import="vo.User"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	//로그인 정보 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");
	
	// 오류사항: 로그인이 되지않았거나, 타입이 강사가아니면 조회불가능
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("상세 회원조회", "utf-8"));
			return;
	}
	
	if(!"trainer".equals(loginType)) {
			response.sendRedirect("../home.jsp?err=trainerdeny&job=" + URLEncoder.encode("상세 회원조회", "utf-8"));
			return;
	}
	
	// 로직수행 (회원 상세조회)
	UserDao userDao = UserDao.getinstance();
		// 전달받은 유저아이디 뽑아내기
	String userId = request.getParameter("userId");
	User user = userDao.getUserByUserTypeAndId(userId);
	
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
	<jsp:param name="menu" value="수업"/>
</jsp:include>
<div class="container">
	<div class="row mb-3">
    	<div class="col-12">
        	<h1 class="border bg-light fs-4 p-2">회원 상세 정보</h1>
      	</div>
   	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>회원 상세정보를 확인할 수 있습니다.</p>

			<table class="table table-bordered">
				<tbody>
					<tr>
						<th class="table-dark" style="width: 15%;">회원 이름</th>
						<td style="width: 35%;"><%=user.getName() %></td>
						<th class="table-dark" style="width: 15%;">회원 이메일</th>
						<td style="width: 35%;"><%=user.getEmail() %></td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">회원 전화번호</th>
						<td style="width: 35%;"><%=user.getTel() %></td>
						<th class="table-dark" style="width: 15%;">회원 가입일</th>
						<td style="width: 35%;"><%=user.getCreateDate() %></td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">회원내역 변경일</th>
						<td style="width: 35%;"><%=user.getUpdateDate() %></td>
						<th class="table-dark" style="width: 15%;">회원상태</th>
<% if("Y".equals(user.getStatus())) { %>
						<td style="width: 35%;"><a class="btn btn-primary btn-sm">가입중</a></td>
<% } else if ("N".equals(user.getStatus())) { %>
						<td style="width: 35%;"><a class="btn btn-primary btn-sm">탈퇴</a></td>
<% } %>
					</tr>
					
				</tbody>
			</table>
				<div class="text-end">
				<a href="../trainer/allUserList.jsp" class="btn btn-primary btn-sm">목록</a>
				</div>
		</div>
	</div>
</div>
</body>
</html>