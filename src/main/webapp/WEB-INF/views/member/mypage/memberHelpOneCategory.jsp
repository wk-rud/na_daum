<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 ${check} 질문 모음" name="title"/>
</jsp:include>
<div class="member-body">
	<div class="help-one-category-wrap">
		<div class="me">
			<div class="help-head-wrap">
				<div class="help-title">
					<span>${check}</span>
				</div>
				<button type="button" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/member/mypage/memberHelpEnroll.do'">질문하기</button>
			</div>
			<div class="help-list-main">
				<c:forEach items="${help}" var="he">
					<ul class="list-group list-group-flush">
						<li class="list-group-item">
							<a href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=${he.code}" class="list-group-item list-group-item-action">
								${he.title}<c:if test="${he.status eq 'T'}"> - 답변완료</c:if><span><fmt:formatDate value="${he.regDate}" pattern="yy.MM.dd"/></span>
							</a>						
						</li>
					</ul>
				</c:forEach>
			</div>
			<div class="help-list-footer">
				${pagebar}
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />