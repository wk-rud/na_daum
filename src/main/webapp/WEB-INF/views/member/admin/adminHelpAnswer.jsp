<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<link href='${pageContext.request.contextPath}/resources/css/member/admin/admin.css' rel='stylesheet' />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 관리자페이지" name="title"/>
</jsp:include>
<div class="admin-body">
	<div class="answer-wrap">
		<div class="question-wrap">
			<div class="question-title">
				${help.title}
			</div>
			<div class="question-content">
				${help.content}
			</div>
		</div>
		<div class="answer-body">
			<form method="POST">
				<label for="title">제목</label>						
				<input type="text" class="form-control" name="aTitle" id="title" required>
				<textarea name="aContent" id="help-answer-summernote" required></textarea>
				<div><span id="limite_normal"></span><span id="limite_vermelho" style="color:red"></span>/500</div>
				<button type="submit" id="help-submit-btn" class="btn btn-success">답변등록</button>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>	
		</div>
	</div>
</div>
<script>
$("#category-select").change((e) => {	
	$("input[name='category']").val($("#category-select").val());	
});

$("#help-submit-btn").click((e) => {
	if($("#title").val() == ''){
		alert('제목을 작성해 주세요');
		return false;
	}
	if($("#limite_normal").text() == ''){
		alert('질문 내용을 작성해 주세요');
		return false;
	}
	if($("#limite_normal").text() <= 10){
		alert('10자 이상 작성해 주세요');
		return false;
	}
	return true;
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
            height : 300,
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
	         			$("#help-content-summernote").summernote("code", text.substring(0,500));
	         		}else{
	         			$("#limite_vermelho").hide();
	         			$("#limite_normal").text(length).show();
	         		}
	         	}
    	}
	};
	$('#help-answer-summernote').val("${help.AContent}");
	$('#help-answer-summernote').summernote(setting);
	
	function uploadSummernoteImageFile(file, el){
		
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
		console.log('시작');
		data = new FormData();
		data.append("file", file);
		$.ajax({
			url: "${pageContext.request.contextPath}/member/mypage/uploadSummernoteImageFile.do",
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
		url: '${pageContext.request.contextPath}/member/mypage/deleteSummernoteImageFile.do',
		headers: headers,
		type: "POST",
		data: {val: url},
		success(resp){
			console.log(resp);
		}
	});
};
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />