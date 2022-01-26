<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 관리자페이지" name="title"/>
</jsp:include>

<div class="admin-body">
	<div class="admin-section">
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>공감수</th>
					<th>등록일</th>
					<th>답변</th>
					<th>답변공감수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${listMap}" var="list" varStatus="vs">
					<tr>
						<td>${vs.count}</td>
						<td><a href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=${list.code}">${list.title}</a></td>
						<td>${list.id}</td>
						<td>${list.count}</td>
						<td><fmt:formatDate value="${list.regDate}" pattern="yyyy/MM/dd"/></td>
						<td>
							<c:if test="${list.status eq 'F'}">
								<button id="enrollAnswer" type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/member/admin/adminHelpAnswer.do?code=${list.code}'">답변하기</button>
							</c:if>
							<c:if test="${list.status ne 'F'}">
								<button id="modifyAnswer" type="button" class="btn btn-warning" onclick="location.href='${pageContext.request.contextPath}/member/admin/adminHelpAnswer.do?code=${list.code}'">답변수정</button>
							</c:if>
						</td>
						<td>${list.ACount}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		${pagebar}
	</div>
</div>
<script>
$("#enrollAnswer").click((e) => {
	
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />