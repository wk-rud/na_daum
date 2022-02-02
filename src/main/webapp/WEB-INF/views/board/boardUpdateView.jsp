<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 질문 등록" name="title"/>
</jsp:include>
<style>
.board-container{
position: absolute;
width: 715px;
height: 927px;
left: 158px;
top: 238px;
}
</style>
<script>


</script>

<div class="board-container">
	<form method="POST" 
	action="${pageContext.request.contextPath}/board/boardUpdate.do"
	onsubmit="return boardValidate();">
		<label for="title">제목</label>						
		<input type="text" class="form-control" name="title" id="title"	placeholder="제목을 입력해주세요" 
		value="${board.title}" required>
		
		<input type="hidden" name="id" id="id" value="${loginMember.id}" />
		<input type="text" class="form-control"	name="id" value="${loginMember.id}" readonly required>
		<input type="text" class="form-control"	name="id" value="${board.id}" readonly required>
		
		<input type="hidden" name="category" />
		<select id="category-select" class="form-select" aria-label="Default select example" selected="${board.category}">
			<option value="자유게시판">자유게시판</option>
			<option value="문화">문화</option>
			<option value="영화">영화</option>
		</select>
		
		<textarea name="content" id="board-content-summernote" required>${board.content}</textarea>
		<div><span id="limite_normal"></span><span id="limite_vermelho" style="color:red"></span>/500</div>
		
		<br />
		<button type="submit" id="submit-btn" class="btn btn-success">수정</button>
		<button type="button" id="cancle-btn" class="btn btn-success" onclick="location.href ='${pageContext.request.contextPath}/board/boardList.do'">취소</button>
		<!-- <input type="submit" class="btn btn-outline-success" id="submit-btn" value="저장"> -->
		
		<input type="hidden" name="code" value="${board.code}" />
		<input type="hidden" name="id" id="id" value="${loginMember.id}" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
</div>

<script>
function goBoardForm(){
	location.href = "${pageContext.request.contextPath}/board/boardUpdate.do";
}


$("#category-select").change((e) => {	
	$("input[name='category']").val($("#category-select").val());	
});

$(document).ready(function() {
	
	var toolbar = [
	    // 글꼴 설정
	    ['fontname', ['fontname']],
	    // 글자 크기 설정
	    ['fontsize', ['fontsize']],
	    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
	    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	    // 글자색
	    ['color', ['forecolor','color']],
	    // 표만들기
	    ['table', ['table']],
	    // 글머리 기호, 번호매기기, 문단정렬
	    ['para', ['ul', 'ol', 'paragraph']],
	    // 줄간격
	    ['height', ['height']],
	    // 그림첨부, 링크만들기, 동영상첨부
	    ['insert',['picture','link','video']],
	    // 코드보기, 확대해서보기, 도움말
	    ['view', ['codeview','fullscreen', 'help']]
	  ];

	var setting = {
			placeholder: '질문을 작성하세요',
            height : 600,
            minHeight : null,
            maxHeight : null,
            focus : true,
            lang : 'ko-KR',
            toolbar : toolbar,
            callbacks : { //여기 부분이 이미지를 첨부하는 부분
	            onImageUpload : function(files, editor, welEditable) {
		            for (var i = files.length - 1; i >= 0; i--) {
		            	uploadSummernoteImageFile(files[i], this);
	         		}
	         	},
	         	onMediaDelete: function(target){
	         		alert(target[0].src);
	         		deleteImg(target[0].src);
	         	},
	         	onKeyup: function(e) {
	         		var text = $(this).next('.note-editor').find('.note-editable').text();
	         		var length = text.length;
	         		var num = 500 - length;
	         		
	         		if(length > 500){
	         			$("#limite_normal").hide();
	         			$("#limite_vermelho").text(length).show();
	         			$("#board-content-summernote").summernote("code", text.substring(0,500));
	         		}else{
	         			$("#limite_vermelho").hide();
	         			$("#limite_normal").text(length).show();
	         		}
	         	}
    	}
	};
	
	$('#board-content-summernote').summernote(setting);
	
	function uploadSummernoteImageFile(file, el){
		
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
		console.log('시작');
		data = new FormData();
		data.append("file", file);
		$.ajax({
			url: "${pageContext.request.contextPath}/board/uploadSummernoteImageFile.do",
			data: data,
			type: "POST",
			headers: headers,
			enctype: 'multipart/form-data',
			contentType: false,
			processData: false,
			success(resp){
				console.log(resp);
				$(el).summernote('editor.insertImage', resp.url);
			}
		});
	}
});
const deleteImg = (url) => {
	let val = "";
	const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	$.ajax({
		url: '${pageContext.request.contextPath}/board/deleteSummernoteImageFile.do',
		headers: headers,
		type: "POST",
		data: {val: url},
		success(resp){
			if(resp > 0)
				console.log('success');
		}
	});
};
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />