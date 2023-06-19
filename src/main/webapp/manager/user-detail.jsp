<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@page import="util.StringUtils"%>
<%@page import="java.util.List"%>
<%@page import="vo.MyMembership"%>
<%@page import="dao.MyMembershipDao"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String userId = request.getParameter("userId");
	
	// user정보 가져오기 
	UserDao userDao = UserDao.getinstance();
	User user = userDao.getUserById(userId);
	
%>
<!doctype html>
<html lang="ko">
<head>
<title>회원상세정보</title>
<style type="text/css">
.pretty-button {
    background-color: rgba(0, 0, 255, 0.5); 
    border: none;
    color: white;
    padding: 7px 14px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    transition-duration: 0.4s;
    cursor: pointer;
    border-radius: 12px;
}

.pretty-button:hover {
    background-color: white; 
    color: black; 
    border: 2px solid rgba(0, 0, 255, 0.5);
 
}
.button-container {
    display: flex;
    justify-content: center;
}

}

</style>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name="menu" value="회원&강사조회"/>
</jsp:include>
<div class="container">
	<div class="row mb-3">
    	<div class="col-12">
        	<h1 class="border bg-light fs-4 p-2"><%=user.getName() %>회원님의 개인정보</h1>
      	</div>
   	</div>
	<div class="row mb-3">
		<div class="col-12">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<th class="table-dark" style="width: 15%;">이름</th>
						<td style="width: 35%;"><%=user.getName()%></td>
						<th class="table-dark" style="width: 15%;">휴대폰번호</th>
						<td style="width: 35%;"><%=user.getTel()%></td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">등록일</th>
						<td style="width: 35%;"><%=user.getCreateDate() %></td>						

						<th class="table-dark" style="width: 15%;">이메일</th>
						<td style="width: 35%;"><%=user.getEmail()%></td>	
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">상태</th>
						<td style="width: 35%;"><%=user.getStatus() %></td>
<%
	if("N".equals(user.getStatus())){
%>
						<th class="table-dark" style="width: 15%;">탈퇴일</th>
						<td style="width: 35%;"><%=user.getUpdateDate()%></td>
<% } else 
%>						<th class="table-dark" style="width: 15%;"></th>
						<td style="width: 35%;"></td>
					</tr>
				</tbody>
			</table>
<%
	//해당 user의 이용권 정보 가져오기 
	
	MyMembershipDao myMembershipDao = MyMembershipDao.getInstance();
	List<MyMembership> myMembershipList = myMembershipDao.getUsersMemberships(userId);

%>
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">이용권 내역</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">		
			<table class="table table-sm">
				<colgroup>
					<col width="5%">
					<col width="25%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>이용권이름</th>
						<th>이용권상태</th>
						<th>시작일</th>
						<th>만료일</th>
						<th>일시정지여부</th>
						<th>일시정지일</th>
						<th>재시작일</th> 
						<th>상세정보</th>
					</tr>
				</thead>
				<tbody>
<%
	int count = 1; 
	for(MyMembership myMembership : myMembershipList) {	
%>	
					<tr>
						<td><%= count++ %></td>
						<td><%=myMembership.getMembership().getName() %></td>
						<td><%=myMembership.getStatus() %></td>
						<td><%=myMembership.getStartDate() %></td>
						<td><%=myMembership.getExpirationDate() %></td>
<%
	if("P".equals(myMembership.getStatus())){
%>						<td>Y</td>
						<td><%=myMembership.getPauseDate() %></td>
						<td><%=myMembership.getRestartDate() %></td>
<%
	} else {			
%>						<td>N</td>
						<td>-</td>
						<td>-</td>
<%	}
%>											
						<td>
							<a href="user-membership-detail.jsp?my-membershipNo=<%=myMembership.getNo() %>&orderNo=<%=myMembership.getOrder().getNo()%>" class="btn btn-outline-dark btn-xs">상세정보</a>
						</td>
					</tr>				
<%
	}
%>
				</tbody>
			</table>
		</div>
	</div>
<%
	// 해당 user의 결제 내역 가져오기
	OrderDao orderDao = OrderDao.getinstance();
	List<Order> orderList = orderDao.getAllOfMyOrders(userId);
%>
	<div class="col-12">
	<h1 class="border bg-light fs-4 p-2">결제 내역</h1>
	</div>
	<div class="row mb-3">
		<div class="col-12">		
			<table class="table table-sm">
				<colgroup>
					<col width="10%">
					<col width="25%">
					<col width="20%">
					<col width="15%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>결제번호</th>
						<th>이용권이름</th>
						<th>이용권가격</th>
						<th>결제금액</th>
						<th>결제일</th>
						<th>결제수단</th>
						<th>결제상태</th>
					</tr>
				</thead>
				<tbody>
<%
	for(Order order : orderList) {	
%>	
					<tr>
						<td><%=order.getNo()%></td>
						<td><%=order.getMembership().getName() %></td>
						<td><%=order.getDiscountedPrice() %>원 &nbsp;&nbsp;<span class="text-decoration-line-through"><%=order.getMembership().getPrice() %></span>원</td>
						<td><%=order.getTotalCreditPrice()%>원</td>
						<td><%=order.getCreateDate() %></td>
						<td><%=order.getPaymentMethod() %></td>
						<td><%=order.getStatus() %>
					</tr>				
<%
	}
%>
				</tbody>
			</table>
		</div>
	</div>



		<div class="text-end">
				<a href="user-list.jsp" class="pretty-button" class="button-container">목록</a>
			</div>
</div>
</div>
</body>
</html>