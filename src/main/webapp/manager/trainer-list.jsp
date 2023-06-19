<%@page import="vo.Trainer"%>
<%@page import="util.Pagination"%>
<%@page import="util.StringUtils"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	UserDao userDao = UserDao.getinstance();
	int pageNo = StringUtils.stringToInt(request.getParameter("page"), 1);	
	String opt = StringUtils.nullToBlank(request.getParameter("opt"));
	String keyword = StringUtils.nullToBlank(request.getParameter("keyword"));
	
	List<Trainer> trainerList = null;
	Pagination pagination = null; 
	if(opt.isBlank() || keyword.isBlank()){
	int totalPages = userDao.getTotalPagesUserTrainers("trainer");	
	pagination = new Pagination(pageNo, totalPages);
	
	int begin = pagination.getBegin();
	int end = pagination.getEnd();
	trainerList = userDao.getAllTrainers(begin, end);
	
	} else {
		int totalPages = userDao.getTotalPagesByConditionTrainer(opt, keyword);
		pagination = new Pagination(pageNo, totalPages);
		
		int begin = pagination.getBegin();
		int end = pagination.getEnd();
		trainerList = userDao.getTrainersByCondition(begin, end, opt, keyword);
	}
	
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
<style type="text/css">
	.btn.btn-xs {--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;}
</style>
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name="menu" value="관리자 페이지"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
			<ul class="nav nav-tabs mb-3">
           		<li class="nav-item"><a class="nav-link" href="all-list">전체</a></li>
           		<li class="nav-item"><a class="nav-link" href="user-list.jsp">회원</a></li>
           		<li class="nav-item"><a class="nav-link active" href="trainer-list.jsp">강사</a></li>
			</ul>
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">강사 목록</h1>
		</div>
	</div>
	<div class="row mb-2">
		<div class="col-6">	
		</div>
	<div class="col-6 text-end">
			<form id="form-search" method="get" action="trainer-list.jsp" onsubmit="searchBooks(event);" class="row row-cols-lg-auto g-3 align-items-center justify-content-end">
				<input type="hidden" name="page" value="<%=pageNo %>">
				<div class="col-12">
					<select class="form-select form-control-sm" name="opt">
						<option value="" <%="".equals(opt) ? "selected" : "" %>>검색옵션</option>
						<option value="name" <%="name".equals(opt) ? "selected" : "" %>>이름</option>
						<option value="tel" <%="tel".equals(opt) ? "selected" : "" %>>전화번호</option>
						<option value="position" <%="tel".equals(opt) ? "selected" : "" %>>직급</option>
					</select>
				</div>
				<div class="col-12">
					<input type="text" class="form-control form-control-sm" name="keyword" value="<%=keyword %>" />
				</div>
				<div class="col-12">
					<button type="submit" class="btn btn-outline-dark btn-sm">검색</button>
 				</div>
			</form>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">		
			<table class="table table-sm">
				<colgroup>
					<col width="10%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>이름</th>
						<th>입사일</th>
						<th>상태</th>
						<th>이메일</th>
						<th>번호</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
<%
	int count = 1; 
	for(Trainer trainer : trainerList) {	
%>	
					<tr>
						<td><%=count++ %></td>
						<td><%=trainer.getUser().getName()%></td>
						<td><%=trainer.getUser().getCreateDate() %></td>				
<%
	if("Y".equals(trainer.getUser().getStatus())){
%>						<td>입사</td>
<%
	} else if("N".equals(trainer.getUser().getStatus())){
%>						<td>퇴사</td>
<% }
%>	
						<td><%=trainer.getUser().getEmail() %></td>
						<td><%=trainer.getUser().getTel() %>
						<td><a href="trainer-detail.jsp?userId=<%=trainer.getUser().getId()%>" class="btn btn-outline-dark btn-xs">상세정보</a></td>
					</tr>				
<%
	}
%>
				</tbody>
			</table>
	 	</div>
	</div>
<%
	if(!trainerList.isEmpty()) {
%>
			<div class="row mb-3">
				<div class="col-12">
					<nav>
						<ul class="pagination justify-content-center">
							<li class="page-item">
								<a class="page-link <%=pagination.isFirstPage() ? "disabled" : "" %>" 
									href="trainer-list.jsp?page=<%=pagination.getPageNo() - 1 %>"
									onclick="goPage(event, <%=pagination.getPageNo() - 1 %>)"
									>이전</a>
							</li>
<%
		for(int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
							<li class="page-item">
								<a class="page-link <%=pagination.getPageNo() == num ? "active" : "" %>" 
									href="trainer-list.jsp?page=<%=num %> "
									onclick="goPage(event, <%=num %>)"><%=num %></a>
							</li>
<%
		}
%>					
							<li class="page-item">
									<a class="page-link <%=pagination.isLastPage() ? "disabled" : "" %>" 
									href="trainer-list.jsp?page=<%=pagination.getPageNo() + 1 %>"
									onclick="goPage(event, <%=pagination.getPageNo() + 1 %>)"
									>다음</a>
							</li>
						</ul>
					</nav>
				</div>
			</div>
<%
		}
%>	
</div>
<script type="text/javascript">
//검색 버튼 클릭했을 때 실행되는 함수다. 
function searchBooks(e) {
	let opt = document.querySelector("select[name=opt]").value;
	let keyword = document.querySelector("input[name=keyword]").value;
	
	if (opt == "") {
		alert("검색옵션을 선책하세요");
		e.preventDefault();
		return;
	}
	
	if (keyword == "") {
		alert("검색 키워드를 선책하세요");
		e.preventDefault();
		return;
	}
	// 검색 버튼을 클릭했을 때는 검색 조건에 해당하는 1페이지를 검색하도록 
	// 히든필드(<input type="hidden" name="page">)의 페이지 번호를 1로 설정한다. 
	document.querySelector("input[name=page]").value = 1;
}

// 페이지 번호를 클릭했을 때 실행되는 함수다.
function goPage(e, pageNo) {
	event.preventDefault();
	// 폼의 히든필드(<input type="hidden" name="page">)의 페이지 번호를 클릭한 페이지 번호로 설정한다. 
	document.querySelector("input[name=page]").value = pageNo;
	// 폼을 서버로 제출한다. -> 그래서 다시 list.jsp가 실행된다. 
	document.getElementById("form-search").submit();
}
</script>
</body>
</html>