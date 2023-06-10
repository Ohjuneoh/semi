<%@page import="vo.Gym"%>
<%@page import="dao.UserDao"%>
<%@page import="dao.TrainerDao"%>
<%@page import="dao.GroupeLessonDao"%>
<%@page import="vo.Trainer"%>
<%@page import="vo.User"%>
<%@page import="vo.Lesson"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 1. 파라미터 조회
	
	// 로그인 상태에서, 세션객체에 담긴 값들 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");
	int loginGymNo = (Integer)session.getAttribute("loginGymNo");
	
	
	// 트레이너가 form에서입력한 값 조회
	String lessonName = request.getParameter("lessonName");
	String trainerName = request.getParameter("trainerName");
	int quota = Integer.parseInt(request.getParameter("quota"));
	String time = request.getParameter("time");
	String description = request.getParameter("description");
	
	String lessonType = "그룹";
	
	// 객체에 담기
	Lesson groupLesson = new Lesson();
	groupLesson.setName(lessonName);
	groupLesson.setType(lessonType);
	groupLesson.setQuota(quota);
	groupLesson.setDescription(description);
	groupLesson.setUser(new User(loginId));
	groupLesson.setTime(time);
	groupLesson.setGym(new Gym(loginGymNo));
	
	// 2. 로직수행
	GroupeLessonDao groupDao = GroupeLessonDao.getinstance();
	groupDao.insertGroupLesson(groupLesson);
	
	// 3. 재요청 url
	response.sendRedirect("groupList.jsp");

%>
