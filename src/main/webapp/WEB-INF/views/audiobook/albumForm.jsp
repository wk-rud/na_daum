<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/audiobook/common/audioBookHeader.jsp">
	<jsp:param value="album 등록" name="pageTitle"/>
</jsp:include>
<style>
div#board-container{width:400px; margin:0 auto; text-align:center;}
div#board-container input{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}

</style>
<script>
/* textarea에도 required속성을 적용가능하지만, 공백이 입력된 경우 대비 유효성검사를 실시함. */
function albumValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}

/* const fnValid = function fileNameValid(){
	$("[id=upFile1]").change((e) => {
		const file1 = $(e.target).prop('files')[0];
		console.log(file1.name);
 		const fileLen = file1.name.length;
 		console.log(fileLen);
		const lastDot = file1.name.lastIndexOf('.');
		console.log(lastDot);
		const fileExt = file1.name.substring(lastDot,fileLen).toLowerCase(); 
		const fileType = ["jpg","png","jpeg","bmp"];
		const check = fileType.includes(file1.name);
		console.log(check); 
		return check;
	});
} */

$(() => {
	/**
	 * 파일명 표시하기
	 */
	$("[name=upFile]").change((e) => {
		const file = $(e.target).prop('files')[0];
		const $label = $(e.target).next();
		
		if(file != undefined)
			$label.html(file.name);
		else
			$label.html("파일을 선택하세요.");
		
		if($label.html!="파일을 선택하세요."){
			console.log(file.name);	
		}
		
	});
	
	//검증
	$("[id=upFile1]").change((e) => {
		const file1 = $(e.target).prop('files')[0];
		console.log(file1.name);
 		const fileLen = file1.name.length;
 		 console.log(fileLen); 
		const lastDot = file1.name.lastIndexOf('.');
		console.log(lastDot); 
		const fileExt = file1.name.substring(lastDot+1,fileLen).toLowerCase(); 
		console.log(fileExt);
		const fileType = ["jpg","png","jpeg","bmp"];
		const check1 = fileType.includes(fileExt);
		console.log(check1); 
		return check1;
	});
	
	$("[id=upFile2]").change((e) => {
		const file2 = $(e.target).prop('files')[0];
		console.log(file2.name);
 		const fileLen = file2.name.length;
 		 console.log(fileLen); 
		const lastDot = file2.name.lastIndexOf('.');
		console.log(lastDot); 
		const fileExt = file2.name.substring(lastDot+1,fileLen).toLowerCase(); 
		console.log(fileExt);
		const fileType = 'mp3';
		const check2 = (fileType==fileExt);
		console.log(check2); 
		return check2;
	});

	
});

/* 
	
		onsubmit="return albumValidate()&&fnValid();"
			?${_csrf.parameterName}=${_csrf.token}*/

/* ${_csrf.parameterName}=${_csrf.token} */
					
</script>
<div id="board-container">
	<form 
		name="albumFrm" 
		action="${pageContext.request.contextPath}/audiobook/albumEnroll?${_csrf.parameterName}=${_csrf.token}" 
		method="post"
		enctype="multipart/form-data"
		>
		<input type="text" class="form-control" placeholder="코드" name="code" id="code" required>
		<input type="text" class="form-control" placeholder="제목" name="title" id="title" required>
		<input type="text" class="form-control" placeholder="제작사" name="provider" id="provider" required>
		<input type="text" class="form-control" placeholder="크리에이터" name="creator" id="creator" required>
		<input type="text" class="form-control" placeholder="장르" name="kind" id="kind" required>
		
		<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input -->
		<div class="input-group mb-3" style="padding:0px;">
		  <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">앨범커버</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile1">
		    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
		  </div>
		</div>
		<div class="input-group mb-3" style="padding:0px;">
		  <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">음원파일</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile2">
		    <label class="custom-file-label" for="upFile2">파일을 선택하세요</label>
		  </div>
		</div>
		
	    <textarea class="form-control" name="content" placeholder="내용" required></textarea>
		<br />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
		<input type="submit" class="btn btn-outline-success" value="저장">
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>