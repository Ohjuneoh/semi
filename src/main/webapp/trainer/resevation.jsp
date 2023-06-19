<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="vo.Reservation"%>
<%@page import="java.util.List"%>
<%@page import="dto.Pagination"%>
<%@page import="dao.UserDao"%>
<%@page import="dao.GroupReservationDao"%>
<%@ page contentType="application/json; charset=utf-8" pageEncoding="utf-8" %>
<%
//로그인정보 조회
String loginId = (String)session.getAttribute("loginId");
String loginType = (String)session.getAttribute("loginType");

String lessonType = request.getParameter("lessonType");
int pageNo = Integer.parseInt(request.getParameter("page"));


// 오류상황
	// 로그인이 되지 않았을 경우
	// 로그인 타입이 강사가 아닌경우 


// 로직수행(강사의 전체 회원목록 조회)
GroupReservationDao reservDao = GroupReservationDao.getInstance();
UserDao userDao = UserDao.getinstance();
int totalRows = userDao.getMyUserListTotalRows(loginId, lessonType);
Pagination pagination = new Pagination(pageNo, totalRows);

List<Reservation> reservList = userDao.getMyUserByTrainerIdLessonType(loginId, lessonType, pagination.getBegin(), pagination.getEnd());

Map<String, Object> map = new HashMap<>();
map.put("rows", totalRows);
map.put("paging", pagination);
map.put("reserve", reservList);

Gson gson = new Gson();
String jsonText = gson.toJson(map);

out.write(jsonText);



%>