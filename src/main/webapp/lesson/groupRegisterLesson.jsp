<%@page import="vo.Lesson"%>
<%@page import="dao.GroupeLessonDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 로그인 정보 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");

	int lessonNo = Integer.parseInt(request.getParameter("no"));
	
	
	// 로직수행
		// 정원수 <= 신청자수면 신청불가능  
		
/*	GroupeLessonDao lessonDao = GroupeLessonDao.getinstance();
	Lesson lesson = lessonDao.getGroupLessonByLessonNo(lessonNo);
	
	if(lesson.getQuota() <= lesson.getReqCnt()) {
		
	}
*/ 	
		// 예약테이블에 저장
	
		// 강좌테이블에 신청자수 +1 
			
	
%>
