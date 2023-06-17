<%@page import="dao.AddressDao"%>
<%@page import="vo.Address"%>
<%@page import="vo.Trainer"%>
<%@page import="dao.UserDao"%>
<%@page import="vo.Gym"%>
<%@page import="vo.User"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String type = request.getParameter("type");
	String position = request.getParameter("position");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String tel = request.getParameter("tel");
	int gymNo = Integer.parseInt(request.getParameter("gymNo"));
	int post= Integer.parseInt(request.getParameter("post"));
	String streetName = request.getParameter("streetName");
	String detailAdd= request.getParameter("detailAdd");
	//유저 객체 생성 후 입력값 객체 저장
	User user = new User();
	user.setType(type);
	user.setId(id);
	user.setPassword(password);
	user.setName(name);
	user.setEmail(email);
	user.setTel(tel);
	user.setGym(new Gym(gymNo));
	//트레이너 객체 생성 후 입력값 객체 저장
	Trainer trainer = new Trainer();
	trainer.setUser(new User(id));
	trainer.setPosition(position);
	
	Address address = new Address();
	address.setUser(new User(id));
	address.setPostNo(post);
	address.setStreetName(streetName);
	address.setDetailAddress(detailAdd);
	
	
	UserDao userDao = UserDao.getinstance();
	AddressDao addressDao = AddressDao.getInstance();
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
	userDao.insertUser(user);
	//트레이너 테이블 insert
	userDao.insertTrainer(trainer);
	//주소 테이블 insert
	addressDao.insertAddress(address);
	
	
	
	response.sendRedirect("../home.jsp");
	

%>