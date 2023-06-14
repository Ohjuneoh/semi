<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<%
	String err = request.getParameter("err");
	String job = request.getParameter("job");
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
	<jsp:param name="menu" value="홈"/>
</jsp:include>

<%
	if("userdeny".equals(err)){
%>
			<div class="alert alert-danger">
				<strong>잘못된 접근</strong>[<%=job %>]은 회원만 사용가능한 서비스입니다.
			</div>
<%
	}
%>

<%
	if("trainerdeny".equals(err)){
%>
			<div class="alert alert-danger">
				<strong>잘못된 접근</strong>[<%=job %>]은 강사만 사용가능한 서비스입니다.
			</div>
<%
	}
%>

<%
	if("managerdeny".equals(err)){
%>
			<div class="alert alert-danger">
				<strong>잘못된 접근</strong>[<%=job %>]은 매니저만 사용가능한 서비스입니다.
			</div>
<%
	}
%>


</body>
</html>