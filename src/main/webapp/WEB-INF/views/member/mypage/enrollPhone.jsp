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
<title>나:다움 핸드폰 등록</title>
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
	$(enrollPhoneModal)
		.modal()
		.on("hide.bs.modal", (e) => {
			location.href='${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=myPage';
		});	
});
</script>
</head>
<body>
<!-- Modal -->
<div class="modal fade" id="enrollPhoneModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">핸드폰 등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form method="POST">
				<div class="modal-body">	
					<div class="enroll-timer-wrap">
						<span id="enrollTimeCheck">03:00</span>
					</div>			
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="ep1">입력한 전화번호</span>
						</div>
						<input type="text" id="phone" name="phone" value="${map.phone}" class="form-control" aria-label="Username" aria-describedby="ep1" readonly>
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="ep2">인증번호</span>
						</div>
						<input type="text" id="sendNum" name="sendNum" class="form-control" aria-label="Username" aria-describedby="ep2">
					</div>
	 			</div>
				<div class="modal-footer">
					<button type="submit" id="agreement-btn" class="btn btn-primary">확인</button>
	       			<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
				<input type="hidden" id="checkNum" name="checkNum" value="${map.num}" />
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</div>
	</div>
</div>
<script>
function startTimer(duration, display) {
    var timer = duration, minutes, seconds;
    setInterval(function () {
        minutes = parseInt(timer / 60, 10);
        seconds = parseInt(timer % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.text(minutes + ":" + seconds);

        if (--timer < 0) {
        	location.href="${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=myPage";
        }
    }, 1000);
}

$(() => {
    var limitTime = 60 * 3,
        display = $('#enrollTimeCheck');
    startTimer(limitTime, display);	
});


$("#agreement-btn").click((e) => {
	const $sendNum = $("#sendNum");
	const $checkNum = $("#checkNum");
	
	if($sendNum.val() == ''){
		alert("인증번호를 입력하세요");
		$sendNum.focus();
		return false;
	}
	if($sendNum.val() != $checkNum.val()){
		alert("잘못된 인증번호 입니다.");
		$checkNum.focus();
		return false;
	}
	return true;
});

</script>

</body>
</html>