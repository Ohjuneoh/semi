<%@page import="vo.Membership"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<%
	// 1. 요청 파라미터 조회

		String cat = request.getParameter("cat");
		String type = request.getParameter("type");
		String name = request.getParameter("name");
		String description = request.getParameter("description");
		int price = Integer.parseInt(request.getParameter("price"));
		int discountedRate1 = Integer.parseInt(request.getParameter("discountedRate"));
		//작동되는지 확인 
		double discountedRate = discountedRate1/100;
		int numOfUseDay = Integer.parseInt(request.getParameter("numOfUseDay"));
		int numOfUseWeek = Integer.parseInt(request.getParameter("numOfUseWeek"));
		int numOfPause = Integer.parseInt(request.getParameter("numOfPause"));
		int duration1 = Integer.parseInt(request.getParameter("duration1"));
		String duration2 = request.getParameter("duration2");
		//작동되는지 확인 
		//이용권 기간 
		String duration = Integer.toString(duration1) + duration2;
		int membershipCnt= Integer.parseInt(request.getParameter("membershipCnt"));
		
	
	// 2. 로그인 아이디 조회
	
	// 3. 관리자인지 확인 
	
	// 4. 업무로직 수행
	Membership membership = new Membership();
	membership.setCat(cat);
	membership.setType(type);
	membership.setName(name);
	membership.setDescription(description);
	membership.setPrice(price);
	membership.setDiscountedRate(discountedRate);
	membership.setNumOfUseDay(numOfUseDay);
	membership.setNumOfUseWeek(numOfUseWeek);
	membership.setDuration(duration);
	membership.setCount(membershipCnt);
	
	
	// 5. 재요청 url 응답
	response.sendRedirect("membershipList.jsp");
 		

%>
