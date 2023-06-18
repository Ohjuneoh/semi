<%@page import="dao.PersonalLessonDao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="vo.Gym"%>
<%@page import="dao.UserDao"%>
<%@page import="dao.TrainerDao"%>
<%@page import="dao.GroupLessonDao"%>
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
	
	
		// 오류사항: 로그인 안된 상태이거나, 트레이너 타입이 아닐때 등록불가능
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("개인레슨 등록", "utf-8"));
		return;
	}
	if(!"trainer".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=trainerdeny&job=" + URLEncoder.encode("개인레슨 등록", "utf-8"));
		return;
	}
	

		// 트레이너가 form에서입력한 값 조회
	String lessonName = request.getParameter("lessonName");
	int quota = Integer.parseInt(request.getParameter("quota"));
	String time = request.getParameter("time");
	String description = request.getParameter("description");
	
	String lessonType = "personal";
	
		// 오류사항: 레슨타입이 group이 아니면 오류
	if(!"personal".equals(lessonType)) {
		response.sendRedirect("personalForm.jsp?err=fail") ;
		return;
	}
	
		// 객체에 담기
	Lesson personalLesson = new Lesson();
	personalLesson.setName(lessonName);
	personalLesson.setType(lessonType);
	personalLesson.setQuota(quota);
	personalLesson.setDescription(description);
	personalLesson.setUser(new User(loginId));
	personalLesson.setTime(time);
	personalLesson.setGym(new Gym(gymNo));
	
	// 2. 로직수행()
	PersonalLessonDao personalDao = PersonalLessonDao.getinstance();
	personalDao.insertPersonalLesson(personalLesson);
	
	// 3. 재요청 url
	response.sendRedirect("personalList.jsp");
%>
