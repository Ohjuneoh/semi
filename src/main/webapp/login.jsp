<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 로그인처리
	//1. 요청 파라미터값 읽기
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	UserDao userDao = UserDao.getinstance();
	//2. 조회된 정보를 확인하기 위한 변수 생성
	boolean isExist = false;
	String dbPassword = null;
	//3.아이디를 기준으로 유저정보를 찾아서 객체에 저장
	User user = userDao.getUserById(id);
	//4. 아이디에 맞는 유저정보 조회하기
	if (user != null) {
         isExist = true;
         dbPassword = user.getPassword();
      }
	//5. 정보가 존재하는지 체크하기
	if (!isExist) {
	     response.sendRedirect("loginform.jsp?err=fail");
	     return;
	   }
	//6. 비밀번호가 일치하는지 체크하기
	if (!dbPassword.equals(password)) {
	     response.sendRedirect("loginform.jsp?err=fail");
	     return;
	   }
	//7. 조회된 유저의 Type, gymNo를 세션객체에 저장하기 위해 호출
	String type = user.getType();
	String gymNo = Integer.toString(user.getGym().getNo());
	//7. 사용자 인증이 완료되면 세션에 로그인타입과 로그인아이디를 저장하기
	session.setAttribute("loginType", type);
	session.setAttribute("loginId", id);
	session.setAttribute("loginGymNo", gymNo);
	
	response.sendRedirect("home.jsp");
%>