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
<title>나:다움 회원탈퇴</title>
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
<link href='${pageContext.request.contextPath}/resources/css/member/mypage/withdrawal.css' rel='stylesheet' />
<script>
$(() => {
	$(membershipWithdrawalModal)
		.modal()
		.on("hide.bs.modal", (e) => {
			location.href='${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=myPage';
		});
});
</script>
</head>
<body>
<!-- Modal -->
<sec:authentication property="principal" var="loginMember"/>
<div class="modal fade" id="membershipWithdrawalModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<div class="withdraw-profile">
					<div class="withdraw-profile-img">
						<c:if test="${loginMember.loginType eq 'K'}">
							<img src="${loginMember.profile}" alt="" />
						</c:if>
						<c:if test="${loginMember.loginType eq 'D'}">
							<c:if test="${loginMember.profileStatus eq 'N'}">							
								<img src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png" alt="" />
							</c:if>
							<c:if test="${loginMember.loginType eq 'Y'}">
								<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${profileImage.originalFilename}" alt="" />
							</c:if>
						</c:if>
					</div>
					<div class="withdraw-profile-nickname">
						<h3>${loginMember.nickname}님</h3>
					</div>
				</div>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form method="POST" action="">
				<div class="modal-body">
					<p>
						${date}일 동안 우리 좋았잖아요<br />
						정말 탈퇴하실 건가요?
					</p>
					<p>
						<span class="text-danger">${write}</span>					
					</p>	
					<input type="text" id="check-user-input-box" class="form-control" placeholder="붉은 글씨를 정확하게 적어주세요" />
					<input type="hidden" name="id" value="${loginMember.id}"/>
				</div>
				<div class="modal-footer">
					<button type="submit" id="agreement-btn" class="btn btn-outline-danger">탈퇴</button>
				</div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</div>
	</div>
</div>
<script>
$("#agreement-btn").click((e) => {
	const $check = $("#check-user-input-box");
	if($check.val() != '${write}'){
		alert('잘못 입력하셨습니다.');
		$(membershipWithdrawalModal).modal('hide');	
		return false;
	}
	return true;
});
</script>

</body>
</html>