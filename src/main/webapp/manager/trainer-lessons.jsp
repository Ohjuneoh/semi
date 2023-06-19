<%@page import="com.google.gson.Gson"%>
<%@page import="vo.Lesson"%>
<%@page import="java.util.List"%>
<%@page import="dao.TrainerDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 1. 요청 파라미터 값 조회
	String userId = request.getParameter("id");
	String lessonType = request.getParameter("type");

	
	// 2. 수업 조회하기 
	TrainerDao trainerDao = TrainerDao.getInstance();
	// 선생님별 수업 목록을 조회한다.
	List<Lesson> lessonList = trainerDao.getAllLessonsByTrainerId(userId, lessonType);
		
	// json 형식의 텍스트로 변환하기
	Gson gson = new Gson();
	String text = gson.toJson(lessonList);
	
	// 텍스트를 응답으로 보내기
	out.write(text);

%>