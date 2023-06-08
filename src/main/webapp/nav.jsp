<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String menu = request.getParameter("menu");

	System.out.println("메뉴 -" + menu);

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
      	</ul>
      	<ul class="navbar-nav">
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
        	</li>
         	<li class="nav-item"><a class="nav-link " href="">로그아웃</a></li>
      	</ul>
   	</div>
</nav>