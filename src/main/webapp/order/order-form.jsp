<%@page import="java.util.List"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@page import="vo.Membership"%>
<%@page import="dao.MembershipDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	int membershipNo = Integer.parseInt(request.getParameter("membershipNo"));
	MembershipDao membershipDao = MembershipDao.getInstance();
	Membership membership = membershipDao.getMembershipDetailByNo(membershipNo);
	UserDao userDao = UserDao.getinstance();
	List<User> userList = userDao.getUserByType("trainer");

%>
<!doctype html>
<html lang="ko">
<head>
<title>주문/결제</title>
<style>
  .title {
    color: rgba(0, 0, 255, 0.5);
    font-weight: bold;
  }
  
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
</style>
<style>
  .trendy-button {
    display: inline-block;
    padding: 7px 14px; 
    border: none;
    border-radius: 20px;
    background-color: rgba(0, 0, 255, 0.5);
    color: #fff;
    font-size: 14px; 
    cursor: pointer;
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
        	<h1 class="border bg-light fs-4 p-2">주문/결제</h1>
      	</div>
   	</div>
 	<div class="row mb-3">
 		<div class="col-12">
			<form  id="form-order" class="row g-3" method="post" action="order-insert.jsp?membershipNo=<%=membershipNo %>">
				<div class="col-12">
					<h3 class="border bg-light fs-5 p-2">주문 이용권 </h3>
					<div class="border bg-light p-3">
			 				<div class="col-md-12">
								<label class="form-label title">이용권 이름</label>
								 <input type="text" class="form-control" name="membershipName" value="<%=membership.getName() %>" disabled>
							</div>
							<br>
							<div class="col-md-12">
								<label class="form-label title">이용권 시작일</label>
								<input type="date" class="form-control w-50" name="membershipStartDate">
							</div>
							<br>
							<div class="col-md-6">
								<label class="form-label title">이용권 금액</label>
								<div class="d-flex justify-content-start">
								<input type="text" class="form-control w-75" name = "price" value="<%=membership.getPrice() %>" disabled />
								<span class="ms-2 mt-1">원</span> 
							</div>
							</div>
							<br>
							<div class="col-md-6">
		  						<label class="form-label title">핫딜 할인</label>
		  						<div class="d-flex justify-content-start">
		   						<input type="text" class="form-control w-75" name="discountedPrice" value="<%=membership.getDiscountedPrice() %>" style="color: red; font-weight: bold;" />
		   					 	<span class="ms-2 mt-1">원</span>
		  						</div>
							</div>
							<br>
							<div class="col-md-12">
		  						<label class="form-label title">쿠폰 할인</label>
		  						<div class="d-flex justify-content-start">
		   						<input type="text" class="form-control w-75" name="coupon" placeholder='쿠폰 적용이 불가한 상품입니다' disabled />
		   						&nbsp;&nbsp;
		   						<button type="button" class="trendy-button" onclick="return false;">쿠폰 조회/적용</button>
		  						</div>
							</div>
							<br>
							<div class="col-md-12">
		  						<label class="form-label title">포인트 할인</label>
		  						<button type="button" class="trendy-button" onclick="return false;">전액사용</button>
		  						<br>
		  						<div class="d-flex justify-content-start">
		   						<input type="text" class="form-control w-75" name="usedPoint" value="0"/>
		   						<span class="ms-2 mt-1">P</span>
		   						&nbsp;&nbsp;
		  						</div>
							</div>
							<br>
							<div class="col-md-6">
		  						<label class="form-label title"> &#x2665; 구매를 추천한 강사님</label>
		  						<select class="form-select" name="bestTrainer">
		  							    <option value="없음">없음</option>
		<%
			for(User user : userList ){
		%>
		  								<option value="<%=user.getName()%>"><%=user.getName() %></option>
		 <%
			}
		 %>
		  							</select>
		  						</div>
		  						<br>
		  						<div class="col-md-12">
		  							<label class="form-label title">총 결제 금액</label>
		  							<div class="d-flex justify-content-start">
		   							<input type="text" class="form-control w-75" name="totalCreditPrice" value="<%=membership.getDiscountedPrice()%>" style=" font-weight: bold;" /> <!--  자세한 것은 추후 혹은 파이널 때 구현 -->
		   							<span class="ms-2 mt-1">원</span>
		   							&nbsp;&nbsp;
		  							</div>
								</div>
					</div>
				</div>
			
	
		      	<div class="col-12">
		        	<h3 class="border bg-light fs-5 p-2">결제수단</h3>
		        	<div class="border bg-light p-3">
						<div>
							<div class="form-check form-check-inline">
		  						<input class="form-check-input" type="radio" name="paymentMethod"  value="신용카드" checked="checked">
		  						<label class="form-check-label" >신용카드</label>
							</div>
							<div class="form-check form-check-inline">
		  						<input class="form-check-input" type="radio" name="paymentMethod" value="간편결제">
		  						<label class="form-check-label" >간편결제</label>
							</div>
							<div class="form-check form-check-inline">
		  						<input class="form-check-input" type="radio" name="paymentMethod" value="계좌이체">
		  						<label class="form-check-label" >계좌이체</label>
							</div>
							<div class="form-check form-check-inline">
		  						<input class="form-check-input" type="radio" name="paymentMethod" value="휴대폰결제">
		  						<label class="form-check-label" >휴대폰결제</label>
							</div>
						</div>
		        	</div>
		        </div>
			</form>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12 text-end">
			<button type="button" onclick="formsubmit();" class="pretty-button" class="button-container" style="font-size: 20px; padding: 10px 20px;">결제하기</button>
		</div>
	</div>
</div>
<script type="text/javascript">
	function formsubmit() {
		document.getElementById("form-order").submit();
	}
	
</script>
</body>
</html> 

   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
  