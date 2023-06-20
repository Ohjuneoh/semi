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
	<jsp:param name="menu" value="마이페이지"/>
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
			<form class="border bg-light p-3" method="post" action="modify2.jsp" onsubmit="return fn1();">
				<input type = "hidden" name="id" value="<%=loginId%>">		
				<div class="form-group mb-2">
					<label class="form-label">이름</label>
					<input type="text" class="form-control" name="name" value="<%=user.getName()%>" />
				</div>
				<div class="form-group mb-2">
					<label class="form-label">비밀번호</label>
					<input id = "user-password1" type="password" class="form-control" name="password" />
				</div>
				<div class="form-group mb-2">
					<label class="form-label">비밀번호 확인</label>
					<input id = "user-password2" type="password" class="form-control" />
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
					<label class="form-label">상품사진</label>
					<input type="file" class="form-control" name="picture" />
				</div>
				<div class="text-end">
					<button type="reset" class="btn btn-secondary btn-sm">취소</button>
					<button type="submit" class="btn btn-primary btn-sm">수정</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	function fn1() {
		let password1 = document.getElementById("user-password1").value;
		let password2 = document.getElementById("user-password2").value;
		if(password1 != password2){
			alert("입력한 두 비밀번호가 일치하지 않습니다.")
			return false;
		}
			return true;
	}


</script>

</body>
</html>