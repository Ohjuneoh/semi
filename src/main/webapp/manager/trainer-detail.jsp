<%@page import="dao.UserDao"%>
<%@page import="vo.Trainer"%>
<%@page import="vo.Lesson"%>
<%@page import="java.util.List"%>
<%@page import="dao.TrainerDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	TrainerDao trainerDao = TrainerDao.getInstance();
	String userId = request.getParameter("userId");	
	Trainer trainer = trainerDao.getTrainerDetails(userId);
	
	
%> 
<!doctype html>
<html lang="ko">
<head>
<title>강사상세정보</title>
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
        	<h1 class="border bg-light fs-4 p-2"><%=trainer.getUser().getName() %>강사의 개인정보</h1>
      	</div>
   	</div>
<div class="row mb-3">
		<div class="col-12">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<th class="table-dark" style="width: 15%;">이름/직책</th>
						<td style="width: 35%;"><%=trainer.getUser().getName()%>/<%=trainer.getPosition() %></td>
						<th class="table-dark" style="width: 15%;">휴대폰번호</th>
						<td style="width: 35%;"><%=trainer.getUser().getTel()%></td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">등록일</th>
						<td style="width: 35%;"><%=trainer.getUser().getCreateDate() %></td>						

						<th class="table-dark" style="width: 15%;">이메일</th>
						<td style="width: 35%;"><%=trainer.getUser().getEmail()%></td>	
					</tr>
					<tr>					
						<th class="table-dark" style="width: 15%;">연봉</th>
						<td style="width: 35%;"><%=trainer.getSalary() %></td>
						<th class="table-dark" style="width: 15%;">커미션비율</th>
						<td style="width: 35%;"><%=trainer.getCommissionPct() %></td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">상태</th>
<%
	if("Y".equals(trainer.getUser().getStatus())){
%>
						<td style="width: 35%;">재직중</td>
<%
} 	else if("N".equals(trainer.getUser().getStatus())){
%>
						<td style="width: 35%;">퇴사</td>
<% } %>
<%
	if("N".equals(trainer.getUser().getStatus())){
%>
						<th class="table-dark" style="width: 15%;">퇴사일</th>
						<td style="width: 35%;"><%=trainer.getUser().getUpdateDate()%></td>
<% } else 
%>						<th class="table-dark" style="width: 15%;">퇴사일</th>
						<td style="width: 35%;"><%=trainer.getUser().getUpdateDate()%></td>
					</tr>
				</tbody>
			</table>
			<a href="trainer-modified-form?id=<%=userId %>"  class="btn btn-warning btn-sm">수정</a>
		</div>
	</div>
		<div class="row mb-3">
			<div class="col-12">
				<h3>담당 레슨 목록</h3>
	<div>
	<br>
	<label>레슨 종류</label>
	<select id="lessonType" onchange="refreshLessons();">
		<option value="" selected disabled> -- 선택하세요 -- </option>

		<option value="personal">개인레슨</option>
		<option value="group">그룹레슨</option>

	</select>
	</div>
		<table class="table" id="table-lessons">
			<thead>
				<tr>
					<th>레슨 번호</th>
					<th>레슨 이름</th>
					<th>레슨 정원</th>
					<th>레슨 신청자수</th>
					<th>레슨 시간</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
</div>
</div>
<script type="text/javascript">
	
	function refreshLessons(){
		//select 박스의 현재 선택된 값을 조회한다. 
		let lessonType = document.getElementById("lessonType").value;
		
		//ajax 통신하기
		// 1. XHMLHttpRequest 객체 생성하기
		let xhr = new XMLHttpRequest();
		// 2. XMLHttpRequest 객체에서 onreadystatechange 이벤트가 발생할 때 마다 실행할 함수 지정
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4) {
				// 1. 응답데이터 조회하기
				let data = xhr.responseText;
				// data -> '[{"id":100, "name":"개인"}, {"id":101, "name":"그룹"}]'
				
				// 2. 응답데이터(텍스트)를 객체(자바스크립트 객체 혹은 배열객체)로 변환하기
				let arr = JSON.parse(data);	// 
				// 3. 응답데이터로 html컨텐츠 생성하기
				let htmlContent = "";
				arr.forEach(function(item, index) {
					htmlContent += `
						<tr>
								<td>\${item.no}</td>
								<td>\${item.name}</td>
								<td>\${item.reqCnt}</td>
								<td>\${item.quota}</td>
								<td>\${item.time}</td>
						</tr>
					`;
				});
				// 4. 화면에 html 컨텐츠 반영시키기
				document.querySelector("#table-lessons tbody").innerHTML = htmlContent;
		}
	}
		// 3. XMLHttpRequest 객체 초기화하기(요청방식, 요청URL 지정)
		xhr.open("GET", "trainer-lessons.jsp?id=<%=userId%>&type=" +lessonType);
		// 4. 서버로 요청 보내기
		xhr.send(null);
	}
</script>
</body>
</html>