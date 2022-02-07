<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<% 
	String code = request.getParameter("code");
%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 Diary" name="title"/>
</jsp:include>
<style>
[type=radio] { 
	 position: absolute;
	 opacity: 0;
	 width: 0;
	 height: 0;
} 
#diaryIsPublic {
	display: flex;
    justify-content: flex-end;
}
#diaryEnroll {padding: 65px;}
#diaryTitle {    
	display: flex;
    flex-direction: column;
    align-items: center;
    height: 180px;
}
#diaryFooter {
	display: flex;
    padding-top: 15px;
    justify-content: space-between;
}
.blanket{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/blanket.png");
    height:130px;
}
.daechoong{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/daechoong.png");
    height:130px;
}
.eat{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/eat.png");
    height:130px;
}
.gogo{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/gogo.png");
    height:130px;
}
.happy{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/happy.png");
    height:130px;
}
.trash{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/trash.png");
    height:130px;
}
</style>
<div id="diaryEnroll-container">
	<div id="diaryEnroll">
		<form method="post">
			<div id="diaryTitle">
				<label>
					<input type= "hidden" name="emotionNo" value="${diary.emotionNo}"/>
					<div class="${emotion.EMOTION_FILENAME}"></div>
				</label>
				<input type="date" name="regDate" id="reg_date" 
				value="<fmt:formatDate value="${diary.regDate}" pattern="YYYY-MM-dd"/>"/>
			</div>
			<div id="diaryIsPublic">
				<label>공개여부
					<input type="checkbox" name="isPublic" value='Y' id="isPublic" ${diary.isPublic == 'Y' ? 'checked' : ''}/>
				</label>						
			</div>
			<div id="diaryContent-container">
				<input type="hidden" name="isPublic" value='N' id="isPublic" checked="checked"/>
				<label for="title">제목</label>						
				<input type="text" class="form-control" name="title" id="title"	placeholder="제목을 입력해주세요" value="${diary.title}" required>
				<textarea id="diaryContent" name="content" required>${diary.content}</textarea>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</div>
			<div id="diaryFooter">
				<div>
					<span id="limite_normal"> </span>
					<span id="limite_vermelho" style="color:red"></span>/1000
				</div>
				<div>
					<input type="submit" id="diaryBtn" name="diaryBtn" value="수정">
					<input type="button" id="diaryDelite" name="deleteDiary" value="삭제" 
					onclick="location.href = '${pageContext.request.contextPath}/diary/deleteDiary.do?code=${diary.code}&date=<fmt:formatDate value="${diary.regDate}" pattern="YYYY-MM-dd"/>'">
				</div>
			</div>
		</form>
	</div>
</div>
<script>
// 삭제
$("#deleteDiary").click((e) => {
	if(!confirm("삭제하시겠습니까?")){	
		return false;
	}
});

// 수정
$("#diaryBtn").click((e) => {
	if($("#title").val() == ''){
		alert('제목을 작성해 주세요');
		return false;
	}
	if($("#limite_normal").text() == ''){
		alert('내용을 작성해 주세요');
		return false;
	}
	alert("수정완료!");
	return true;
});

$(document).ready(function() {
	var toolbar = [
		// 글꼴 설정
		[ 'fontname', [ 'fontname' ] ],
		// 글자 크기 설정
		[ 'fontsize', [ 'fontsize' ] ],
		// 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
		[ 'style', [ 'bold', 'italic', 'underline', 'strikethrough', 'clear' ] ],
		// 글자색
		[ 'color', [ 'forecolor', 'color' ]],
		// 표만들기
		[ 'table', [ 'table' ]],
		// 글머리 기호, 번호매기기, 문단정렬
		[ 'para', [ 'ul', 'ol', 'paragraph' ]],
		// 줄간격
		[ 'height', [ 'height' ]],
	 	// 그림첨부, 링크만들기, 동영상첨부
		[ 'insert', [ 'picture', 'link', 'video' ]],
		// 코드보기, 확대해서보기, 도움말
		[ 'view', [ 'codeview', 'fullscreen', 'help' ]] 
	];

	var setting = {
		height : 700,
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
				onMediaDelete : function(target) {
					alert(target[0].src);
					deleteImg(target[0].src);
				},
				onKeyup : function(e) {
					var text = $(this).next('.note-editor').find('.note-editable').text();
					var length = text.length;
					var num = 1000 - length;
	
					if (length > 1000) {
						$("#limite_normal").hide();
						$("#limite_vermelho").text(length).show();
						$("#diaryContent").summernote("code", text.substring(0, 1000));
					} else {
						$("#limite_vermelho").hide();
						$("#limite_normal").text(length).show();
				}
			}
		}
	};
	$('#diaryContent').summernote(setting);
	
	function uploadSummernoteImageFile(file, el){	
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
		console.log('시작');
		data = new FormData();
		data.append("file", file);
		$.ajax({
			url: "${pageContext.request.contextPath}/diary/uploadSummernoteImageFile.do",
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
		url: '${pageContext.request.contextPath}/diary/deleteImageFile.do',
		headers: headers,
		type: "POST",
		data: {val: url},
		success(resp){
			console.log(resp);
		},
		error: console.log
	});
};	
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />