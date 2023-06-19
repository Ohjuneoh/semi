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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
   				<div class="form-group mb-2 w-75">
   				<label class="form-label" style="font-weight: bold;">주소</label>
   				<input style = "width:150px;"id="member_post" type="text" class="form-control" name="post" readonly  placeholder="우편번호" />
   				<input style = "width:400px;" id="member_addr" type="text" class="form-control" name="streetName"  readonly placeholder="도로명 주소" />
   				<input style = "width:600px;" id="user-detailedAddress" type="text" class="form-control" name="detailAdd"  placeholder="상세주소" />
   				</div>
   				<button type="button" class="btn btn-primary btn-sm" onclick="findAddr()">주소찾기</button>
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
	
	if(value.trim() === ""){
		el.classList.add("text-danger");
        el.textContent = "아이디를 입력해주세요.";
        return;
	}
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
	
	if(value.trim() === ""){
		el.classList.add("text-danger");
        el.textContent = "이메일을 입력해주세요.";
        return;
	}

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
	let tel = document.getElementById("user-tel").value;
	let post = document.getElementById("member_post").value;
	let detailAdd = document.getElementById("user-detailedAddress").value;
	
	var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
	if(id ===""){
		alert("아이디는 필수 입력값입니다.")
		return false;
	}
	if(password ===""){
		alert("비밀번호는 필수 입력값입니다.")
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
	if(post ===""){
		alert("주소는 필수 입력값입니다.")
		return false;
	}
	if(detailAdd ===""){
		alert("상세주소는 필수 입력값입니다.")
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

function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
        	
        	console.log(data);
        	
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('member_post').value = data.zonecode;
            if(roadAddr !== ''){
                document.getElementById("member_addr").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("member_addr").value = jibunAddr;
            }
        }
				
    }).open();
}

</script>
</body>
</html>