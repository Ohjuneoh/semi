<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");	

%>

<!doctype html>
<html lang="ko">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name="menu" value="관리자"/>
</jsp:include>
<div class="container">
	<div class="row mb-3">
    	<div class="col-12">
        	<h1 class="border bg-light fs-4 p-2">이용권 등록하기</h1>
      	</div>
   	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>이용권의 종류 및 속성을 설정하여 이용권을 등록하실 수 있습니다.</p>
			<div class="border bg-light p-3">
				<form class="row g-3" method="post" action="membership-insert.jsp">
	 				<div class="col-md-12">
						<label class="form-label">이용권 종류</label>
						<div>
							<div class="form-check form-check-inline">
		  						<input class="form-check-input" type="radio" name="type"  value="개인레슨" checked="checked">
		  						<label class="form-check-label" >개인레슨</label>
							</div>
							<div class="form-check form-check-inline">
		  						<input class="form-check-input" type="radio" name="type" value="그룹수업">
		  						<label class="form-check-label" >그룹수업</label>
							</div>
							<div class="form-check form-check-inline">
		  						<input class="form-check-input" type="radio" name="type" value="시설이용">
		  						<label class="form-check-label" >시설이용</label>
							</div>
							<div class="form-check form-check-inline">
		  						<input class="form-check-input" type="radio" name="type" value="옵션이용">
		  						<label class="form-check-label" >옵션이용</label>
							</div>
						</div>
					</div>
					<div class="col-md-12">
						<label class="form-label">이용권 속성</label>
						<div>
							<div class="form-check form-check-inline">
		  						<input class="form-check-input" type="radio" name="cat"  value="기간제" checked="checked">
		  						<label class="form-check-label" >기간제</label>
							</div>
							<div class="form-check form-check-inline">
		  						<input class="form-check-input" type="radio" name="cat" value="횟수제">
		  						<label class="form-check-label" >횟수제</label>
							</div>
						</div>
					</div>
	 				<div class="col-md-12">
						<label class="form-label">이용권 이름</label>
						<input type="text" class="form-control" id="name" name = "title">
					</div>
					<div class="col-md-12">
						<label class="form-label">이용권 설명</label>
						<textarea rows="3" class="form-control" name="description"></textarea>
					</div>
					<div class="col-md-6">
						<label class="form-label">이용권 판매가</label>
						<div class="d-flex justify-content-start">
						<input type="text" class="form-control w-75" name = "price" />
						<span class="ms-2 mt-1">원</span> 
						</div>
					</div>
					<div class="col-md-6">
						<label class="form-label">이용권 할인률</label>
						<div class="d-flex justify-content-start">
						<input type="text" class="form-control w-75" name = "discountedRate" />
						<span class="ms-2 mt-1">%</span>
					    </div>
					</div>
					<div class="col-md-6">
						<label class="form-label">이용기간</label>
						<input type="text" class="form-control" name = "duration1" >
					</div>
					<div class="col-md-6">
						<label class="form-label"><br></label>
						<select class="form-select" name="duration2">
	   						<option value="일">일</option>
	   						<option value="개월">개월</option>
	   						<option value="년">년</option>
	   					</select>
					</div>
					<div class="col-md-6">
						<label class="form-label">일일 이용 횟수</label>
						<select class="form-select" name="numOfUseDay">
	   						<option value="1">1</option>
	   						<option value="2">2</option>
	   						<option value="3">3</option>
	   						<option value="-1">무제한</option>
	   					</select>
					</div>
					<div class="col-md-6">
						<label class="form-label">주간 이용 횟수</label>
						<select class="form-select" name="numOfUseWeek">
	   						<option value="1">1</option>
	   						<option value="2">2</option>
	   						<option value="3">3</option>
	   						<option value="4">4</option>
	   						<option value="5">5</option>
	   						<option value="-1">무제한</option>
	   					</select>
					</div>
					<div class="col-md-6">
						<label class="form-label">이용권 사용 가능 횟수</label>
						<select class="form-select" name="membershipCnt">  						
							<option value="1">1</option>
	   						<option value="2">2</option>
	   						<option value="5">5</option>
	   						<option value="10">10</option>
	   						<option value="15">15</option>
	   						<option value="20">20</option>
	   						<option value="25">25</option>
	   						<option value="30">30</option>
	   						<option value="-1">무제한</option>
	   					</select>
					</div>
					<div class="col-md-6">
						<label class="form-label">이용권 중지 가능 기간</label>
						<div class="d-flex justify-content-start">
						<input type="text" class="form-control w-75" name = "numOfPause" />
						<span class="ms-2 mt-1">일</span> 
						</div>
					</div>	
					<div class="text-end">
						<button type="submit" class="btn btn-primary btn-sm">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>