<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	

	// 요청파라미터로 전달받은 상품번호에 해당하는 상품정보 조회
	String loginType = (String)session.getAttribute("loginType");
	String loginId = (String)session.getAttribute("loginId");
	
	UserDao userDao = UserDao.getinstance();
	User user = userDao.getUserById(loginId);
	
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
	<jsp:param name="menu" value="수정"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">개인정보 수정</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>개인정보를 확인하고, 수정하세요</p>
			<form class="border bg-light p-3" method="post" action="modify.jsp">
				<input type = "hidden" name="id" value="">		
				<div class="form-group mb-2">
					<label class="form-label">이름</label>
					<input type="text" class="form-control" name="name" value="<%=user.getName()%>" />
				</div>
				<div class="form-group mb-2">
					<label class="form-label">비밀번호</label>
					<input type="password" class="form-control" name="password" value="<%=user.getPassword()%>"/>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">이메일</label>
					<input type="text" class="form-control" name="email" value="<%=user.getEmail()%>"/>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">전화번호</label>
					<input type="text" class="form-control" name="tel" value="<%=user.getTel()%>"/>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">헬스장 번호</label>
					<input type = "text" class="form-control" name="gymNo"  value="<%=user.getGym().getNo()%>" />
				</div>
				<div class="text-end">
					<button type="reset" class="btn btn-secondary btn-sm">취소</button>
					<button type="submit" class="btn btn-primary btn-sm">수정</button>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>