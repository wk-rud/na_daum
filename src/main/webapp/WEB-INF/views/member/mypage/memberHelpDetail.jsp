<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 질문상세보기" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<div class="member-body">
	<div class="help-detail-wrap">
		<div class="help-detail-body">
			<span class="help-title">${helpDetail.title}</span>
			<section class="question-wrap">
				<div class="q-date-wrap"><span>등록일: <fmt:formatDate value="${helpDetail.regDate}" pattern="yyyy-MM-dd"/></span></div>
				<div class="q-content-wrap">
					<div class="q-start"><span>내용 : </span></div>
					<div class="q-content"><p>${helpDetail.content}</p></div>
				</div>
				<div class="q-info-wrap">
					<div class="q-writer-info">
						<div class="thumbnail-wrap" style="border-radius:50%; width:45px; height: 45px; overflow:hidden; padding: 0;">
							<c:if test="${loginMember.loginType eq 'K'}">
								<img src="${loginMember.profile}" alt="" style="width:45px; height:45px; object-fit:cover;" />								
							</c:if>
							<c:if test="${loginMember.loginType eq 'D'}">									
								<c:if test="${loginMember.profileStatus eq 'N'}">							 		
									<img src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png" alt="" style="width:45px; height:45px; object-fit:cover;" />
								</c:if>						
								<c:if test="${loginMember.profileStatus eq 'Y'}">		
									<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${attach.renamedFilename}" alt="" style="width:45px; height:45px; object-fit:cover;" />										 		
								</c:if>	
							</c:if>
						</div>
						${helpDetail.nickname}
					</div>
					<div class="q-button">
						<label for="empathy">공감해요</label>
						<input type="checkbox" name="empathy" id="empathy" 
							<c:forEach items="${checkLikes}" var="check">
								<c:if test="${fn:contains(check.code, 'he')}">
									checked="checked"
								</c:if>
							</c:forEach>
						/>
					</div>
				</div>
			</section>
			<hr />
			<c:if test="${not empty helpDetail.aCode}">
				<section class="answer-wrap">
					<div class="a-title-wrap">
						<div class="a-title"><p>${helpDetail.aTitle}</p></div>
						<div class="a-date-wrap"><span>답변일: <fmt:formatDate value="${helpDetail.aRegDate}" pattern="yyyy-MM-dd"/></span></div>
					</div>
					<div class="a-content-wrap">
						<div class="a-start"><span>답변 : </span></div>
						<div class="a-content"><p>${helpDetail.aContent}</p></div>
					</div>
					<div class="a-info-wrap">
						<label for="good">답변이 도움이 됩니다</label>
						<input type="checkbox" name="good" id="good" 
							<c:forEach items="${checkLikes}" var="check">
								<c:if test="${fn:contains(check.code, 'ah')}">
									checked="checked"
								</c:if>
							</c:forEach>
						/>
					</div>
				</section>
			</c:if>
		</div>
		<div class="help-footer">
		<button type="button" id="backToList" class="btn btn-warning">전체목록</button>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/member/admin/adminHelpAnswer.do?code=${helpDetail.code}'">답변 수정 및 작성</button>
		</sec:authorize>
		</div>
	</div>
</div>
<script>
const helpCode = '${helpDetail.code}';
$("#empathy").change((e) => {
	if($("#empathy").is(":checked")){
		likeChange('t', helpCode);
	}else{
		likeChange('f', helpCode);
	}
});

<c:if test="${not empty helpDetail.aCode}">
const helpACode = '${helpDetail.aCode}';
$("#good").change((e) => {
	if($("#good").is(":checked")){
		likeChange('t', helpACode);
	}else{
		likeChange('f', helpACode);
	}
});
</c:if>

const likeChange = (flag, code) => {
	
	const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	$.ajax({
		url:'${pageContext.request.contextPath}/member/memberChangeLike.do',
		method:"POST",
		headers: headers,
		data:{flag, code},
		success(resp){
			if(resp.result > 0)
				console.log('success');
			else
				console.log("fail");
		},
		error:console.log
	});	
};

$(backToList).click((e) => {
	location.href="${pageContext.request.contextPath}/member/mypage/memberHelp.do";
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>