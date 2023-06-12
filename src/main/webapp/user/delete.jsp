<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	//요청 URL = http://localhost/app3/customer/delete.jsp?id=xxx
	//요청파라미터값 조회
	String loginType = (String) session.getAttribute("loginType");
	String id = request.getParameter("id");
	
	//요청 파라미터로 전달받은 고객아이디에 해당하는 고객정보를 삭제하다.
	
	UserDao userDao = UserDao.getinstance();
	
	User user = userDao.getUserById(id);
	if("Y".equals(user.getStatus())){ //사용중인 고객인지 체크
		response.sendRedirect("detail.jsp?id="+id+"&err=fail");
		return;
	}
	if("user".equals(loginType)){
		userDao.deleteUserById(id);
	}
	if("trainer".equals(loginType)){
		userDao.deleteTrainerById(id);
		userDao.deleteUserById(id);
	}
	
	session.invalidate();
	response.sendRedirect("../home.jsp");
%>	