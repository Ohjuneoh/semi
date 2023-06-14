<%@page import="java.net.URLEncoder"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	BoardDao boardDao = BoardDao.getInstance();
	Board board = boardDao.getBoardByNo(boardNo);
	
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("게시글 수정", "utf-8"));
		return;
	}
	
	if(!loginId.equals(board.getUser().getId())) {
		response.sendRedirect("detail.jsp?boardNo=" + boardNo + "&err=delete&job=" + URLEncoder.encode("게시글 수정", "utf-8"));
		return;
	}
	
	if(!"N".equals(board.getDeleted())) {
		response.sendRedirect("list.jsp?err=deleteBoard");
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
	<jsp:param name="menu" value="게시판"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
         	<h1 class="border bg-light fs-4 p-2">게시글 수정폼</h1>
      	</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">	
			<form class="border bg-light p-3" method="post" action="modify.jsp" onsubmit="return modify();">
			<input type="hidden" name="boardNo" value="<%=boardNo%>" />
				<div class="form-group mb-2" >
					<label class="form-label" >게시판</label>
					<select class="form-select" id="board-cat" name="category" >
						<option disabled="disabled" >--- 게시판을 선택하세요 ---</option>
						<option value="chat" <%="chat".equals(board.getCategory()) ? "selected" : "" %>>잡담</option>
						<option value="info" <%="info".equals(board.getCategory()) ? "selected" : "" %>>정보</option>
						<option value="deal" <%="deal".equals(board.getCategory()) ? "selected" : "" %>>거래</option>
					</select>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">제목</label>
					<input type="text" class="form-control" id="board-title" name="title" value="<%=board.getTitle() %>" />
				</div>
				<div class="form-group mb-2">
					<label class="form-label">내용</label>
					<textarea rows="5" class="form-control" id="board-content" name="content"><%=board.getContent() %></textarea>
				</div>			
				<div class="text-end">
					<button type="submit" class="btn btn-primary">수정</button>
					<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#modify">취소</button>
				</div>
				
				<div class="modal fade" id="modify" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  					<div class="modal-dialog">
    					<div class="modal-content">
      						<div class="modal-header">
        						<h1 class="modal-title fs-5" id="exampleModalLabel">작성 취소</h1>
        						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      						</div>
      						<div class="modal-body">
      							<br />
      							<p>수정을 취소하시겠습니까?</p>
      						</div>
      						<div class="modal-footer">
        						<a href="detail.jsp?boardNo=<%=boardNo %>" class="btn btn-primary">확인</a>
        						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      						</div>
    					</div>
  					</div>
				</div>
				
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	function modify() {
		let title = document.getElementById("board-title").value;
		let content = document.getElementById("board-content").value;
		
		if(title === "") {
			alert("제목은 비워둘 수 없습니다.");
			return false;
		}
		if(content === "") {
			alert("내용은 비워둘 수 없습니다.");
			return false;
		}
		
		return true;
	}
</script>
</body>
</html>