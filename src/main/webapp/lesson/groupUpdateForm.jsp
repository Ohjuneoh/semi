<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@page import="vo.Lesson"%>
<%@page import="dao.GroupLessonDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
   // 1. 파라미터 조회
   String loginType = (String)session.getAttribute("loginType");
   String loginId= (String)session.getAttribute("loginId");
   
      // 레슨번호 뽑아내기
   int lessonNo = Integer.parseInt(request.getParameter("lessonNo"));
   
      // 오류사항: 에러 뽑아내기 
   String err = request.getParameter("err");

   // 2. Dao 로직 (레슨정보)
      // html 코드에서 구현하기 위해서이다.
   GroupLessonDao groupDao = GroupLessonDao.getinstance();
   Lesson lesson = groupDao.getGroupLessonByLessonNo(lessonNo);
   
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
    .gray-text {
      color: gray;
    }
</style>
</head>
<body>
<jsp:include page="../nav.jsp">
   <jsp:param name= "menu" value="수업"/>
</jsp:include>   
<div class="container my-3">
   <div class="row mb-3">
      <div class="col-12">
         <h1 class="border bg-light fs-4 p-2"> 그룹레슨 수정</h1>
      </div>
   </div>
   <div class="row mb-3">
      <div class="col-12">

         <p>그룹레슨 정보를 수정할 수 있습니다.</p>
         
         <form class="border bg-light p-3" method="post" action="groupUpdateLesson.jsp">
         <input type="hidden" name="lessonNo" value="<%=lesson.getNo() %>"/>
         <div class="form-group mb-2">
              <label class="form-label">PT명</label>
              <input type="text" class="form-control" name="lessonName" value="<%=lesson.getName() %>" />
         </div>
            <div class="form-group mb-2">
              <label class="form-label">강사명</label>
              <span class="form-control  gray-text"><%=lesson.getUser().getName() %></span>
            </div>
            <div class="form-group mb-2">
           <label class="form-label">정원수</label>
              <select class="form-select" name="quota">
<% for (int i=1; i<=20; i++) { %>
                  <option value="<%=i %>" <% if (lesson.getQuota() == i) { %>selected<% } %>><%=i %></option>
<% } %>
                   </select>
            </div>
            <div class="form-group mb-2">
               <label class="form-label">PT시간</label>
                  <div class="col-md-12">
                     <div class="col-md-12">
                        <select class="form-select" name="time">
                          <option value="월요일 10:00 ~ 12:00">월요일 10:00 ~ 12:00</option>
                          <option value="월요일 15:00 ~ 17:00">월요일 15:00 ~ 17:00</option>
                          <option value="화요일 10:00 ~ 12:00">화요일 10:00 ~ 12:00</option>
                          <option value="화요일 15:00 ~ 17:00">화요일 15:00 ~ 17:00</option>
                          <option value="수요일 10:00 ~ 12:00">수요일 10:00 ~ 12:00</option>
                          <option value="수요일 15:00 ~ 17:00">수요일 15:00 ~ 17:00</option>
                          <option value="목요일 10:00 ~ 12:00">목요일 10:00 ~ 12:00</option>
                          <option value="목요일 15:00 ~ 17:00">목요일 15:00 ~ 17:00</option>
                          <option value="금요일 10:00 ~ 12:00">금요일 10:00 ~ 12:00</option>
                          <option value="금요일 15:00 ~ 17:00">금요일 15:00 ~ 17:00</option>
                        </select>
                     </div>
                  </div>
            </div>
            <div class="form-group mb-2">
               <label class="form-label">PT설명</label>
               <textarea class="form-control" rows="5" name="description"><%=lesson.getDescription() %></textarea>
            </div>
            
         <div class="modal fade" id="insert" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                
                  <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">작성 취소</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  
                  <div class="modal-body">
                    <br />
                    <p>개인수업 등록을 취소하시겠습니까?</p>
                  </div>
                  
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">아니오</button>
                    <button type="button" class="btn btn-primary btn-sm" onclick="cancel()">예</button>
                  </div>
                </div>
              </div>
         </div>
            
            <div class="text-end">
              <button type="reset" class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#insert">취소</button>
              <button type="submit" class="btn btn-primary btn-sm">등록</button>
            </div>
   
         </form>
      </div>
   </div>
</div>
</body>
<script type="text/javascript">
   function cancel() {
      window.location.href = "personalList.jsp";
   }
</script>
</html>