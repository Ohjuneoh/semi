<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 1. 세션에 저장된 로그인타입, 로그인아이디 조회하기
	String loginType = (String) session.getAttribute("loginType");
	String loginId = (String) session.getAttribute("loginId");
	String gymNo = (String) session.getAttribute("loginGymNo");
	
	// 2. 요청파라미터 조회하기
	String menu = request.getParameter("menu");
%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark mb-3">
	<div class="container">
    	<ul class="navbar-nav me-auto">
        	<li class="nav-item"><a class="nav-link " href="/semi/home.jsp">홈</a></li>
			<li class="nav-item dropdown">
          		<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	수업
          		</a>
          		<ul class="dropdown-menu">
            		<li><a class="dropdown-item" href="/semi/lesson/personalList.jsp">개인수업</a></li>
            		<li><a class="dropdown-item" href="/semi/lesson/groupList.jsp">그룹수업</a></li>
          		</ul>
        	</li>
			<li class="nav-item dropdown">
          		<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	이용권
          		</a>
          		<ul class="dropdown-menu">
            		<li><a class="dropdown-item" href="/semi/membership/membershipList.jsp">이용권 조회</a></li>
            		<li><a class="dropdown-item" href="/semi/membership/trainerList.jsp">강사 조회</a></li>
          		</ul>
        	</li>
        	<li class="nav-item dropdown">
          		<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	커뮤니티
          		</a>
          		<ul class="dropdown-menu">
            		<li><a class="dropdown-item" href="/semi/board/list.jsp">게시판</a></li>
            		<li><a class="dropdown-item" href="">권한설정</a></li>
          		</ul>
        	</li>
<%
	if("관리자".equals(loginType)){
%>
        	<li class="nav-item dropdown">
          		<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	관리자 페이지
          		</a>
          		<ul class="dropdown-menu">
            		<li><a class="dropdown-item" href="">헬스장 등록</a></li>
          		</ul>
        	</li>
      	</ul>
<%
}
%>
<%
	if (loginType != null) {
%>
		<span class="navbar-text me-5">
			<strong class="text-white bolder"><%=loginId %></strong>님 환영합니다.
		</span>
<%	
	}
%>
<%
	if(loginType == null){
%>
      	<ul class="navbar-nav" >
         	<li class="nav-item"><a class="nav-link " href="/semi/loginform.jsp">로그인</a></li>
			<li class="nav-item dropdown">
          		<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	회원가입
          		</a>
          		<ul class="dropdown-menu">
            		<li><a class="dropdown-item" href="/semi/user/form.jsp">회원</a></li>
            		<li><a class="dropdown-item" href="/semi/trainer/form.jsp">강사</a></li>
            		<li><a class="dropdown-item" href="/semi/manager/form.jsp">관리자</a></li>
          		</ul>
<%
	}else {
%>
        	</li>
         	<li class="nav-item"><a class="nav-link " href="/semi/logout.jsp">로그아웃</a></li>
<%
}
%>
      	</ul>
   	</div>
</nav>


