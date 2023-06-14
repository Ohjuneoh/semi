<%@page import="java.net.URLEncoder"%>
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
	int gymNo = Integer.parseInt((String) session.getAttribute("loginGymNo"));
	
	
		// 오류사항: 로그인 안된 상태이거나, 트레이너 타입이 아닐때 등록불가능
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("그룹레슨 등록", "utf-8"));
		return;
	}
	if(!"trainer".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=trainerdeny&job=" + URLEncoder.encode("그룹레슨 등록", "utf-8"));
		return;
	}
	

		// 트레이너가 form에서입력한 값 조회
	String lessonName = request.getParameter("lessonName");
	int quota = Integer.parseInt(request.getParameter("quota"));
	String time = request.getParameter("time");
	String description = request.getParameter("description");
	
	String lessonType = "group";
	
		// 오류사항: 레슨타입이 group이 아니면 오류
	if(!"group".equals(lessonType)) {
		response.sendRedirect("groupForm.jsp?err=fail") ;
		return;
	}
	
		// 객체에 담기
	Lesson groupLesson = new Lesson();
	groupLesson.setName(lessonName);
	groupLesson.setType(lessonType);
	groupLesson.setQuota(quota);
	groupLesson.setDescription(description);
	groupLesson.setUser(new User(loginId));
	groupLesson.setTime(time);
	groupLesson.setGym(new Gym(gymNo));
	
	// 2. 로직수행()
	GroupeLessonDao groupDao = GroupeLessonDao.getinstance();
	groupDao.insertGroupLesson(groupLesson);
	
	// 3. 재요청 url
	response.sendRedirect("groupList.jsp");

%>
