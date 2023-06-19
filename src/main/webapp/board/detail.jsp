<%@page import="vo.LikeDisLike"%>
<%@page import="dao.LikeDisLikeDao"%>
<%@page import="dto.Pagination"%>
<%@page import="util.StringUtils"%>
<%@page import="vo.Comment"%>
<%@page import="java.util.List"%>
<%@page import="dao.CommentDao"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	if(loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("게시글 보기", "utf-8"));
		return;
	}
	
	BoardDao boardDao = BoardDao.getInstance();
	int boardNo = 0;
	try{
		boardNo = Integer.parseInt(request.getParameter("boardNo"));
	} catch(NumberFormatException num) {
		response.sendRedirect("list.jsp?err=invalid");
		return;
	};
	Board board = boardDao.getBoardByNo(boardNo);

	if(!loginId.equals(board.getUser().getId())) {
		board.setViewCnt(board.getViewCnt() + 1);
		boardDao.updateBoard(board);
	}
	if(!"N".equals(board.getDeleted())) {
		response.sendRedirect("list.jsp?err=deleteBoard");
		return;
	}
	
	CommentDao commentDao = CommentDao.getInstance();
	int commentCnt = commentDao.getCommentCnt(boardNo);	
	List<Comment> comments = commentDao.getComments(boardNo, 1, 10);
	
	LikeDisLikeDao likeDislikeDao = LikeDisLikeDao.getInstance();
	int totalLike = likeDislikeDao.totalLike(boardNo);
	int totalDisLike = likeDislikeDao.totalDisLike(boardNo);
	LikeDisLike likeDislike = likeDislikeDao.getLikeDisLikeByNoId(boardNo, loginId);
%>
<!doctype html>
<html lang="ko">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
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
			<nav class="nav">
  				<a class="nav-link" href="list.jsp">전체</a>
  				<a class="nav-link" href="chatList.jsp">잡담</a>
  				<a class="nav-link" href="infoList.jsp">정보</a>
  				<a class="nav-link" href="dealList.jsp">거래</a>
			</nav>
			<h1 class="border bg-light fs-4 p-2">게시글 상세 정보</h1>
		</div>
<%
	String err = request.getParameter("err");
	String job = request.getParameter("job");

	
	if("notLoginUser".equals(err)) {
%>
		<div class="alert alert-danger">
			<strong>잘못된 접근</strong> [<%=job %>]는 작성자만 사용가능한 서비스입니다.
		</div>
<%
	}

	if("commentNull".equals(err)) {
%>
		<div class="alert alert-danger">
			<strong>댓글 내용은 비워둘 수 없습니다.</strong>
		</div>
<%
	}
	
	if("reportNull".equals(err)) {
%>
		<div class="alert alert-danger">
			<strong>신고 사유를 선택하세요.</strong>
		</div>
<%
	}
	
	if("overlap".equals(err)) {
%>
		<div class="alert alert-danger">
			<strong>중복신고는 불가합니다.</strong>
		</div>
<%
	}
	
	if("yourBoard".equals(err)) {
%>
		<div class="alert alert-danger">
			<strong>작성자 본인의 게시글은 신고할 수 없습니다.</strong>
		</div>
<%
	}
	
	if("likeDislike".equals(err)) {
%>
		<div class="alert alert-danger">
			<strong>잘못된 접근</strong> 중복 평가는 불가합니다.
		</div>
<%
	}
%>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<table class="table table-bordered">
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="10%">
					<col width="40%">
				</colgroup>
				<tbody>
					<tr>
						<th class="table-dark">제목</th>
						<td><%=board.getTitle() %></td>
						<th class="table-dark">작성자</th>
						<td><%=board.getUser().getId() %></td>
					</tr>
					<tr>
						<th class="table-dark">조회수</th>
						<td><%=board.getViewCnt() %></td>
						<th class="table-dark">댓글갯수</th>
						<td><%=commentCnt %></td>
					</tr>
					<tr>
						<th class="table-dark">등록일</th>
						<td><%=board.getCreateDate() %></td>
						<th class="table-dark">수정일자</th>
						<td><%=board.getUpdateDate() %></td>
					</tr>
					<tr>
						<th class="table-dark" style="vertical-align: middle;">내용</th>
						<td colspan="3" style="height: 200px"><%=board.getContent() %></td>
					</tr>
				</tbody>
			</table>
			<div class="text-center">
<%
	if (likeDislike == null) {
%>
				<a href="insertLikeDislike.jsp?boardNo=<%=boardNo %>&type=like" class="btn btn-outline-primary">
					좋아요<br /><%=totalLike%>
				</a>
				<a href="insertLikeDislike.jsp?boardNo=<%=boardNo %>&type=disLike" class="btn btn-outline-danger">
					싫어요<br /><%=totalDisLike %>
				</a>
<%
	} else {
%>
				<a href="insertLikeDislike.jsp?boardNo=<%=boardNo %>&type=like" class="btn btn-outline-primary 
					<%="like".equals(likeDislike.getType()) ? "active" : "disabled"%>">
					좋아요<br /><%=totalLike%>
				</a>
				<a href="insertLikeDislike.jsp?boardNo=<%=boardNo %>&type=disLike" class="btn btn-outline-danger
					<%="disLike".equals(likeDislike.getType()) ? "active" : "disabled"%>">
					싫어요<br /><%=totalDisLike %>
				</a>
<%		
	}
%>
				
			</div>
			<div class="text-end">
<%
	String loginType = (String) session.getAttribute("loginType");
	if(loginId.equals(board.getUser().getId())) {
%>
				<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleted-board-modal">삭제</button>
				<a href="modifyForm.jsp?boardNo=<%=boardNo %>" class="btn btn-warning btn-sm">수정</a>
<%
	} else if(!"manager".equals(board.getType()) && !"manager".equals(loginType)) {
%>
				<div class="text-end">
					<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#report-modal">신고</button>			
				</div>
<%
	}
%>
			</div>
		</div>
	</div>
	<div class="row mb-3">
   		<div class="col-12">
			<form class="border bg-light p-2" method="post" action="comment-insert.jsp">
				<input type="hidden" name="boardNo" value="<%=boardNo %>" />
 				<div class="row">
					<div class="col-11">
						<textarea rows="2" class="form-control" name="content"></textarea>
					</div>
					<div class="col-1">
						<button class="btn btn-outline-primary h-100">등록</button>
					</div>
				</div>
			</form>
   		</div>
   	</div>
	<div id="comment-more">
<%
	for(Comment comment : comments)  {
%>
	   	<div class="row mb-3" id="out-row-<%=comment.getNo() %>">
	   		<div class="col-12">
	   			<div class="border p-2 mb-2">
		   			<div class="d-flex justify-content-between mb-1" >
		   				<strong><%=comment.getUser().getId() %>
<%		
		if(board.getUser().getId().equals(comment.getUser().getId())) {
%>
						<span class="badge bg-success" >작성자</span>
		   				</strong>
<%
		}
%>
					</div>
						<div class="row" id="row-<%=comment.getNo() %>">
							<div id="comment-updateDate" class="text-muted" style="font-size:smaller;"><%=comment.getUpdateDate() %></div><br/>
							<div class="col-10">
								<span id="comment-content"><%=comment.getContent() %></span>
							</div>
							<div class="col-2 text-end">
<%
			if(loginId.equals(comment.getUser().getId())) {
%>
								<button id="btn-modify-comment" onclick="modifyFieldComment(<%=comment.getNo() %>)" class="btn btn-link text-decoration-none">
									<i class="bi bi-pencil-fill"></i>
			   					</button>
								<button id="btn-delete-comment" class="btn btn-link text-danger text-decoration-none" onclick="openDeleteCommentConfirmModal(<%=comment.getNo() %>);">
			   						<i class="bi bi-trash"></i>
			   					</button>
<%
		}
%>
							</div>
						</div>
					<div class="row d-none" id="row-field-<%=comment.getNo() %>">
						<div class="col-10">
							<textarea class="form-control" id="comment-field-<%=comment.getNo() %>"><%=comment.getContent() %></textarea>
					</div>
						<div class="col-2">
							<button id="btn-modify-comment" onclick="modifyComment(<%=comment.getNo() %>)" class="btn btn-primary" >수정</button>
			   				<button id="btn-modify-comment" onclick="modifyCancelComment(<%=comment.getNo() %>)" class="btn btn-danger" >취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
<%
	}
