<%@page import="dao.GymDao"%>
<%@page import="vo.Gym"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String locationName = request.getParameter("locationName");
	String tel = request.getParameter("tel");
	String name = request.getParameter("name");
	//유저 객체 생성 후 입력값 객체 저장
	Gym gym = new Gym();
	gym.setLocationName(locationName);
	gym.setTel(tel);
	gym.setName(name);
	
	
	GymDao gymDao = GymDao.getinstance();
	
	//똑같은 이름이 있는지 비교
	if(gymDao.getGymByName(name) != null){
		response.sendRedirect("form.jsp?err=name");
		return;
	}
	gymDao.insertGym(gym);
	
	response.sendRedirect("list.jsp");
	

%>