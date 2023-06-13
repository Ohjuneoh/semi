<%@page import="vo.Gym"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	//요청 파라미터값 조회
	String loginId = (String)session.getAttribute("loginId");
	int gymNo = Integer.parseInt((String) session.getAttribute("loginGymNo"));
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	String tel = request.getParameter("tel");
	
	// 요청파라미터로 전달받은 상품번호로 상품정보 조회
	UserDao userDao = UserDao.getinstance();
	User user = userDao.getUserById(loginId);
	
	// 요청파라미터로 전달받은 수정된 회원정보를 User 객체에 저장해서 값을 덮어쓰기
	user.setName(name);
	user.setPassword(password);
	user.setEmail(email);
	user.setTel(tel);
	
	// 수정된 정보가 포함된 Product 객체를 전달해서 데이터베스에 반영시키기
	userDao.updateUser(user);
	
	//재요청 URL 응답
	response.sendRedirect("detail.jsp");
	
	
	
	
%>