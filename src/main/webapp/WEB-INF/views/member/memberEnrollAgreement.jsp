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
<title>나:다움 회원가입</title>
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
	$(enrollAgreementModal)
		.modal()
		.on("hide.bs.modal", (e) => {
			location.href='${pageContext.request.contextPath}';
		});
});
</script>
</head>
<body>
<!-- Modal -->
<div class="modal fade" id="enrollAgreementModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">개인정보 관련 동의사항</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">								
				<div id="accordion">
					<div class="card">
						<div class="card-header" id="headingOne">
							<h5 class="mb-0">
								<button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
									개인정보 이용 동의
								</button>
								<span class="text-danger agree1-fail">동의미완료</span>
							</h5>
						</div>
					</div>
					<div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
						<div class="card card-body">
							개인정보 이용 동의하세요
							<label for="agree1">동의합니다.</label>
							<input type="checkbox" id="agree1" />
						</div>
					</div>
					
					<div class="card">
						<div class="card-header" id="headingTwo">
							<h5 class="mb-0">
								<button class="btn btn-link" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
									개인정보 이용 동의
								</button>
								<span class="text-danger agree2-fail">동의미완료</span>
							</h5>
						</div>
					</div>
					<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
						<div class="card card-body">
							개인정보 이용 동의하세요
							<label for="agree2">동의합니다.</label>
							<input type="checkbox" id="agree2" />
						</div>
					</div>					
				</div>
					
 			</div>
			<div class="modal-footer">
				<button type="button" id="agreement-btn" class="btn btn-primary">동의합니다.</button>
       			<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script>
const $agreeFail1 = $(".agree1-fail");
const $agreeFail2 = $(".agree2-fail");
$agreeFail1.hide();
$agreeFail2.hide();

$("#agreement-btn").click((e) => {
	let $agree1 = $("#agree1").is(':checked');
	let $agree2 = $("#agree2").is(':checked');
	const $collapse1 = $("#collapseOne");
	const $collapse2 = $("#collapseTwo");
	
	if($agree1 && $agree2){
		
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
		
		$.ajax({
			url: '${pageContext.request.contextPath}/member/memberAgreementCheck.do',
			headers: headers,
			method: "POST",
			data: {agree:'agree'},
			success(resp){
				console.log(resp);
				 location.href=`${pageContext.request.contextPath}/member/memberEnroll.do?agree=\${resp.agree}`;
			}
		});
		
	}else if(!$agree1){
		alert("동의사항을 읽고 모두 동의해주세요");	
		$agreeFail1.show();
		$collapse1.addClass('show');
	}else if(!$agree2){
		alert("동의사항을 읽고 모두 동의해주세요");	
		$agreeFail2.show();
		$collapse2.addClass('show');
	}
});
</script>

</body>
</html>