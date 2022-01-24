<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나:다움 별명 변경</title>
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js" charset="utf-8"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">

<script>
$(() => {	
	$(modifyNickname)
		.modal()
		.on("hide.bs.modal", (e) => {
			location.href='${empty header.referer ? pageContext.request.contextPath : header.referer}';
		});
});
</script>
</head>
<body>
<sec:authentication property="principal" var="loginMember"/>
<!-- Modal -->
<div class="modal fade" id="modifyNickname" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">별명 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="nicknameModifyFrm" method="POST" action="${pageContext.request.contextPath}/member/memberModifyNickname.do">
					<div class="input-group mb-3">
						<input type="hidden" name="id" value="${loginMember.id}" />
						<div class="input-group-prepend">
							<button id="modify-nickname-btn" class="btn btn-outline-secondary" type="button">수정하기</button>
						</div>
						<input type="text" name="nickname" id="modify-nickname" class="form-control" placeholder="별명을 입력하세요" aria-label="" aria-describedby="basic-addon1">
						<span class="text-success guide n-ok">사용가능한 별명입니다.</span>
						<span class="text-danger guide n-error">사용할 수 없는 별명입니다.</span>
						<input type="hidden" id="nValid" value="0" />
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
const $nError = $(".guide.n-error");
const $nOk = $(".guide.n-ok");
const $nValid = $(nValid);
$nError.hide();
$nOk.hide();

$("#modify-nickname-btn").click((e) => {
	e.preventDefault();
	if($nValid.val() == '1'){
		$("#nicknameModifyFrm").submit();
	}
});

$("#modify-nickname").keyup((e) => {
	let val = $("#modify-nickname").val();
	console.log(val);
	
	// 별명 중복 검사	
	if(val.length < 2){
		$nError.hide();
		$nOk.hide();
		$nValid.val(0);
		return;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/checkNicknameDuplicate.do",
		data:{
			nickname: val 
		},
		success(resp){
			console.log(resp);
			const {available} = resp;
			if(available){
				console.log("val : " + val);
				if(/^[ㄱ-ㅎ가-힣a-zA-Z]{2,8}$/.test(val)){
					$nError.hide();
					$nOk.show();		
					$nValid.val(1);
				}else{
					$nError.show();
					$nOk.hide();
					$nValid.val(0);
				}
			}else{
				$nError.show();
				$nOk.hide();
				$nVAlid.val(0);
			}
		},
		error: console.log
	});
	
});
</script>

</body>
</html>