<%@page import="vo.Trainer"%>
<%@page import="dao.UserDao"%>
<%@page import="vo.Gym"%>
<%@page import="vo.User"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String type = request.getParameter("type");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String tel = request.getParameter("tel");
	//유저 객체 생성 후 입력값 객체 저장
	User user = new User();
	user.setType(type);
	user.setId(id);
	user.setPassword(password);
	user.setName(name);
	user.setEmail(email);
	user.setTel(tel);
	
	UserDao userDao = UserDao.getinstance();
	
	//똑같은 아이디가 있는지 비교
		if(userDao.getUserById(id) != null){
			response.sendRedirect("form.jsp?err=id");
			return;
		}
		//똑같은 이메일이 있는지 비교
		if(userDao.getUserByEmail(email) != null){
			response.sendRedirect("form.jsp?err=email");
			return;
		}
	//유저 테이블 insert
	userDao.insertManager(user);

	
	
	
	response.sendRedirect("../home.jsp");
	

%>