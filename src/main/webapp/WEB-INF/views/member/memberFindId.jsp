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
<title>나:다움 아이디 찾기</title>
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
	$(findIdModal)
		.modal()
		.on("hide.bs.modal", (e) => {
			location.href='${pageContext.request.contextPath}';
		});
});
</script>
</head>
<body>
<!-- Modal -->
<div class="modal fade" id="findIdModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<form id="findIdFrm" method="POST">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">아이디 찾기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="select-find-id-method">
						<label for="methodEmail">이메일로 찾기</label>
						<input type="checkbox" id="methodEmail" name="methodEmail"/>
						<label for="methodPhone">핸드폰으로 찾기</label>
						<input type="checkbox" id="methodPhone" name="methodPhone"/>
					</div>
					<div class="mothod-wrap">						
						<div class="find-by-email">
							<label for="email">이메일</label>
							<input type="text" name="email" id="email" class="form-control" placeholder="등록된 이메일">
								
						</div>
						<div class="find-by-phone">
							<label for="phone">핸드폰</label>
							<input type="tel" id="phone" class="form-control" name="phone" placeholder="등록된 핸드폰을 입력해주세요"/>
						</div>
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
const $methodEmail = $("#methodEmail");
const $methodPhone = $("#methodPhone");
const $findByEmail = $(".find-by-email");
const $findByPhone = $(".find-by-phone");
const $email = $("#email");
const $phone = $("#phone");

$findByEmail.hide();
$findByPhone.hide();

$methodEmail.change((e) => {			
	if($methodEmail.is(':checked')){
		$methodPhone.prop('checked', false);
		$findByEmail.show();
		$findByPhone.hide();		
	}else{
		$findByEmail.hide();
	}
});

$methodPhone.change((e) => {
	if($methodPhone.is(':checked')){
		$methodEmail.prop('checked', false);
		$findByPhone.show();
		$findByEmail.hide();		
	}else{
		$findByPhone.hide();
	}
});

$("#agreement-btn").click((e) => {
	if(($methodEmail.is(':checked') == false) && ($methodPhone.is(':checked') == false)){
		alert('방법을 선택해주세요');
		return false;
	}
	if($methodEmail.is(':checked')){
		if($email.val() == ''){
			alert('이메일을 입력해주세요');
			$email.focus();
			return false;
		};
	};
	if($methodPhone.is(':checked')){
		if($phone.val() == ''){
			alert('핸드폰을 입력해주세요');
			$phone.focus();
			return false;
		};
	};
	return true;
});
</script>
</body>
</html>