<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 1. 파라미터 조회
	
	// 로그인상태에서 전달받은 값
	String loginId = (String)session.getAttribute("loginId");
	String type = (String)session.getAttribute("type");

	// 트레이너가 입력한 값
	String lessonName = request.getParameter("lessonName");
	String trainerName = request.getParameter("trainerName");
	int quota = Integer.parseInt(request.getParameter("quota"));
	String time = request.getParameter("time");
	String healthNo = request.getParameter("healthNo");
	String description = request.getParameter("description");
	
	// 2. 로직수행
	
	

%>
