<%@page import="dao.MembershipDao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="jakarta.websocket.SendResult"%>
<%@page import="vo.User"%>
<%@page import="vo.Reservation"%>
<%@page import="dao.GroupReservationDao"%>
<%@page import="vo.Lesson"%>
<%@page import="dao.GroupeLessonDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 로그인 정보 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");
	
	int lessonNo = Integer.parseInt(request.getParameter("lessonNo"));
	
	// 로직수행
		// 오류사항: 정원수 <= 신청자수면 신청불가능  
	GroupeLessonDao lessonDao = GroupeLessonDao.getinstance();
	Lesson lesson = lessonDao.getGroupLessonByLessonNo(lessonNo);
	
	if(lesson.getQuota() == lesson.getReqCnt()) {
		response.sendRedirect("groupDetailLesson.jsp?no=" + lessonNo+ "&err=fail");
		return;
	}
	
		// 오류사항: 로그인 안된 상태이거나, 회원타입이 아닐때 신청불가능
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("그룹레슨 신청", "utf-8"));
		return;
	}
	if(!"user".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=userdeny&job=" + URLEncoder.encode("그룹레슨 신청", "utf-8"));
		return;
	}
	
		// 예약 객체에 담기 
	Reservation reservation = new Reservation();
	reservation.setLesson(new Lesson(lessonNo));
	reservation.setUser(new User(loginId));
	
		// 예약테이블 db에 저장
	GroupReservationDao groupReservationDao = GroupReservationDao.getinstance();
	groupReservationDao.insertGroupReservation(reservation);
	
		// 강좌테이블에 신청자수 +1 
	GroupeLessonDao groupLessonDao = GroupeLessonDao.getinstance();
	lesson.setReqCnt(lesson.getReqCnt()+1);
	groupLessonDao.updateGroupLesson(lesson);
		
		// 만약 정원수=신청자수면, db에 상태 N으로 변경
		if(lesson.getQuota() == lesson.getReqCnt()) {
			lesson.setStatus("N");
		}
		groupLessonDao.updateGroupLesson(lesson);
		
		// 똑같은 회원이 같은 수업을 2번이상 등록하지 못하게 제한하기
/*		XXX xxx = dao.getXXXByMemberIdAndLessonNo(loginId, lessonNo);
		if (xxx != null) {
			response.sendRedirect("form.jsp?err=dup");
			return;
		}
*/		
		// 멤버쉽테이블에 cnt -1 
		
		// 내 멤버쉽 테이블에 cnt -1
	
	
	// 재요청 url
	response.sendRedirect("groupList.jsp");
%>