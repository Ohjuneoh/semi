<%@page import="dao.PersonalLessonDao"%>
<%@page import="vo.Lesson"%>
<%@page import="java.util.List"%>
<%@page import="dao.GroupeLessonDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 로그인 정보 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");
	
	// 레슨번호 뽑아내기
	int lessonNo = Integer.parseInt(request.getParameter("no"));
	
	// 로직수행
	PersonalLessonDao lessonDao = PersonalLessonDao.getinstance();
	Lesson personalLesson =lessonDao.getPersoanlLessonByLessonNo(lessonNo);
	
	
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
	<jsp:param name="menu" value="개인수업상세"/>
</jsp:include>
<div class="container">
	<div class="row mb-3">
    	<div class="col-12">
        	<h1 class="border bg-light fs-4 p-2">개인수업 상세 정보</h1>
      	</div>
   	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>그룹수업 상세정보를 확인할 수 있습니다.</p>
			<table class="table table-bordered">
				<tbody>
					<tr>
						<th class="table-dark" style="width: 15%;">레슨명</th>
						<td style="width: 35%;"><%=personalLesson.getName() %></td>
						<th class="table-dark" style="width: 15%;">강사명</th>
						<td style="width: 35%;"><%=personalLesson.getUser().getName() %></td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">수강인원</th>
						<td style="width: 35%;"><%=personalLesson.getQuota() %>명</td>
						<th class="table-dark" style="width: 15%;">신청인원</th>
						<td style="width: 35%;"><%=personalLesson.getReqCnt() %>명</td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">등록일</th>
						<td style="width: 35%;"><%=personalLesson.getCreatDate() %></td>
						<th class="table-dark" style="width: 15%;">강좌시간</th>
						<td style="width: 35%;"><%=personalLesson.getTime() %></td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">레슨상태</th>
<% if(personalLesson.getQuota() != personalLesson.getReqCnt()) { %>
						<td  style="width: 25%">
							<span class="badge text-bg-success p-2">모집중</span>
						</td>
<% } else if (personalLesson.getQuota() != personalLesson.getReqCnt()) { %>
						<td  style="width: 25%">
							<span class="badge text-bg-secondary p-2">모집완료</span>
						</td>
<% } %>
						<th class="table-dark" style="width: 15%;">헬스장명</th>
						<td style="width: 35%;"><%=personalLesson.getGym().getName() %></td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">설명</th>
						<td style="width: 85%; height: 100px;" colspan="3"><%=personalLesson.getDescription() %></td>
					</tr>
				</tbody>
			</table>
					<div class="text-end">
<% if(loginId != null && "회원".equals(loginType)) { %>
						<a href="groupRegisterLesson.jsp?id=<%=loginId %>" class="btn btn-warning btn-sm">신청</a>
<% } %>
						<a href="groupList.jsp" class="btn btn-primary btn-sm">목록</a>
						
<% if(loginId != null && "강사".equals(loginType)) { %>
						<a href="delete.jsp?id=" class="btn btn-danger btn-sm">삭제</a>
<% } %>
					</div>
		</div>
	</div>
</div>
</body>
</html> 