<%@page import="dao.PersonalReservationDao"%>
<%@page import="vo.User"%>
<%@page import="vo.Reservation"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dao.PersonalLessonDao"%>
<%@page import="vo.Lesson"%>
<%@page import="dao.GroupLessonDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 로그인 정보 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");

	int lessonNo = Integer.parseInt(request.getParameter("no"));
	
	
	// 로직수행
		// 정원수 <= 신청자수면 신청불가능  
	PersonalLessonDao lessonDao = PersonalLessonDao.getinstance();
	Lesson lesson = lessonDao.getPersoanlLessonByLessonNo(lessonNo);
	
	if(lesson.getQuota() == lesson.getReqCnt()){
		response.sendRedirect("personalDetailLesson.jsp?no=" + lessonNo + "&err=fail");
		return;
	}
	if(loginId == null){
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("개인레슨 신청", "utf-8"));
		return;
	}
	if(!"user".equals(loginType)){
		response.sendRedirect("../home.jsp?err=userdeny&job=" + URLEncoder.encode("개인레슨 신청" ,"utf-8" ));
		return;
	}
	// 예약 객체에 담기
	Reservation reservation = new Reservation();
	reservation.setLesson(new Lesson(lessonNo));
	reservation.setUser(new User(loginId));
		// 예약테이블에 저장
	PersonalReservationDao reservationDao = PersonalReservationDao.getInstance();
	reservationDao.insertPersonalReservation(reservation);	
		// 강좌테이블에 신청자수 +1 
	PersonalLessonDao personalLessonDao = PersonalLessonDao.getinstance();
	lesson.setReqCnt(lesson.getReqCnt() +1);
	personalLessonDao.updatePersonalLesson(lesson);
	
	//신청자 수 = 정원수, db에 'N'반영
	if(lesson.getQuota() == lesson.getReqCnt()) {
		lesson.setStatus("N");
	}
	personalLessonDao.updatePersonalLesson(lesson);
		
	// 재요청 URL
	response.sendRedirect("personalList.jsp");
	
%>
