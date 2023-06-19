<%@page import="vo.MyMembership"%>
<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
		String userId = (String) session.getAttribute("loginId");
		int orderNo = (int) session.getAttribute("orderNo");
		
		OrderDao orderDao = OrderDao.getinstance();
		MyMembership myMembership = orderDao.getmyOrderDetail(userId, orderNo);
	
%>
<!doctype html>
<html lang="ko">
<head>
<title></title>
<style type="text/css">
.pretty-button {
    background-color: rgba(0, 0, 255, 0.5); /* Green */
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
<style type="text/css">
	.btn.btn-xs {--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;}
</style>
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name="menu" value="이용권"/>
</jsp:include>
<div class="container">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">주문완료</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>주문 완료! 신나게 운동해서 건강도 챙기고 같이 운동해서 운동 친구도 만들어요~! </p>
			<table class="table">
				<thead>
					<tr class="table-dark">
						<th style="width: 7%;">주문번호</th>
						<th style="width: 20%;">주문 상품</th>
						<th style="width: 13%;">가격</th>
						<th style="width: 20%;">이용 기간</th>
						<th style="width: 15%;">결제수단</th>
					</tr>	
				</thead>
				<tbody>
			
					<tr>
						<td><%=myMembership.getOrder().getNo()%></td>
						<td><%=myMembership.getMembership().getName()%></td>
						<td> <strong class="text-danger"><%=myMembership.getOrder().getTotalCreditPrice() %></strong>&nbsp;&nbsp;<span class="text-decoration-line-through"><%=myMembership.getMembership().getPrice()%></span>원</td>
						<td><%=myMembership.getStartDate()%> ~ <%=myMembership.getExpirationDate() %></td>
						<td><%=myMembership.getOrder().getPaymentMethod() %></td>
					</tr>
			
				</tbody>
			</table>
				<div class="button-container">
					<a href="../membership/membershipList.jsp">
						<button class="pretty-button">이용권 목록</button>
					</a>
				</div>
		</div>
	</div>
</div>
</body>
</html>