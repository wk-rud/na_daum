<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link href='${pageContext.request.contextPath}/resources/css/member/mypage/member.css' rel='stylesheet' />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 질문상세보기" name="title"/>
</jsp:include>
<c:if test="${not empty msg}">
	<script>
		alert("${msg}");
	</script>
</c:if>
<div class="member-body">
	<div class="help-detail-wrap">
		<h1>${helpDetail.title}</h1>
		<section class="question-wrap">
			<div class="q-date-wrap"><h5>등록일: <fmt:formatDate value="${helpDetail.regDate}" pattern="yyyy-MM-dd"/></h5></div>
			<div class="q-content-wrap">
				<div class="q-start"><h3>내용 : </h3></div>
				<div class="q-content"><p>${helpDetail.content}</p></div>
			</div>
			<div class="q-info-wrap">
				<div class="q-writer-info">${helpDetail.nickname}</div>
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
		<c:if test="${not empty helpDetail.aCode}">
			<section class="answer-wrap">
				<div class="a-date-wrap"><h5>답변일: <fmt:formatDate value="${helpDetail.aRegDate}" pattern="yyyy-MM-dd"/></h5></div>
				<div class="a-content-wrap">
					<div class="a-start"><h3>답변 : </h3></div>
					<div class="a-title"><p>${helpDetail.aTitle}</p></div>
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