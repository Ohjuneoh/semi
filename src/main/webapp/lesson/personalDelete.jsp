<%@page import="vo.Lesson"%>
<%@page import="dao.PersonalLessonDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%      
	// 로그인 정보 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");
	
	int lessonNo = Integer.parseInt(request.getParameter("lessonNo"));
	
	// 로그인한 상태가 아니거나, 강사가 아닌 다른 유형일 때  삭제 불가능
	if(loginId == null){
		response.sendRedirect("../loginform.jsp?err=req&job="+ URLEncoder.encode("개인레슨 삭제","utf-8"));
		return;
	}
	if(!"trainer".equals(loginType)){
		response.sendRedirect("../home.jsp?err=userdeny&job=" + URLEncoder.encode("개인레슨 삭제", "utf-8"));
		return;
	}
	
	// 본인이 올린 강좌가 아니면 삭제 불가능
	PersonalLessonDao lessonDao = PersonalLessonDao.getinstance();
	Lesson personalLesson = lessonDao.getPersoanlLessonByLessonNo(lessonNo);
	
	if(!loginId.equals(personalLesson.getUser().getId())){
		response.sendRedirect("personalList.jsp?err=fail");
		return;
	}
	
	// 삭제기능 구현
	PersonalLessonDao lessonDao2 = PersonalLessonDao.getinstance();
	lessonDao2.deletePersonalLesson(lessonNo);
	
	// 재요청 URL
	response.sendRedirect("personalList.jsp");
	
%>	