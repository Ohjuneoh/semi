<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="application/json; charset=utf-8" pageEncoding="utf-8" %>
<%
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	UserDao userDao = UserDao.getinstance();
	
	if(email==null){
	User user = userDao.getUserById(id);
	if(user== null || id.isEmpty()){
		out.write("{\"exist\":false}");
	}else {
		out.write("{\"exist\":true}");
	}
	} else{
		User user = userDao.getUserByEmail(email);
		if(user== null){
			out.write("{\"exist\":false}");
		}else {
			out.write("{\"exist\":true}");
		}
	}
	

%>