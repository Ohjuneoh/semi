<%@page import="dao.PersonalLessonDao"%>
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
	<jsp:param name= "menu" value="개인수업"/>
</jsp:include>	
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">신규 강좌 등록</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>신규 강좌 정보를 입력할 수 있습니다.</p>
			
			<form class="border bg-light p-3" method="post" action="personalInsertLesson.jsp">
				<div class="form-group mb-2">
					<label class="form-label">레슨명</label>
					<input type="text" class="form-control" name="lessonName"/>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">정원수</label>
					<input type="text" class="form-control" name="quota"/>
				</div>
				<div class="col-md-12">
						<label class="form-label">레슨 시간 </label>	
					</div>
					<div class="col-md-12">
						<select class="form-select" name="lessonTime">
	   						<option value="월요일 10:00 ~ 12:00">월요일 10:00 ~ 12:00</option>
	   						<option value="월요일 20:00 ~ 22:00">월요일 20:00 ~ 22:00</option>
	   						<option value="화요일 11:00 ~ 13:00">화요일 11:00 ~ 13:00</option>
	   						<option value="화요일 16:00 ~ 18:00">화요일 16:00 ~ 18:00</option>
	   						<option value="수요일 13:00 ~ 15:00">수요일 13:00 ~ 15:00</option>
	   						<option value="수요일 17:00 ~ 19:00">수요일 17:00 ~ 19:00</option>
	   						<option value="목요일 10:30 ~ 12:30">목요일 10:30 ~ 12:30</option>
	   						<option value="목요일 14:00 ~ 16:00">목요일 14:00 ~ 16:00</option>
	   						<option value="금요일 11:00 ~ 13:00">금요일 11:00 ~ 13:00</option>
	   						<option value="금요일 15:00 ~ 17:00">금요일 15:00 ~ 17:00</option>
	   					</select>
					</div>
				<div class="form-group mb-2">
					<label class="form-label">레슨 설명</label>
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