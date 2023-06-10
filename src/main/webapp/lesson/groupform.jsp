<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
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
	<jsp:param name= "menu" value="그룹수업"/>
</jsp:include>	
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">신규 그룹강좌 등록</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>신규 강좌 정보를 입력할 수 있습니다.</p>
			
			<form class="border bg-light p-3" method="post" action="groupInsertLesson.jsp">
				<div class="form-group mb-2">
					<label class="form-label">PT명</label>
					<select class="form-select" name="lessonName">
					</select>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">강사명</label>
					<input type="text" class="form-control" name="trainerName"/>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">정원수</label>
					<input type="text" class="form-control" name="quota"/>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">PT시간</label>
					<input type="text" class="form-control" name="time"/>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">헬스장번호</label>
					<input type="text" class="form-control" name="healthNo"/>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">PT설명</label>
					<textarea class="form-control" rows="5" name="description"></textarea>
				</div>
				<div class="text-end">
					<button type="reset" class="btn btn-secondary btn-sm">취소</button>
					<button type="submit" class="btn btn-primary btn-sm">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>