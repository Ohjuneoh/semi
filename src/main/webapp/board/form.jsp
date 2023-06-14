<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	String err = request.getParameter("err");
	String job = request.getParameter("job");

	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("게시글 작성", "utf-8"));
		return;
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
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name="menu" value="커뮤니티"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
         	<h1 class="border bg-light fs-4 p-2">게시글 등록폼</h1>
      	</div>
	</div>
<%
	if("formcat".equals(err)) {
%>
	<div class="alert alert-danger">
		<strong>게시글 등록 실패</strong> 게시판을 선택해주세요.
	</div>
<%
	}

	if("formtitle".equals(err)) {
%>
	<div class="alert alert-danger">
		<strong>게시글 등록 실패</strong> [<%=job %>]을 입력해주세요.
	</div>
<%
	}
	
	if("formcon".equals(err)) {
%>
	<div class="alert alert-danger">
		<strong>게시글 등록 실패</strong> [<%=job %>]을 입력해주세요.
	</div>
<%
	}
%>
	<div class="row mb-3">
		<div class="col-12">	
			<form class="border bg-light p-3" method="post" action="insert.jsp" >
				<div class="form-group mb-2" >
					<label class="form-label" >게시판</label>
					<select class="form-select" name="category" >
						<option disabled="disabled" selected="selected" >--- 게시판을 선택하세요 ---</option>
						<option value="chat" >잡담</option>
						<option value="info" >정보</option>
						<option value="deal" >거래</option>
					</select>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">제목</label>
					<input type="text" class="form-control" name="title"/>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">내용</label>
					<textarea rows="5" class="form-control" name="content"></textarea>
				</div>			
				<div class="text-end">
					<button type="submit" class="btn btn-primary">등록</button>
					<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#insert">취소</button>
				</div>
				
				<div class="modal fade" id="insert" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  					<div class="modal-dialog">
    					<div class="modal-content">
      						<div class="modal-header">
        						<h1 class="modal-title fs-5" id="exampleModalLabel">수정 취소</h1>
        						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      						</div>
      						<div class="modal-body">
      							<br />
      							<p>게시글 작성을 취소하시겠습니까?</p>
      						</div>
      						<div class="modal-footer">
        						<a href="list.jsp" class="btn btn-primary">확인</a>
        						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        						
      						</div>
    					</div>
  					</div>
				</div>
							
			</form>
		</div>
	</div>
</div>
</body>
</html>