<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	
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
	<jsp:param name="menu" value="수업등록"/>
</jsp:include>
<div class="container">
	<div class="row mb-3">
    	<div class="col-12">
        	<h1 class="border bg-light fs-4 p-2">그룹수업 등록 폼</h1>
      	</div>
   	</div>
   	<div class="row mb-3">
   		<div class="col-12">
   			<p>그룹수업을 등록하세요.</p>
			<form class="border bg-light p-3" method="post" action="insert">
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">레슨명</label>
   					<input type="text" class="form-control" name="lesson-name" />
   				</div>
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">레슨타입</label>
   					<input type="text" class="form-control" name="lasson-type" />
   				</div>
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">레슨정원</label>
   					<input type="text" class="form-control" name="lesson-quota" />
   				</div>
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">레슨설명</label>
   					<input type="text" class="form-control" name="lesson-description" />
   				</div>
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">레슨시간</label>
   					<input type="text" class="form-control" name="lesson-time" />
   				</div>
   				<div class="text-end w-75">
   					<button type="submit" class="btn btn-primary">등록</button>
   				</div>
   			</form>
   		</div>
   	</div>
</div>
</body>
</html>