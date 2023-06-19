<%@page import="java.net.URLEncoder"%>
<%@page import="vo.Trainer"%>
<%@page import="dao.TrainerDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 관리자, 강사 아이디 조회하기 
	String userId = request.getParameter("id");
	String managerId = (String) session.getAttribute("loginId");
	// 관리자만 접근할 수 있도록 
	if(managerId == null) {
	response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("정보 수정", "utf-8"));
	return;
}
	
	TrainerDao trainerDao = TrainerDao.getInstance();
	Trainer trainer = trainerDao.getTrainerDetails(userId);
	
	

%>
<!doctype html>
<html lang="ko">
<head>
<title>강사상세정보수정</title>
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
        	<h1 class="border bg-light fs-4 p-2"><%=trainer.getUser().getName() %>강사의 개인정보 수정 화면</h1>
      	</div>
   	</div>
<div class="row mb-3">
		<div class="col-12">
			<form class="border bg-light p-3" method="post" action="modify.jsp" onsubmit="return modify();">
			<input type="hidden" name="userId" value="<%=userId %>" />
			<table class="table table-bordered">
				<tbody>
					<tr>
						<th class="table-dark" style="width: 15%;">이름/직책</th>
						<td style="width: 35%;"><%=trainer.getUser().getName()%>/
							<input type="text" class="form-control" id="position" name="position" value="<%=trainer.getPosition() %>" />
						</td>
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
						<td>
						<input style="width: 35%" type="text" class="form-control" id="salary" name="salary" value="<%= trainer.getSalary()%>" />
						</td>
						<th class="table-dark" style="width: 15%;">커미션비율</th>
						<td>
						<input style="width: 35%" type="text" class="form-control" id="commissionPct" name="commissionPct" value="<%= trainer.getCommissionPct()%>" />
						</td>
					</tr>
					<tr>
						<th class="table-dark" style="width: 15%;">상태</th>
						<td style="width: 15%;">
							<select>
								<option value="재직중">재직중</option>
								<option value="퇴사">퇴사</option>
							</select>
						</td>
						<th class="table-dark" style="width: 15%;">퇴사일</th>
						<td style="width: 35%;"></td>
					</tr>
				</tbody>
			</table>
			<a href="trainer-modified-form"  class="btn btn-warning btn-sm">수정</a>
	</form>
		</div>
	</div>
	</div>
	</body>
	</html>
		