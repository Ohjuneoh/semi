<%@page import="dao.PersonalLessonDao"%>
<%@page import="vo.Lesson"%>
<%@page import="dao.GroupLessonDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 로그인 정보 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");
	
	int lessonNo = Integer.parseInt(request.getParameter("lessonNo"));
	
	// 오류사항1 : 로그인 상태가 아니거나, 강사가 아닌 다른 유형일때 삭제불가능
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("그룹레슨 삭제", "utf-8"));
		return;
	}
	if(!"trainer".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=userdeny&job=" + URLEncoder.encode("그룹레슨 삭제", "utf-8"));
		return;
	}
	
	// 오류사항2 : 본인이 올린 강좌가 아니면 삭제불가능
	PersonalLessonDao personalDao = PersonalLessonDao.getinstance();
	Lesson personalLesson = personalDao.getPersonalLessonByLessonNo(lessonNo);
	
	if(!loginId.equals(personalLesson.getUser().getId())) {
		response.sendRedirect("personalList.jsp?err=fail") ;
		return;
	}
	
	// 로직수행
		// 조회하기
	PersonalLessonDao personalDao2 = PersonalLessonDao.getinstance();
	Lesson lesson = personalDao2.getPersonalLessonByLessonNo(lessonNo);
	lesson.setDeleted("Y");
		// 업데이트하기
	PersonalLessonDao personalDao3 = PersonalLessonDao.getinstance();
	personalDao3.updatePersonalLesson(lesson);
	
	// 재요청 url
	response.sendRedirect("personalList.jsp");
%>