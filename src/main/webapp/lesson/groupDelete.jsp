<%@page import="vo.Lesson"%>
<%@page import="dao.GroupeLessonDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 로그인 정보 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");
	
	int lessonNo = Integer.parseInt(request.getParameter("lessonNo"));
	
	// 오류사항 : 로그인 상태가 아니거나, 강사가 아닌 다른 유형일때 삭제불가능
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("그룹레슨 삭제", "utf-8"));
		return;
	}
	if(!"trainer".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=userdeny&job=" + URLEncoder.encode("그룹레슨 삭제", "utf-8"));
		return;
	}
	
	// 오류사항 : 본인이 올린 강좌가 아니면 삭제불가능
	GroupeLessonDao groupDao = GroupeLessonDao.getinstance();
	Lesson groupLesson = groupDao.getGroupLessonByLessonNo(lessonNo);
	
	if(!loginId.equals(groupLesson.getUser().getId())) {
		response.sendRedirect("groupList.jsp?err=fail") ;
		return;
	}
	
	// 로직수행(삭제)
	GroupeLessonDao groupDao2 = GroupeLessonDao.getinstance();
	groupDao2.deleteGroupLesson(lessonNo);
	
	// 재요청 url
	response.sendRedirect("groupList.jsp");
	
%>