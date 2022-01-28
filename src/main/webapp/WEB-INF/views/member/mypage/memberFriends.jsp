<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 친구관리" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<div class="member-body">
	<button type="button" class="btn btn-outline-warning" id="searchFriendBtn">친구검색</button>
	<div class="friend-list-wrap">
		<div class="friends-list">
			<div class="friend">
				<span>친구</span>
			</div>
			<div class="friends-section">
				<c:forEach items="${memberList}" var="ml">
					<c:forEach items="${friends}" var="fr">
						<c:if test="${ml.id eq fr.friendId}">
							<div class="friend-wrap">
								<div class="thumbnail-wrap" style="border-radius:50%; width:45px; height: 45px; overflow:hidden; padding: 0;">
									<c:if test="${ml.loginType eq 'K'}">
										<img src="${ml.profile}" alt="" style="width:45px; height:45px; object-fit:cover;" />								
									</c:if>
									<c:if test="${ml.loginType eq 'D'}">									
										<c:if test="${ml.profileStatus eq 'N'}">							 		
											<img src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png" alt="" style="width:45px; height:45px; object-fit:cover;" />
										</c:if>						
										<c:if test="${ml.profileStatus eq 'Y'}">		
											<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${attach.renamedFilename}" alt="" style="width:45px; height:45px; object-fit:cover;" />										 		
										</c:if>	
									</c:if>
								</div>
								<div class="friend-name-wrap">
									<span class="friend-name">${ml.nickname}</span>								
								</div>
								<div class="friend-btn">
									<button type="button" id="end-friend" class="btn btn-outline-danger">친구삭제</button>
								</div>							
							</div>
						</c:if>
					</c:forEach>
				</c:forEach>
			</div>
		</div>
		<div class="followers-list">
			<div class="follower">
				<span>팔로워</span>
			</div>
			<div class="followers-section">
				<c:forEach items="${memberList}" var="ml">
					<c:forEach items="${follower}" var="fo">
						<c:if test="${ml.id eq fo.followerId}">
							<div class="follower-wrap">
								<div class="thumbnail-wrap" style="border-radius:50%; width:45px; height: 45px; overflow:hidden; padding: 0;">
									<c:if test="${ml.loginType eq 'K'}">
										<img src="${ml.profile}" alt="" style="width:45px; height:45px; object-fit:cover;" />								
									</c:if>
									<c:if test="${ml.loginType eq 'D'}">									
										<c:if test="${ml.profileStatus eq 'N'}">							 		
											<img src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png" alt="" style="width:45px; height:45px; object-fit:cover;" />
										</c:if>						
										<c:if test="${ml.profileStatus eq 'Y'}">		
											<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${attach.renamedFilename}" alt="" style="width:45px; height:45px; object-fit:cover;" />										 		
										</c:if>	
									</c:if>
								</div>
								<div class="follower-name-wrap">
									<span class="follower-name">${ml.nickname}</span>
								</div>		
								<div class="follower-btn">
									<button type="button" id="friend-with-follower" class="btn btn-outline-warning">친구추가</button>
								</div>					
							</div>
						</c:if>
					</c:forEach>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<script>
$(searchFriendBtn).click((e) => {
	const spec = "left=500px, top=500px, width=400px, height=150px";
	const popup = open('${pageContext.request.contextPath}/member/mypage/memberFindFriend.do', '친구찾기', spec);
});

$("#friend-with-follower").click((e) => {
	let nickname = $(".follower-name").text();
	alarmSave('fr', 'follower', '${loginMember.id}', nickname);
	updateFriend('follower', nickname);
});

$("#end-friend").click((e) => {
	let nickname = $(".friend-name").text();
	alarmSave('fr', 'friend', '${loginMember.id}', nickname);
	updateFriend('friend', nickname);
});

const updateFriend = (check, friendNickname) => {
	
	const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	$.ajax({
		url: '${pageContext.request.contextPath}/member/mypage/updateFriend.do',
		data: {check, friendNickname},
		headers: headers,
		method: "POST",
		success(resp){
			if(resp == '0')
				location.reload();
			else{
				console.log("change success");
				location.reload();
			}
		},
		error: console.log
	});
};

const alarmSave = (type, flag, senderId, findVal) => {
	let socketMsg = type + "," + flag + "," + senderId + "," + findVal;
	socket.send(socketMsg);		
};
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>