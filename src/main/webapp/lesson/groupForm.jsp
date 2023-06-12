<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
	// 로그인타입, 로그인 아이디 조회
	String loginType = (String)session.getAttribute("loginType");
	String loginId= (String)session.getAttribute("loginId");
	
	// 에러 뽑아내기 
	String err = request.getParameter("err");
	
	// 로직 수행
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
	<jsp:param name= "menu" value="그룹폼"/>
</jsp:include>	
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">신규 그룹강좌 등록</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
<%
	if("fail".equals(err)) {
%>

			<div class="alert alert-danger">
				<strong>잘못된 접근</strong> 그룹수업만 등록할 수 있습니다.
			</div>
<%
	}
%>
			<p>신규 그룹레슨 정보를 입력할 수 있습니다.</p>
			
			<form class="border bg-light p-3" method="post" action="groupInsertLesson.jsp">
				<div class="form-group mb-2">
					<label class="form-label">PT명</label>
					<input type="text" class="form-control" name="lessonName"/> 
				</div>
				<div class="form-group mb-2">
				  <label class="form-label">강사명</label>
				  <span class="form-control"><%=user.getName() %></span>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">정원수</label>
					<select class="form-select" name="quota">
<% for (int i=1; i<=20; i++) { %>
						<option value="<%=i %>"><%=i %></option>
<% } %>
					</select>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">PT시간</label>
						<div class="col-md-12">
							<div class="col-md-12">
								<select class="form-select" name="time">
								  <option value="월요일 10:00 ~ 12:00">월요일 10:00 ~ 12:00</option>
								  <option value="월요일 15:00 ~ 17:00">월요일 15:00 ~ 17:00</option>
								  <option value="화요일 10:00 ~ 12:00">화요일 10:00 ~ 12:00</option>
								  <option value="화요일 15:00 ~ 17:00">화요일 15:00 ~ 17:00</option>
								  <option value="수요일 10:00 ~ 12:00">수요일 10:00 ~ 12:00</option>
								  <option value="수요일 15:00 ~ 17:00">수요일 15:00 ~ 17:00</option>
								  <option value="목요일 10:00 ~ 12:00">목요일 10:00 ~ 12:00</option>
								  <option value="목요일 15:00 ~ 17:00">목요일 15:00 ~ 17:00</option>
								  <option value="금요일 10:00 ~ 12:00">금요일 10:00 ~ 12:00</option>
								  <option value="금요일 15:00 ~ 17:00">금요일 15:00 ~ 17:00</option>
								</select>
							</div>
						</div>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">PT설명</label>
					<textarea class="form-control" rows="5" name="description"></textarea>
				</div>
				<div class="text-end">
					<button type="reset" class="btn btn-secondary btn-sm">취소</button>
					<button type="submit" class="btn btn-primary btn-sm">등록</button>
					<a href="groupInsertLesson.jsp"></a>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>