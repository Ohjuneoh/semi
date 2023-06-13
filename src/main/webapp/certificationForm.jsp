<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String err = request.getParameter("err");
	String job = request.getParameter("job");
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
<jsp:include page="nav.jsp">
	<jsp:param name="menu" value="로그인"/>
</jsp:include>

<div class="container">
	<div class="row mb-3">
    	<div class="col-12">
        	<h1 class="border bg-light fs-4 p-2">로그인</h1>
      	</div>
   	</div>
   	<div class="row mb-3">
   		<div class="col-12">
   			<p>비밀번호를 입력하세요</p>
 <%
	if("fail".equals(err)){
%>
			<div class="alert alert-danger">
				<strong>비밀번호가 올바르지 않습니다.</strong> 
			</div>
<%
	} 
%>
   			

   			<form class="border bg-light p-3" method="post" action="certification.jsp">
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">비밀번호</label>
   					<input id="user-password" type="password" class="form-control" name="password" />
   				</div>
   				<div class="text-end w-75">
   					<button type="submit" class="btn btn-primary">입력</button>
   				</div>
   			</form>
   		</div>
   	</div>
</div>

</body>
</html>