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
<title>나:다움 로그인</title>
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
	$(loginModal)
		.modal()
		.on("hide.bs.modal", (e) => {
			location.href='${empty header.referer || header.referer.contains('/member/memberLogin.do') ? pageContext.request.contextPath : header.referer}';
		});
	
});
</script>
</head>
<body>

<!-- Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">로그인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<c:if test="${member.loginType eq 'K'}">
				<form id="kakaoLoginFrm" action="${pageContext.request.contextPath}/member/memberLogin.do" method="post">
					<input type="hidden" name="id" value="${member.id}"/>
					<input type="hidden" name="password" value="${member.id}"/>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</form>
				<script>
				$(() => {					
					$("#kakaoLoginFrm").submit();
				});
				</script>
			</c:if>
			<form
				id="loginFrm"
				action="${pageContext.request.contextPath}/member/memberLogin.do"
				method="post">
				<div class="modal-body">
					<input type="hidden" name="id" id="submit-id" />
					<input type="hidden" name="password" id="submit-password" />
					<c:if test="${param.error != null}">
						<span class="text-danger">아이디 또는 비밀번호가 일치하지 않습니다.</span>
					</c:if>
					<input
						type="text" class="form-control" value="testid" id="input-id"
						placeholder="아이디" required>					
					<br /> 
					<input
						type="password" class="form-control" value="qwer1234" id="input-password"
						placeholder="비밀번호" required>
				</div>
				<div class="modal-footer">
					<div>
						<input type="checkbox" class="form-check-input" name="remember-me" id="remember-me" />
						<label for="remember-me">자동 로그인</label>
					</div>
					<div>
						<a href="${pageContext.request.contextPath}/member/memberFindPassword.do">비밀번호 찾기</a>
						<a href="${pageContext.request.contextPath}/member/memberFindId.do">아이디 찾기</a>
						<a href="${pageContext.request.contextPath}/member/memberEnrollAgreement.do">처음이신가요?</a>
					</div>
					<div>
						<button type="submit" class="btn btn-outline-success">로그인</button>
						<button type="button" class="btn btn-outline-danger" data-dismiss="modal">닫기</button>
					</div>
				</div>
				<div>
					<div id="kakao-login">
						<img src="${pageContext.request.contextPath}/resources/images/member/kakao_login_medium_wide.png" alt="" />
					</div>
				</div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</div>
	</div>
</div>
<script>

$("#kakao-login").click((e) => {
	location.href = "https://kauth.kakao.com/oauth/authorize?client_id=c80d58b59fb1195ccc3d03f74e607831&redirect_uri=http://localhost:9090/nadaum/member/memberKakaoLogin.do&response_type=code";
});


$("#input-id").blur((e) => {
	$("#submit-id").val($("#input-id").val());
});
$("#input-password").blur((e) => {
	$("#submit-password").val($("#input-password").val());
});

</script>


</body>
</html>