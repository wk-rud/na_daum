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
							<td>${m.regDate}</td>
							<td>${m.loginType}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />