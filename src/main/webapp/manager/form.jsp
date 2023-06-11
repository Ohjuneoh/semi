<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String err = request.getParameter("err");
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
	<jsp:param name="menu" value="회원가입"/>
</jsp:include>
<div class="container">
	<div class="row mb-3">
    	<div class="col-12">
        	<h1 class="border bg-light fs-4 p-2">관리자로 등록하기</h1>
      	</div>
   	</div>
   	<div class="row mb-3">
   		<div class="col-12">
   			<p>사용자 정보를 입력하고 등록하세요.</p>
<%
	if("id".equals(err)){
%>
			<div class = "alert alert-danger">
				<strong>사용자등록 실패</strong> 이미 사용중인 아이디로 가입할 수 없습니다.
			</div>  
<%
}
%>
<%
	 if("email".equals(err)){
%>
			<div class = "alert alert-danger">
				<strong>사용자등록 실패</strong> 이미 사용중인 이메일로 가입할 수 없습니다.
			</div>  
<%
}
%>				
   			<form class="border bg-light p-3" method="post" action="insert.jsp">
   				<input type="hidden" name="type" value="manager">
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">아이디</label>
   					<input type="text" class="form-control" name="id" />
   				</div>
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">비밀번호</label>
   					<input type="text" class="form-control" name="password" />
   				</div>
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">이름</label>
   					<input type="text" class="form-control" name="name" />
   				</div>
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">이메일</label>
   					<input type="text" class="form-control" name="email" />
   				</div>
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">전화번호</label>
   					<input type="text" class="form-control" name="tel" />
   				</div>
   				<div class="text-end w-75">
   					<button type="submit" class="btn btn-primary">등록</button>
   				</div>
   			</form>
   		</div>
   	</div>
</div>
</body>
</html>