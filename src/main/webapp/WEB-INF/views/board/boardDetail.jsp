<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판상세보기" name="title" />
</jsp:include>
<style>
div#board-container {
	position: absolute;
	height: 669px;
	left: 400px;
	top: 100px;
	width: 1000px;
}

input, button, textarea {
	margin-bottom: 15px;
}

button {
	overflow: hidden;
}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label {
	text-align: left;
}
</style>
<!-- 게시글 상세보기 -->

<div id="board-container" class="mx-auto text-center">
	<div id="detail-container">

		<div id="detailcontent-container" class="form-horizontal">
			<!-- 넘겨주어야하는 값 -->
			<input type="hidden" name="code" value="${board.code }" /> <input
				type="hidden" name="id" id="id" value="${loginMember.id}" /> <input
				type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

			<label for="title" class="col-sm-2 control-label">제목</label> <input
				type="text" class="form-control" name="boardTitle" id="title"
				value="${board.title}" readonly> <label for="writer"
				class="col-sm-2 control-label">작성자</label> <input type="text"
				class="form-control" id="writer" name="id" value="${board.id}"
				readonly> <label for="regDate"
				class="col-sm-2 control-label">등록일자</label> <input
				type="datetime-local" class="form-control" name="regDate"
				id="regDate"
				value='<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd'T'HH:mm"/>'
				readonly> <label for="readCount"
				class="col-sm-2 control-label">조회수</label> <input type="number"
				class="form-control" id="readCount" name="readCount" title="조회수"
				value="${board.readCount}" readonly>

			<!-- 나중에 꼭 삭제하기 -->
			<%-- <input type="text" class="form-control" name="memberId" value="${member.name} (${member.id})" readonly required> --%>

			<label for="content" class="col-sm-2 control-label">내용</label>
			<textarea class="form-control mt-3" name="content" placeholder="내용"
				id="content" readonly>
				<c:out value="${board.content}" />
			</textarea>
			
			
			<!-- 좋아요 -->
					<button type="button" class="btn btn-primary" id="likeButton" 
						data-board-code="${board.code}"
						data-id="${board.id}"
						data-like-yes-no="${likeYesNo}">좋아요</button>
						
			<!-- 좋아요 -->	

		</div>
		<div id="btn-container">
			<%-- 작성자와 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
			<%-- <c:if test="${loginMember.id == board.id}"> --%>

			<input type="button" class="btn btn-warning" id="listbtn" value="목록 "
				onclick="location.href ='${pageContext.request.contextPath}/board/boardList.do'">
			<input type="button" class="btn btn-warning" id=" updatebtn"
				value="수정"
				onclick="location.href ='${pageContext.request.contextPath}/board/boardUpdateView.do?code=${board.code}'">
			<input type="button" class="btn btn-warning" id="deletebtn"
				value="삭제" onclick="deleteBoard()">

			<%-- </c:if> --%>
		</div>

	</div>
	<hr style="margin-top: 30px;" />

	<!-- 댓글 -->
	<div class="comment-container">
		<div class="comment-editor">
			<div class="card mb-2">
				<div class="card-header bg-light">
					<i class="fa fa-comment fa"></i> 댓글 작성
				</div>
				<div class="card-body">
					<ul class="list-group list-group-flush">
						<li class="list-group-item" id="comment-li">
							<div class="form-inline mb-2">
								<label for="replyId"><i
									class="fa fa-user-circle-o fa-2x"></i></label>
							</div>
							<form
								action="${pageContext.request.contextPath}/board/boardCommentEnroll.do"
								method="post" name="boardCommentFrm" id="commentForm">

								<!-- 현재게시글 코드 -->
								<input type="hidden" name="code" value="${board.code}" /> <input
									type="hidden" name="id" value="${loginMember.id}" />
								<%-- <input type="hidden" name="writer" value="<c:if test="${loginMember ne null loginMember.id }"/>" /> --%>
								<!-- 댓글인 경우 1 -->
								<input type="hidden" name="commentLevel" value="1" />
								<!-- 대댓글인 경우 써여져야함 -->
								<input type="hidden" name="commentRef" value="" />

								<textarea name="content" cols="60" rows="3" id="content"
									class="form-control"></textarea>
								<button type="submit" id="btn-comment-enroll1"
									class="btn btn-warning" onClick="fn_comment('${board.code }')">등록</button>

								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
							</form>
						</li>
					</ul>
				</div>
			</div>
		</div>


		<!-- 댓글 목록 시작 -->
		<div class="card mb-2">
			<div class="card-header bg-light">
				<i class="fa fa-comment fa"></i> 댓글 목록
			</div>
			<div class="card-body">

				<%-- 댓글이 하나가 되었다면 if구문으로 들어올꺼임 for문 돌면서 level1, ldecel2 태그를 고르고 출력--%>
				<c:if test="${null ne commentList  && not empty commentList}">
					<c:forEach items="${commentList}" var="comment">
						<c:choose>

							<%-- 댓글 1단계 --%>
							<c:when test="${comment.commentLevel eq 1 }">
								<ul class="list-group list-group-flush" id="level1">
									<li class="list-group-item" id="commentList">
										<div class="form-inline mb-2">
											<label for="replyId"> <i
												class="fa fa-user-circle-o fa-2x"></i>&nbsp;&nbsp;<strong>${comment.id}</strong>
											</label> &nbsp;&nbsp;
											<fmt:formatDate value="${comment.regDate}"
												pattern="yyyy-MM-dd HH:mm" />
										</div> <textarea class="form-control"
											id="exampleFormControlTextarea1" rows="1" readonly="readonly">${comment.content}</textarea>

										<%-- 회원일때만 답글 버튼이 나타남 --%>
										<div class="row float-right">
											<button type="button" onclick="firstReply()"
												class="btn btn-warning btnReComment btn-reply"
												value="${comment.commentCode}">답글</button>
											&nbsp;
											<%-- 회원이고 글쓴이 본인일 경우 댓글 삭제 버튼--%>
											<%-- <c:if test="${comment.id eq loginMember.id}"> --%>
											<button type="button"
												class="btn btn-warning btnCommentDelete btn-delete"
												value="${comment.commentCode}">삭제</button>
											&nbsp;
											<%-- </c:if> --%>
										</div>

									</li>
								</ul>
							</c:when>

							<%-- 댓글 2단계 --%>
							<c:otherwise>
								<ul class="list-group list-group-flush" id="level2">
									<li class="list-group-item" id=level2Reply
										style="padding-left: 100px;">
										<div class="form-inline mb-2">
											<label for="replyId"> <i
												class="fa fa-user-circle-o fa-2x"></i>&nbsp;&nbsp;<strong>${comment.id}</strong>
											</label> &nbsp;&nbsp;
											<fmt:formatDate value="${comment.regDate}"
												pattern="yyyy-MM-dd HH:mm" />
										</div> <textarea class="form-control"
											id="exampleFormControlTextarea1" rows="1" readonly="readonly">${comment.content}</textarea>
										<div class="row float-right">

											<!-- 회원이고 글쓴이 본인일 경우 -->
											<%-- <sec:authorize access="">
												<c:if test="${comment.id eq member.id}"> --%>
											<button type="button"
												class="btn btn-warning btnCommentDelete btn-delete"
												value="${comment.commentCode}">삭제</button>
											&nbsp;
											<%-- </c:if>
											</sec:authorize> --%>
										</div>
									</li>
								</ul>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:if>
			</div>
		</div>
		<!-- 댓글 목록 끝 -->


	</div>


</div>
</body>
<form name="boardDelFrm" method="POST"
	action="${pageContext.request.contextPath}/board/boardDelete.do">
	<input type="hidden" name="code" value="${board.code}" /> <input
		type="hidden" name="id" id="id" value="${loginMember.id}" /> <input
		type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<form
	action="${pageContext.request.contextPath}/board/boardCommentDelete.do"
	name="boardCommentDelFrm" method="POST">
	<input type="hidden" name="commentCode" value="${comment.commentCode}" />
	<input type="hidden" name="code" value="${board.code}" /> <input
		type="hidden" name="id" id="id" value="${loginMember.id}" /> <input
		type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<script>
	//회원아이디와 글쓴이 아이디와 같은때 보임.
	//삭제 버튼을 눌렀을 때 처리
const deleteBoard = () => {
	if(confirm("이 게시물을 정말 삭제하시겠습니까?")){
		$(document.boardDelFrm).submit();		
	}
};
	//수정 버튼을 눌렀을 때 처리
const updateBoard = () => {
	location.href = "${pageContext.request.contextPath}/board/boardUpdateView.do?code=${board.code}";
};

$(".btn-delete").click(function(){
	if(confirm("해당 댓글을 삭제하시겠습니까?")){
		var $frm = $(document.boardCommentDelFrm);
		var commentCode = $(this).val();
		$frm.find("[name=commentCode]").val(commentCode);
		$frm.submit();
	}
});	

