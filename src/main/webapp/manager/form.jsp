<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String err = request.getParameter("err");
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
	<jsp:param name="menu" value="회원가입"/>
</jsp:include>
<div class="container">
	<div class="row mb-3">
    	<div class="col-12">
        	<h1 class="border bg-light fs-4 p-2">관리자로 등록하기</h1>
      	</div>
   	</div>
   	<div class="row mb-3">
   		<div class="col-12">
   			<p>사용자 정보를 입력하고 등록하세요.</p>
<%
	if("id".equals(err)){
%>
			<div class = "alert alert-danger">
				<strong>사용자등록 실패</strong> 이미 사용중인 아이디로 가입할 수 없습니다.
			</div>  
<%
}
%>
<%
	 if("email".equals(err)){
%>
			<div class = "alert alert-danger">
				<strong>사용자등록 실패</strong> 이미 사용중인 이메일로 가입할 수 없습니다.
			</div>  
<%
}
%>				
   			<form class="border bg-light p-3" method="post" action="insert.jsp" onsubmit="return fn1();">
   				<input type="hidden" name="type" value="manager">
   				<div class="form-group mb-2 w-75 " >
   					<label class="form-label">아이디</label>
   					<input id="user-id" type="text" class="form-control" name="id" />
   				</div>
   				<button type = "button" onclick="idCheck()" class="btn btn-secondary btn-sm">중복 확인</button>
   				<span id="msg-box" ></span>
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">비밀번호</label>
   					<input id="user-password" type="text" class="form-control" name="password"  onblur="passworderr()"/>
   					<small id="password-error" class="text-danger"></small>
   				</div>
   				
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">이름</label>
   					<input id="user-name" type="text" class="form-control" name="name" />
   				</div>
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">이메일</label>
   					<input id = "user-email" type="text" class="form-control" name="email" />
   				</div>
   				<button type = "button" onclick="emailCheck()" class="btn btn-secondary btn-sm">중복 확인</button>
   				<span id="email-msg-box" ></span>
   				<div class="form-group mb-2 w-75">
   					<label class="form-label">전화번호</label>
   					<input id="user-tel" type="text" class="form-control" name="tel" />
   				</div>
   				<div class="text-end w-75">
   					<button type="submit" class="btn btn-primary">등록</button>
   				</div>
   			</form>
   		</div>
   	</div>
</div>
<script type="text/javascript">
function idCheck() {
	let value = document.getElementById("user-id").value;
	let el = document.getElementById("msg-box");
	el.textContent="";
	el.classList.remove("text-danger");
	el.classList.remove("text-success");

	let xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){
			if(xhr.readyState === 4 && xhr.status === 200){
				let text = xhr.responseText;
				let obj = JSON.parse(text);
				if(obj.exist){
						el.classList.add("text-danger");
						el.textContent = "사용할 수 없는 아이디입니다.";
				} else{
						el.classList.add("text-success");
						el.textContent = "사용 가능한 아이디입니다.";
					
				}
				
			}
		
		}
	xhr.open("GET", "../check.jsp?id=" + value);
	xhr.send(null);
	
	document.getElementById("user-id").focus();
	
	
}
function emailCheck() {
	let value = document.getElementById("user-email").value;
	let el = document.getElementById("email-msg-box");
	el.textContent="";
	el.classList.remove("text-danger");
	el.classList.remove("text-success");

	let xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){
			if(xhr.readyState === 4 && xhr.status === 200){
				let text = xhr.responseText;
				let obj = JSON.parse(text);
				if(obj.exist){
						el.classList.add("text-danger");
						el.textContent = "사용할 수 없는 이메일입니다.";
				} else{
						el.classList.add("text-success");
						el.textContent = "사용 가능한 이메일입니다.";
					
				}
				
			}
		
		}
	xhr.open("GET", "../check.jsp?email=" + value);
	xhr.send(null);
	
	document.getElementById("user-email").focus();
	
	
}

function fn1() {
	let id = document.getElementById("user-id").value;
	let password = document.getElementById("user-password").value;
	let name = document.getElementById("user-name").value;
	let email = document.getElementById("user-email").value;
	let gymNo = document.getElementById("user-gymNo").value;
	let tel = document.getElementById("user-tel").value;
	var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
	if(id ===""){
		alert("아이디는 필수 입력값입니다.")
		return false;
	}

	if(name ===""){
		alert("이름 필수 입력값입니다.")
		return false;
	}
	if(email ===""){
		alert("이메일은 필수 입력값입니다.")
		return false;
	}
	if(tel ===""){
		alert("전화번호는 필수 입력값입니다.")
		return false;
	}
	return true;
}

function passworderr() {
    let password = document.getElementById("user-password").value;
    var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
    
    if (!pwdCheck.test(password)) {
        document.getElementById("password-error").textContent = "비밀번호는 영문자+숫자+특수문자 조합으로 8~25자리를 사용해야 합니다.";
    } else {
        document.getElementById("password-error").textContent = "";
    }
}

</script>
</body>
</html>