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
<title>나:다움 프로필사진</title>
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
<link href='${pageContext.request.contextPath}/resources/css/member/mypage/changeProfile.css' rel='stylesheet' />
<script>
$(() => {
	$(changeProfileModal)
		.modal()
		.on("hide.bs.modal", (e) => {
			location.href='${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=myPage';
		});
});
</script>
</head>
<body>
<!-- Modal -->
<div class="modal fade" id="changeProfileModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">프사 변경</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">	
				<div class="member-profile-change-body">
					<div class="member-profile-image">
						<img class="change-profile-img"/>
					</div>
					<div class="change-profile-btn">
						<label for="profile">선택</label>
						<input type="file" name="profile" id="profile" accept="image/*" onchange="preview();"/>
					</div>
				</div>
 			</div>
			<div class="modal-footer">
				<button type="button" id="agreement-btn" class="btn btn-primary">변경하기</button>
			</div>
		</div>
	</div>
</div>
<script>
const preview = () => {
	const reader = new FileReader();
	reader.onload = function(event){
		$(".change-profile-img").attr("src", event.target.result);
	}
	reader.readAsDataURL(event.target.files[0]);
};
</script>

</body>
</html>