/* 대댓글 입력 */
$(".btn-reply").click((e) => {
	
	const commentRef = $(e.target).val();
	console.log(commentRef);
	
	const div = `
		<div class="" id="replycomment">
		<ul class="list-group list-group-flush" id="level2">
		<div class="card-body">
		<ul class="list-group list-group-flush">
			<li class="list-group-item" id="comment-li">
				<div class="form-inline mb-2">
					<label for="replyId"><i
						class="fa fa-user-circle-o fa-2x"></i></label>
				</div>
				<form
					action="${pageContext.request.contextPath}/board/boardCommentEnroll.do"
					method="post" id="commentForm">

					<!-- 현재게시글 코드 -->
					<input type="hidden" name="code" value="${board.code}" /> <input
						type="hidden" name="id" value="${loginMember.id}" />
					<%-- <input type="hidden" name="writer" value="<c:if test="${loginMember ne null loginMember.id }"/>" /> --%>
					<!-- 대댓글인 경우 2 -->
					<input type="hidden" name="commentLevel" value="2" />
					<!-- 대댓글인 경우 써여져야함 -->
					<input type="hidden" name="commentRef" value="\${commentRef}" />

					<textarea name="content" cols="60" rows="2" id="content" class="form-control"></textarea>
					<button type="submit" class ="btn btn-warning btn-comment-enroll2"
						onClick="fn_comment('${board.code }')">등록</button>

					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
				</form>
			</li>
		</ul>
		</div>
		</ul>
		</div>`;
	
		console.log(div);
		
		// e.target의 부모의 부모 div (등록 전체 div를 지칭)
		const $divbtn = $(e.target).parent();
		// jQuery 객체 $divOfBtn 이 div 다음으로 들어가게끔 조치
		$(div)
			.insertAfter($divbtn)
			.find("form")
			.submit((e) => {
				const $content = $("[name=content]", e.target); //여기서 e.target은 form임 (버튼이 아님)
				if(!/^(.|\n)+$/.test($content.val())){
					alert("댓글을 작성해주세요.");
					e.preventDefault();
				}
			});
		//클릭 이벤트 핸들러 (클릭시 여러번 실행되지 못하고 한번만 실행 될 수 있게)
		$(e.target).off("click");
});

/* 좋아요 */
 $(document).on('click', '#likeButton', function(e) {
	console.log("좋아요 나왕?");
	
	const $boardCode = $(e.target).data("boardCode");
	const $memberId = $(e.target).data("id");
	const likeYesNo = $(e.target).data("likeYesNo");
	console.log($boardCode);
	console.log($memberId);
	console.log(likeYesNo);
	
	if(likeYesNo == 0){
		
		$.ajax({
			url : "${pageContext.request.contextPath}/board/boardLikeAdd",
			method : "GET",
			data : {
				memberId : $memberId,
				boardCode : $boardCode
			},
			success(data){
				const result = data["result"]
				const selectCountLikes = data["selectCountLikes"];
				console.log(`result : \${result}`);
				console.log(`selectCountLikes : \${selectCountLikes}`);
				
				if(result == 1) {
					$(e.target).data("likeYesNo", 1);
					console.log($(e.target).data("likeYesNo"));
					
					//$(e.target).text(newCountLikes);
					console.log("selectCountLikes = " + selectCountLikes);
					console.log("좋아요 등록!");
					alert("좋아요를 등록했습니다.");
						
				}
			},
			error : function(xhr, status, err){
				console.log(xhr, status, err);
					alert("좋아요 안됩니꽈,,,?");
			}
		});
	// 좋아요를 이미 눌렀을 경우
	}else{
		
		$.ajax({
			url : "${pageContext.request.contextPath}/board/boardLikeDelete",
			method : "GET",
			data : {
				memberId : $memberId,
				boardCode : $boardCode
			},
			success(data){
				const result = data["result"];
				const selectCountLikes = data["selectCountLikes"];
				console.log(`result : \${result}`);
				console.log(`selectCountLikes : \${selectCountLikes}`);
				
				if(result == 1) {
					$(e.target).data("likeYesNo", 0);
					console.log($(e.target).data("likeYesNo"));
					
					//$(e.target).text(newCountLikes);
					console.log("selectCountLikes = " + selectCountLikes);
					console.log("좋아요 취소!");
					alert("좋아요를 취소했습니다.");
				}
			},
			error : console.log
		})
	}
});
 
/* ajax 비동기로 처리 */
/* function fn_comment(code){
    $.ajax({
        type:'POST',
        url : "<c:url value='/board/boardCommentEnroll.do'/>",
        data:$("#commentForm").serialize(),
        success : function(data){
            if(data=="success")
            {
                getCommentList();
                $("#content").val("");
            }
        },
        error:function(request,status,error){
            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       }  
    });
} */
/**
 * 초기 페이지 로딩시 댓글 불러오기
 */
$(function(){    
    getCommentList();  
});



</script>
</html>
<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp"/> --%>