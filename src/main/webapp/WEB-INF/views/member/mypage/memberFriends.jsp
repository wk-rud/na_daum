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
<br /><br /><br /><br />
<button type="button" class="btn btn-outline-warning" id="searchFriendBtn">친구검색</button>
<div class="friend-list-wrap">
	<div class="friends-list">
		<span>친구</span>
		<div class="friends-section">
			<c:forEach items="${memberList}" var="ml">
				<c:forEach items="${friends}" var="fr">
					<c:if test="${ml.nickname eq fr.friendNickname}">
						<div class="friend-wrap">
							<c:if test="${ml.loginType eq 'K'}">
								<div class="kakao_thumbnail" style="border-radius:50%; width:45px; height: 45px; overflow:hidden; padding: 0;">
									<img src="${ml.profile}" alt="" style="width:45px; height:45px; object-fit:cover;" />
								</div>
							</c:if>
							<c:if test="${ml.loginType eq 'D'}">
								<div class="friend-profile"></div>
							</c:if>
							<div class="friend-name">${ml.nickname}</div>							
						</div>
					</c:if>
				</c:forEach>
			</c:forEach>
		</div>
	</div>
	<div class="followers-list">
		<span>팔로워</span>
		<div class="followers-section">
			<c:forEach items="${memberList}" var="ml">
				<c:forEach items="${follower}" var="fo">
					<c:if test="${ml.nickname eq fo.followerNickname}">
						<div class="follower-wrap">
							<c:if test="${ml.loginType eq 'K'}">
								<div class="kakao_thumbnail" style="border-radius:50%; width:45px; height: 45px; overflow:hidden; padding: 0;">
									<img src="${ml.profile}" alt="" style="width:45px; height:45px; object-fit:cover;" />
								</div>
							</c:if>
							<c:if test="${ml.loginType eq 'D'}">
								<div class="follower-profile"></div>
							</c:if>
							<div class="follower-name">${ml.nickname}</div>							
						</div>
					</c:if>
				</c:forEach>
			</c:forEach>
		</div>
	</div>
</div>
<script>
$(searchFriendBtn).click((e) => {
	const spec = "left=500px, top=500px, width=400px, height=150px";
	const popup = open('${pageContext.request.contextPath}/member/mypage/memberFindFriend.do', '친구찾기', spec);
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>