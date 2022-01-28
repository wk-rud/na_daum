<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<sec:authentication property="principal" var="loginMember"/>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 관리자페이지" name="title"/>
</jsp:include>
<div class="admin-body">
	<div class="member-managing-head">
		<div class="go-admin-main-btn">
			<button type="button" class="btn btn-success" onclick="location.href='${pageContext.request.contextPath}/member/admin/adminMain.do'">관리자페이지</button>
		</div>
	</div>
	<div class="member-managing-body">
		<div class="managing-table-wrap">
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>아이디</th>
						<th>이름</th>
						<th>이메일</th>
						<th>닉네임</th>
						<th>생일</th>
						<th>주소</th>
						<th>질문횟수</th>
						<th>글 수</th>
						<th>가입일</th>
						<th>가입타입</th>
						<th>활성화여부</th>
						<th>탈퇴</th>
						<th>권한</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="m" varStatus="vs">
						<tr>
							<td>${vs.count}</td>
							<td>${m.id}</td>
							<td>${m.name}</td>
							<td>${m.email}</td>
							<td>${m.nickname}</td>
							<td>${m.birthday}</td>
							<td>${m.address}</td>
							<td></td>
							<td></td>
							<td><fmt:formatDate value="${m.regDate}" pattern="yyyy/MM/dd"/></td>
							<td>
								<c:if test="${m.loginType eq 'K'}">
									<span>카카오</span>
								</c:if>
								<c:if test="${m.loginType ne 'K'}">
									<span>일반</span>
								</c:if>
							</td>
							<td>
								<form method="POST" action="${pageContext.request.contextPath}/member/admin/changeMemberEnabled.do">
									<input type="hidden" name="id" value="${m.id}" />
									<input type="hidden" name="enabledVal" value="${m.enabled}"/>
									<c:if test="${m.enabled eq '1'}">
										<button type="submit" class="btn btn-outline-secondary">비활성</button>
									</c:if>
									<c:if test="${m.enabled ne '1'}">
										<button type="submit" class="btn btn-outline-success">활성</button>
									</c:if>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								</form>
							</td>
							<td>
								<form method="POST" action="${pageContext.request.contextPath}/member/admin/adminDeleteMember.do">
									<c:if test="${fn:length(m.memberRole) == 1}">
										<input type="hidden" name="id" value="${m.id}"/>
										<button type="submit" class="btn btn-outline-danger">탈퇴</button>
									</c:if>
									<c:if test="${fn:length(m.memberRole) > 1}">
										<button type="button" class="btn btn-secondary isManager">탈퇴</button>
									</c:if>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>									
								</form>
							</td>
							<td>
								<form method="POST" action="${pageContext.request.contextPath}/member/admin/changeMemberRole.do">
									<input type="hidden" name="id" value="${m.id}"/>
									<c:if test="${fn:length(m.memberRole) == 1}">
										<input type="hidden" name="role" value="user"/>
										<button type="submit" class="btn btn-outline-success">유저</button>
									</c:if>
									<c:if test="${fn:length(m.memberRole) > 1}">
										<input type="hidden" name="role" value="manager"/>
										<button type="submit" id="manager-to-user" class="btn btn-outline-secondary">매니저</button>
									</c:if>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			${pagebar}
		</div>
	</div>
</div>
<script>
$(".isManager").click((e) => {
	alert('관리자 아이디입니다. 먼저 권한을 해제하세요');
});

$("#manager-to-user").click((e) => {
	<c:if test="${fn:contains(loginMember.authorities, 'SUPER')}">
		return true;
	</c:if>
	alert('슈퍼 관리자 권한이 필요합니다.');
	return false;
});
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />