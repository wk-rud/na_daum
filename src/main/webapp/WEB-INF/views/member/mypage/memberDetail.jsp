<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 회원정보" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<div class="section">
	<!-- 왼쪽 메뉴list -->
	<div class="absolute-left">
		<ul class="list-group">
			<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=myPage">마이페이지</a></li>
			<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=alarm">알림</a></li>
			<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberMyHelp.do">내가 한 질문</a></li>
			<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberFriends.do">친구관리</a></li>
			<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberHelp.do">질문모음</a></li>
			<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberAnnouncement.do">공지사항</a></li>
		</ul>
		<!-- 메뉴리스트 하단 작게 -->
		<div class="out">
			<a href="">회원탈퇴</a>
		</div>
	</div>
	
	<!-- 메인 -->
	<div class="main-section">
		<c:if test="${param.tPage eq 'myPage'}">
			<div class="info-profile-wrap">
				<div class="profile-div-wrap">
					<div class="profile-div">
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
						<div class="nickname-wrap">
							<span>${loginMember.nickname}</span>
							<button type="button" id="modify-nickname-modal" class="btn btn-outline-warning">별명 수정</button>
						</div>
					</div>
				</div>
				<div class="info-form">
					<form id="memberUpdateFrm">
						<input type="text" class="form-control" name="id" id="id" value="${loginMember.id}" readonly required/>
						<input type="text" class="form-control" placeholder="이름" name="name" id="name" value="${loginMember.name}" readonly required/>
						<input type="text" class="form-control" placeholder="이메일" name="email" id="email" value="${loginMember.email}" readonly required/>
						<input type="text" class="form-control" placeholder="주소" name="address" id="address" value="${loginMember.address}" readonly required/>
						<input type="text" class="form-control" placeholder="전화번호" name="phone" id="phone" value="${loginMember.phone}" readonly required/>
											
						
						<input type="submit" class="btn btn-outline-success" value="수정" >
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					</form>
				</div>				
			</div>
			
			
		
			<script>
			$(memberUpdateFrm).submit((e) => {
				e.preventDefault();
				
				const csrfHeader = "${_csrf.headerName}";
				const csrfToken = "${_csrf.token}";
				const headers = {};
				headers[csrfHeader] = csrfToken;
				
				$.ajax({
					url: "${pageContext.request.contextPath}/member/memberUpdate.do",
					data: $(e.target).serialize(),
					headers: headers,
					method: "POST",
					success(resp){
						console.log(resp);
					},
					error:console.log
				});
			});
			
			$("#modify-nickname-modal").click((e) => {
				location.href="${pageContext.request.contextPath}/member/mypage/memberModifyNickname.do";
			});
			</script>
		</c:if>
		<c:if test="${param.tPage eq 'alarm'}">
			<div class="alarm-wrap">
				<ul class="list-group">
					<c:forEach items="${alarmList}" var="al">
						<c:if test="${al.status eq 'F'}">
							<li class="list-group-item">${al.content}</li>
						</c:if>
						<c:if test="${al.status eq 'T'}">
							<li class="list-group-item list-group-item-secondary">${al.content}</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
  			
		</c:if>
	</div>
	
</div>
<script>

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>