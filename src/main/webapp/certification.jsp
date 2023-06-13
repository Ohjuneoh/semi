<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 로그인처리
	//1. 요청 파라미터값 읽기
	String loginId = (String)session.getAttribute("loginId");
	String password = request.getParameter("password"); //입력한 비밀번호
	
	UserDao userDao = UserDao.getinstance();
	//2.아이디를 기준으로 유저정보를 찾아서 객체에 저장
	User user = userDao.getUserById(loginId);
	//3. 조회된 정보를 확인하기 위한 변수 생성
	
	String dbPassword = user.getPassword();
	

	//4. 비밀번호가 일치하는지 체크하기
	if (!dbPassword.equals(password)) {
	     response.sendRedirect("certificationForm.jsp?err=fail");
	     return;
	   }
	
	response.sendRedirect("user/modifyForm.jsp");
%>