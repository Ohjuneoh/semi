<%@page import="org.eclipse.jdt.internal.compiler.batch.Main"%>
<%@page import="vo.Membership"%>
<%@page import="dao.MembershipDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	String logintType = (String) session.getAttribute("loginType");
	
	int membershipNo = Integer.parseInt(request.getParameter("membershipNo"));
	
	MembershipDao membershipDao = MembershipDao.getInstance();
	Membership membership = membershipDao.getMembershipDetailByNo(membershipNo);
	
	
	
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
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name="menu" value="이용권"/>
</jsp:include>
<div class="container">
	<div class="row mb-3">
    	<div class="col-12">
        	<h1 class="border bg-light fs-4 p-2">이용권 상세 정보</h1>
      	</div>
   	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>이용권 상세정보를 확인하세요</p>
			<table class="table table-bordered">
				<tbody>
					<tr>
						<th class="table-dark" style="width: 15%;">이용권 속성</th>
						<td style="width: 35%;"><%=membership.getCat()%></td>
						<th class="table-dark" style="width: 15%;">이용권 종류</th>
<%
	if("PL".equals(membership.getType())){
%>
						<td style="width: 35%;">개인레슨</td>
 <%
	} else if("GL".equals(membership.getType())){
 %> 					<td style="width: 35%;">그룹레슨</td>
 <%
	} else if("Health".equals(membership.getType())){
 %>						<td style="width: 35%;">시설이용</td>
 <%
	} else if("Option".equals(membership.getType())){
 %>						<td style="width: 35%;">옵션이용</td>
 <% }
 %>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">일일 이용 횟수</th>
<% if(-1 != membership.getNumOfUseDay()){		
%>						<td style="width: 35%;"><%=membership.getNumOfUseDay() %>회</td>						
<% } else if(-1 == membership.getNumOfUseDay()){
%>						<td style="width: 35%;">무제한</td>	
<%
}
%>
						<th class="table-dark" style="width: 15%;">주간 이용 횟수</th>
<% if(-1 != membership.getNumOfUseWeek()){		
%>						<td style="width: 35%;"><%=membership.getNumOfUseWeek()%>회</td>						
<% } else if(-1 == membership.getNumOfUseWeek()){
%>						<td style="width: 35%;">무제한</td>	
<%
}
%>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">이용권 이름</th>
						<td style="width: 35%;"><%=membership.getName() %></td>
						<th class="table-dark" style="width: 15%;">이용권 가격</th>
						<td style="width: 35%;"><strong class="text-danger"><%=membership.getDiscountedPrice()+"원" %></strong>&nbsp;&nbsp;<span class="text-decoration-line-through"><%=membership.getPrice()%></span>원</td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">이용권 상세 정보</th>
						<td style="width: 85%; height: 100px;" colspan="3"><%=membership.getDescription() %></td>
					</tr>
				</tbody>
			</table>

			<div class="text-end">
				<a href="membershipList.jsp" class="pretty-button" class="button-container">목록</a>
<%
	if("user".equals(logintType)){
%>
				<a href="../order/order-form.jsp?membershipNo=<%=membershipNo%>"  class="pretty-button" class="button-container">구매하기</a>
<%
	}
%>
			</div>

		</div>
	</div>
</div>
</body>
</html>