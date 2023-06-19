<%@page import="dao.MyMembershipDao"%>
<%@page import="vo.Order"%>
<%@page import="vo.User"%>
<%@page import="vo.MyMembership"%>
<%@page import="java.time.LocalDate"%>
<%@page import="vo.Membership"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="dao.MembershipDao" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	
	// 1. 요청 파라미터 조회
	int orderNo = (int) session.getAttribute("orderNo");
	
	//만료일 기간 계산하기 
	String membershipStartDate1 = (String) session.getAttribute("dateString");
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	Date membershipStartDate = null; 
	try {
    	membershipStartDate = dateFormat.parse(membershipStartDate1);
    
	} catch (ParseException e) {
    e.printStackTrace();}
	
	LocalDate MymembershipExpirationDate = null;
	String userId = (String) session.getAttribute("loginId");
	int membershipNo = (int) session.getAttribute("membershipNo");
	MembershipDao membershipDao =  MembershipDao.getInstance();
	Membership membership = membershipDao.getMembershipDetailByNo(membershipNo);
	int myMembershipCnt = membership.getCount();
	
	
	// 멤버쉽 기간 확인 
	String duration = membership.getDuration();
	// 각각 년/월/일로 분리 
	int year = Integer.parseInt(membershipStartDate1.substring(0,4));
	int month = Integer.parseInt(membershipStartDate1.substring(5,7));
	int day = Integer.parseInt(membershipStartDate1.substring(8,10));
	LocalDate date = LocalDate.of(year, month, day);
	

	//  기간별로 
	if(duration.contains("일")){
		String result1 = duration.substring(0, duration.length()-1);
		// 몇 일인지 duration1에 담기 
		int duration1 = Integer.parseInt(result1);

		// 만료일 계산하기  
		 MymembershipExpirationDate = date.plusDays(duration1);
		
		
	} else if(duration.contains("개월")){
		String result2 = duration.substring(0, duration.length()-2);
		int duration2 = (Integer.parseInt(result2));
				
		// 만료일 계산하기 
		MymembershipExpirationDate = date.plusMonths(duration2);
		
	} else if(duration.contains("년")){
		String result3 = duration.substring(0, duration.length()-1);
		int duration3 = (Integer.parseInt(result3));
		
		// 만료일 계산하기 
		MymembershipExpirationDate = date.plusYears(duration3);
	}
	
	
		
	// 4. 업무로직 수행
	MyMembership myMembership = new MyMembership();
	User user = new User();
	user.setId(userId);
	myMembership.setUser(user);
	myMembership.setMembership(membership);
	Order order = new Order();
	order.setNo(orderNo);
	myMembership.setOrder(order);
	myMembership.setCount(myMembershipCnt);
	myMembership.setStatus("Y");
	
	myMembership.setStartDate(membershipStartDate);
	myMembership.setExpirationDate(MymembershipExpirationDate);
	
	MyMembershipDao myMembershipDao = MyMembershipDao.getInstance();
	myMembershipDao.insertMyMembership(myMembership);
	
	// 5. 재요청 url 
	response.sendRedirect("../order/order-paymentComplete.jsp");
	
	
	
%>