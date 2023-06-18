<%@page import="dao.PersonalLessonDao"%>
<%@page import="vo.Gym"%>
<%@page import="vo.User"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="vo.Lesson"%>
<%@page import="dao.GroupLessonDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 1. 파라미터 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");
	int gymNo = Integer.parseInt((String) session.getAttribute("loginGymNo"));
	
	
	int lessonNo = Integer.parseInt(request.getParameter("lessonNo"));
	
		// 오류사항1 : 로그인 안된 상태이거나, 트레이너 타입이 아닐때,본인이 등록한 강좌가 아닐떄 수정 불가능
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("그룹레슨 수정", "utf-8"));
		return;
	}
	if(!"trainer".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=trainerdeny&job=" + URLEncoder.encode("그룹레슨 수정", "utf-8"));
		return;
	}
		// 오류사항 2: 본인이 등록한 강좌가 아닐때 수정 불가능
	PersonalLessonDao personalDao = PersonalLessonDao.getinstance();
	Lesson personalLesson = personalDao.getPersonalLessonByLessonNo(lessonNo);
	
	if(!loginId.equals(personalLesson.getUser().getId())) {
		response.sendRedirect("personalList.jsp?err=fail");
		return;
	}
	
	// 2. 로직수행
		// 수정한 값 뽑아내기
	String lessonName = request.getParameter("lessonName");
	int quota = Integer.parseInt(request.getParameter("quota"));
	String time = request.getParameter("time");
	String description = request.getParameter("description");
		
		// 객체에 수정된 값을 넣기
	personalLesson.setName(lessonName);
	personalLesson.setQuota(quota);
	personalLesson.setTime(time);
	personalLesson.setDescription(description);
	
	
		// 업데이트하기
	PersonalLessonDao personalDao2 = PersonalLessonDao.getinstance();
	personalDao2.updatePersonalLesson(personalLesson);
	
	// 3. 재요청 url
	response.sendRedirect("personalList.jsp");
	
%>