%>
	</div>
<%
	if(commentCnt > 10) {
%>
		<div class="text-center" id="comment-more-button">
			<button type="button" class="btn btn-outline-secondary" onclick="commentMore()">더보기 <i class="bi bi-arrow-down"></i></button>
		</div>
<%
	}
%>
</div>
<div class="modal fade" id="report-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
   					<div class="modal-header">
     					<h1 class="modal-title fs-5" id="exampleModalLabel">게시글 신고</h1>
     					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
   					</div>
   					<div class="modal-body" style="text-align: left !important;">
     					<form method="post" action="report.jsp">
					<input type="hidden" name="boardNo" value="<%=boardNo %>">
     						<p style="font-weight: bold;">신고사유 선택</p>
       						<div class="mb-3 ">
			        	<input type="radio" name="report" value="욕설, 비방, 차별, 혐오" /> 욕설, 비방, 차별, 혐오 <br />
			        	<input type="radio" name="report" value="불법 정보" /> 불법 정보 <br />
			        	<input type="radio" name="report" value="음란, 청소년 유해" /> 음란, 청소년 유해 <br />
			        	<input type="radio" name="report" value="도배 스팸" /> 도배 스팸 <br />
			        	<input type="radio" name="report" value="기타" /> 기타
			    	</div>
			    	<div class="modal-footer">
						<button type="submit" class="btn btn-danger">신고</button>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="deleted-board-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      	<div class="modal-header">
	        	<h1 class="modal-title fs-5" id="exampleModalLabel">게시글 삭제</h1>
	        	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      	</div>
	      	<div class="modal-body">
	      		<br />
	      		<p>게시글을 삭제하시겠습니까?</p>
	      	</div>
	      	<div class="modal-footer">
	        	<a href="delete.jsp?boardNo=<%=boardNo %>" type="button" class="btn btn-primary">삭제</a>
	        	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>        						
	      	</div>
	    </div>
	 </div>
</div>
<div class="modal fade" id="deleted-comment-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      	<div class="modal-header">
	        	<h1 class="modal-title fs-5" id="exampleModalLabel">댓글 삭제</h1>
	        	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      		</div>
      		<div class="modal-body">
      			<br />
      			<p>댓글을 삭제하시겠습니까?</p>
      			<input type="hidden" id="deletedCno"/>
      		</div>
      		<div class="modal-footer">
        		<button type="button" class="btn btn-primary" onclick="deleteComment()">삭제</button>
        		<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>        						
      		</div>
    	</div>
  	</div>
