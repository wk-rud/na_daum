<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 공지사항" name="title"/>
</jsp:include>

<div class="member-body">
	<div class="announcement-detail-wrap">
		<div class="announcement-detail-header">
			<span>${announce.title}</span>
		</div>
		<div class="announcement-detail-info">
			<div class="announcement-writer">			
				<span>운영진<sec:authorize access="hasRole('ROLE_ADMIN')">(${announce.id})</sec:authorize></span>
			</div>
			<div class="announcement-date">
				<span><fmt:formatDate value="${announce.regDate}" pattern="yyyy.MM.dd"/></span>
			</div>
			<div class="announcement-read-count">
				<span>${announce.readCount}</span>
			</div>
		</div>
		<div class="announcement-detail-body-wrap">
			<div class="announcement-detail-section">
				<p>${announce.content}</p>
			</div>
			<div class="go-announce-main-btn">
				<button type="button" class="btn btn-success" onclick="location.href='${pageContext.request.contextPath}/member/mypage/memberAnnouncement.do'">목록</button>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />