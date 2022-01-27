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
<title>나:다움 비밀번호 변경</title>
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(() => {
	$(changePwModal)
		.modal()
		.on("hide.bs.modal", (e) => {
			location.href='${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=myPage';
		});	
});
</script>
</head>
<body>
<!-- Modal -->
<div class="modal fade" id="changePwModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">비밀번호 변경</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form method="POST">
				<div class="modal-body">										
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="cp1">현재 비밀번호</span>
						</div>
						<input type="password" id="currentPassword" name="currentPassword" class="form-control" aria-label="Username" aria-describedby="cp1">
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="cp2">변경할 비밀번호</span>
						</div>
						<input type="password" id="password" name="password" class="form-control" aria-label="Username" aria-describedby="cp2">
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="cp3">비밀번호 확인</span>
						</div>
						<input type="password" id="passwordCheck" class="form-control" aria-label="Username" aria-describedby="cp3">
					</div>
	 			</div>
				<div class="modal-footer">
					<button type="submit" id="agreement-btn" class="btn btn-primary">확인</button>
	       			<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</div>
	</div>
</div>
<script>

$("#agreement-btn").click((e) => {
	const $currentPassword = $("#currentPassword");
	const $password = $("#password");
	const $passwordCheck = $("#passwordCheck");
	
	if($currentPassword.val() == ''){
		alert("현재 비밀번호를 입력하세요");
		$currentPassword.focus();
		return false;
	}
	// 비밀번호	
	if($password.val() == ''){
		alert("변경할 비밀번호를 입력하세요");
		$password.focus();
		return false;
	}
	if(! /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,15}$/.test($password.val())){
        alert("비밀번호는 숫자와 영문이 포함된 8~15자리입니다");
		$password.focus();
		return false;
    }
	
	// 비밀번호 일치 확인
	if($password.val() != $passwordCheck.val()){
    	alert("비밀번호가 일치하지 않습니다.");
		$passwordCheck.focus();
		return false;
	}
	return true;
});

</script>

</body>
</html>