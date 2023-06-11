<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 로그인 정보 조회
	String loginId = (String)session.getAttribute("loginId");
	String loginType = (String)session.getAttribute("loginType");
	int gymNo = Integer.parseInt((String) session.getAttribute("loginGymNo"));

	// 로직수행
	
	
%>
