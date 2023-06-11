<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 로그아웃 처리
	session.invalidate();
	
	response.sendRedirect("home.jsp");
%>