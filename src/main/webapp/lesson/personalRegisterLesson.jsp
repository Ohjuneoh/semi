<%@page import="dao.PersonalReservationDao"%>
<%@page import="dao.PersonalLessonDao"%>
<%@page import="vo.MyMembership"%>
<%@page import="dao.MyMembershipDao"%>
<%@page import="vo.Membership"%>
<%@page import="java.lang.reflect.Member"%>
<%@page import="java.util.List"%>
<%@page import="dao.MembershipDao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="jakarta.websocket.SendResult"%>
<%@page import="vo.User"%>
<%@page import="vo.Reservation"%>
<%@page import="dao.GroupReservationDao"%>
<%@page import="vo.Lesson"%>
<%@page import="dao.GroupLessonDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 로그인 정보,레슨번호,멤버쉽번호 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");
	
	int lessonNo = Integer.parseInt(request.getParameter("lessonNo"));
	int myMembershipNo = Integer.parseInt(request.getParameter("myMembershipNo"));
	

		// 오류사항1 : 로그인 안된 상태이거나, 회원타입이 아닐때 신청불가능
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("개인레슨 신청", "utf-8"));
		return;
	}
	if(!"user".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=userdeny&job=" + URLEncoder.encode("개인레슨 신청", "utf-8"));
		return;
	}
		// 오류사항2 : 정원수 == 신청자수면 신청불가능  
	PersonalLessonDao lessonDao = PersonalLessonDao.getinstance();
	Lesson lesson = lessonDao.getPersonalLessonByLessonNo(lessonNo);
	
	if(lesson.getQuota() == lesson.getReqCnt()) {
		response.sendRedirect("personalDetailLesson.jsp?no=" + lessonNo+ "&err=fail");
		return;
	}
		// 만약 정원수=신청자수면, db에 상태 N으로 변경
	if(lesson.getQuota() == lesson.getReqCnt()) {
		lesson.setStatus("N");
	}
	
		// 오류사항3: 똑같은 회원이 같은 수업을 2번이상 등록하지 못하게 제한하기
	PersonalReservationDao reservationDao = PersonalReservationDao.getInstance();
	Reservation reservation2 = reservationDao.getPersonalReservationsByIdAndLessonNo(loginId, lessonNo);
	if(reservation2 != null) {
		response.sendRedirect("personalDetailLesson.jsp?no=" + lessonNo+ "&err=fail2");
		return;
	}
	
		// 오류사항4: 만약 이용권이 없으면 구매불가능 
	MyMembershipDao mymemDao = MyMembershipDao.getInstance();
	MyMembership mymembership = mymemDao.getMyMembershipDetail(loginId, myMembershipNo);
	
	if(mymembership.getNo() == 0) { 
		response.sendRedirect("personalRegisterForm.jsp?lessonNo=" + lessonNo+ "&err=fail");
		return;
	}
		// 오류사항5: 이용권 횟수를 모두 썼을 때 
	if(mymembership.getCount() <= 0) {
		response.sendRedirect("personalRegisterForm.jsp?lessonNo=" + lessonNo+ "&err=fail2");
		return;
	}
			// 상태를 변경(만료)
	if(lesson.getQuota() == lesson.getReqCnt()) {
		lesson.setStatus("E");
	}
		
	// 로직수행
		// 예약 객체에 담기 
	Reservation reservation = new Reservation();
	reservation.setLesson(new Lesson(lessonNo));
	reservation.setUser(new User(loginId));
	
		// 예약테이블 db에 저장
	PersonalReservationDao personalReservationDao = PersonalReservationDao.getInstance();
	personalReservationDao.insertPersonalReservation(reservation);
	
		// 강좌테이블에 신청자수 +1 
	PersonalLessonDao personalLessonDao = PersonalLessonDao.getinstance();
	lesson.setReqCnt(lesson.getReqCnt()+1);
	personalLessonDao.updatePersonalLesson(lesson);

		// 내 멤버쉽 테이블에 cnt -1
	
		mymembership.setCount(mymembership.getCount()-1);
			// 변경내역 업데이트 하기
		mymemDao.updateMymembershipByIdAndNo(mymembership);

			
	// 재요청 url
	response.sendRedirect("personalList.jsp");
%>