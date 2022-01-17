<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="고객센터" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>

<div class="question-list-wrap">
	<div class="question-list-head">
		<h1>질문 모음</h1>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<button class="btn btn-outline-secondary" type="button">검색</button>
			</div>
			<input type="text" class="form-control" placeholder="" aria-label="" aria-describedby="basic-addon1">
		</div>
	</div>
	<div class="question-list-body">
		<c:forEach items="${helpList}" var="help">
			<c:if test="${help.category eq 'me'}">
				<div class="me"><ul class="list-group list-group-flush"><li class="list-group-item">${help.title}</li></ul></div>
			</c:if>
			<c:if test="${help.category eq 'dy'}">
				<div class="dy"><ul class="list-group list-group-flush"><li class="list-group-item">${help.title}</li></ul></div>
			</c:if>
			<c:if test="${help.category eq 'ab'}">
				<div class="ab"><ul class="list-group list-group-flush"><li class="list-group-item">${help.title}</li></ul></div>
			</c:if>
			<c:if test="${help.category eq 'cu'}">
				<div class="cu"><ul class="list-group list-group-flush"><li class="list-group-item">${help.title}</li></ul></div>
			</c:if>
		</c:forEach>
	</div>
</div>

<script>
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>