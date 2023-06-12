<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	//요청 URL - http://localhost/app3/customer/disabled.jsp?id-xxx
			
	//요청 파라미터 값 조회
	String id = request.getParameter("id");

	//요청 파라미터로 전달받은 아이디에 해당하는 고객정보를 조회하기
	
	//고객정보의 disabled를 "Yes"로 변경한다.
	UserDao userDao = UserDao.getinstance();
	
	User user = userDao.getUserById(id);
	
	//고객정보의 disabled를 "Yes"로 변경한다.
	user.setStatus("Y");
	
	//변경된 고객정보를 테이블에 반영시킨다.
	userDao.updateUser(user);
	
	//list.jsp를 재요청하는 응답을 보낸다.
	response.sendRedirect("detail.jsp");
%>

	




