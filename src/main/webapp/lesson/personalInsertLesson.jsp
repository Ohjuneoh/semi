<%@page import="dao.PersonalLessonDao"%>
<%@page import="vo.Gym"%>
<%@page import="dao.UserDao"%>
<%@page import="vo.Trainer"%>
<%@page import="vo.User"%>
<%@page import="vo.Lesson"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 1. 파라미터 조회
	
	// 로그인 상태에서, 세션객체에 담긴 값들 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");
	int gymNo = Integer.parseInt((String) session.getAttribute("loginGymNo"));
	
	// 트레이너가 form에서입력한 값 조회
	String lessonName = request.getParameter("lessonName");
	int quota = Integer.parseInt(request.getParameter("quota"));
	String lessonTime = request.getParameter("lessonTime");
	String description = request.getParameter("description");
	
	String lessonType = "personal";
	
	// 객체에 담기
	Lesson lesson = new Lesson();
	lesson.setName(lessonName);
	lesson.setType(lessonType);
	lesson.setQuota(quota);
	lesson.setDescription(description);
	lesson.setUser(new User(loginId));
	lesson.setTime(lessonTime);
	lesson.setGym(new Gym(gymNo));
	
	// 2. 로직수행
	PersonalLessonDao lessonDao = PersonalLessonDao.getinstance();
	lessonDao.insertPersonalLesson(lesson);
	
	// 3. 재요청 url
	response.sendRedirect("personalList.jsp");

%>