</div>
<script type="text/javascript">
	const deleteConfirmModal = new bootstrap.Modal(document.getElementById('deleted-comment-modal'));
	
	function openDeleteCommentConfirmModal(cno) {
		deleteConfirmModal.show();
		document.getElementById('deletedCno').value = cno;
	}
	
	function modifyFieldComment(cno) {
		document.getElementById("row-" + cno).classList.add('d-none');
		document.getElementById("row-field-" + cno).classList.remove('d-none');
	}
	
	function modifyCancelComment(cno) {
		document.getElementById("row-" + cno).classList.remove('d-none');
		document.getElementById("row-field-" + cno).classList.add('d-none');
	}
	
	function modifyComment(cno) {
		// 수정댓글 내용
		let content = document.getElementById("comment-field-"+cno).value;
		let xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function () {
			if(xhr.readyState === 4 && xhr.status === 200) {
				let newComment = xhr.responseText;
				let arr = JSON.parse(newComment);
				document.querySelector(`#row-\${cno} #comment-content`).textContent  = arr.content;
				document.querySelector(`#row-\${cno} #comment-updateDate`).textContent  = arr.updateDate;
			}
		}
		xhr.open("POST", "comment-modify.jsp");
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr.send("cno=" + cno + "&content=" + content);
		
		document.getElementById("row-" + cno).classList.remove("d-none");
		document.getElementById("row-field-" + cno).classList.add("d-none");
	}
	
	function deleteComment() {
		deleteConfirmModal.hide();
		let cno = document.getElementById('deletedCno').value;
		let xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function () {		
			if (xhr.readyState == 4 && xhr.status == 200) {				
				let text = xhr.responseText;
				let comment = JSON.parse(text);
				
				if (comment.deleted) {
					document.getElementById("out-row-"+cno).remove();
					alert("댓글이 삭제되었습니다."); 
				} else {
					alert("댓글을 삭제할 수 없습니다.");
				}			
			}
		}		
		xhr.open("GET", "comment-delete.jsp?cno=" + cno);
		xhr.send(null);
	}
	
	let page = 2;
	let more = true;
	function commentMore() {
		if(more) {
			let xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function () {
				if(xhr.readyState === 4 && xhr.status === 200) {
					let text = xhr.responseText;
					let nextComs = JSON.parse(text);
					let commentHTMLContents = "";
					
					if(nextComs.length === 0) {
						more = false;
						document.getElementById("comment-more-button").classList.add("d-none");
					}
		
					nextComs.forEach(function (comment, index) {
						commentHTMLContents += `
								<div class="row mb-3" id="out-row-\${comment.no}">
						   		<div class="col-12">
						   			<div class="border p-2 mb-2">
							   			<div class="d-flex justify-content-between mb-1">
							   				<strong id="comment-userId">\${comment.user.id}`;
								
						if(`<%=board.getUser().getId()%>` === comment.user.id) {
							commentHTMLContents +=
											` <span class="badge bg-success" >작성자</span>
							   				</strong>`;
						}
							
						commentHTMLContents +=
										`</div>
										<div class="row" id="row-\${comment.no}">
											<div id="comment-updateDate" class="text-muted" style="font-size:smaller;">\${comment.updateDate}</div><br/>
											<div class="col-10">
												<span id="comment-content">\${comment.content}</span>
											</div>
											<div class="col-2 text-end">`;
						
						if(`<%=loginId %>` === comment.user.id) {
							commentHTMLContents += `
												<button id="btn-modify-comment" onclick="modifyFieldComment(\${comment.no})" class="btn btn-link text-decoration-none" >
													<i class="bi bi-pencil-fill"></i>
								   				</button>
												<button id="btn-delete-comment" class="btn btn-link text-danger text-decoration-none" onclick="openDeleteCommentConfirmModal(\${comment.no});">
								   					<i class="bi bi-trash"></i>
								   				</button>`;
						
						}
						commentHTMLContents += `
											</div>
										</div>
										<div class="row d-none" id="row-field-\${comment.no}">
											<div class="col-10">
												<textarea class="form-control" id="comment-field-\${comment.no}">\${comment.content}</textarea>
										</div>
											<div class="col-2">
												<button id="btn-modify-comment" onclick="modifyComment(\${comment.no})" class="btn btn-primary" >수정</button>
								   				<button id="btn-modify-comment" onclick="modifyCancelComment(\${comment.no})" class="btn btn-danger" >취소</button>
											</div>
										</div>
									</div>
								</div>
							</div>`;
					});
					document.querySelector("#comment-more").innerHTML += commentHTMLContents;
				}
			}
			xhr.open("GET", "comment-more.jsp?boardNo=<%=boardNo%>&comPage=" + page);
			xhr.send(null);
			page++;
		}
	}
</script>
</body>
</html>