<%@page import="java.text.ParseException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="vo.User"%>
<%@page import="vo.Membership"%>
<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 1. 요청 파라미터 조회
	int membershipNo = Integer.parseInt(request.getParameter("membershipNo"));
	int discountedPrice = Integer.parseInt(request.getParameter("discountedPrice"));
	int usedPoint = Integer.parseInt(request.getParameter("usedPoint"));
	int totalCreditPrice = Integer.parseInt(request.getParameter("totalCreditPrice"));
	String paymentMethod = request.getParameter("paymentMethod");
	String userId = (String) session.getAttribute("loginId");
	String dateString = request.getParameter("membershipStartDate");
	

	
	// 2. 로그인 아이디 조회
	
	// 3. 회원인지 확인 
		
	// 4. 업무로직 수행
	Order order = new Order();
	Membership membership = new Membership();
	membership.setNo(membershipNo);
	order.setMembership(membership);
	order.setDiscountedPrice(discountedPrice);
	order.setUsedPoint(usedPoint);
	order.setTotalCreditPrice(totalCreditPrice);
	order.setStatus("결제완료");
	order.setPaymentMethod(paymentMethod);
	User user = new User();
	user.setId(userId);
	order.setUser(user);
	
	OrderDao orderDao = OrderDao.getinstance();
	int orderNo = orderDao.getGeneratedOrderNo();
	order.setNo(orderNo);
	orderDao.insertOrder(order);
	
	
	session.setAttribute("orderNo", orderNo);
	session.setAttribute("dateString", dateString);
	session.setAttribute("membershipNo", membershipNo);
	
	// 5. 재요청 url 전달
	response.sendRedirect("../my-membership/my-membership-insert.jsp");
	
	
	


%>