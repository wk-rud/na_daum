<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:if test="${not empty msg}">
<script>
	alert("${msg}");
</script>
<c:remove var="msg" scope="session"/>
</c:if>
</head>
<body>
	<h1>PayApiIndexPage</h1>
	<h2>단건결제</h2>
	<ul>
		<li><a href="${pageContext.request.contextPath}/payready/api/payEnroll">API 흐름설명</a></li>
		<li><a href="${pageContext.request.contextPath}/payready/modal">모달창 처리</a></li>
		<li><a href="${pageContext.request.contextPath}/payready/rest">REST API 처리</a></li>
	</ul>
	<!-- 정기결제의 경우 방식은 비슷하지만 sid토큰을 발행해주는방식이 필요함.-->
	<!-- 컨트롤러를 분리하도록 하자. -->
	<h2>정기결제</h2>
	<ul>
		<li><a href="${pageContext.request.contextPath}/payready/monthly">정기결제</a></li>
		<li><a href="${pageContext.request.contextPath}/payready/monthlyModal">모달창 처리</a></li>
		<li><a href="${pageContext.request.contextPath}/payready/monthlyRest">정기결제 REST API</a></li>
	</ul>
	
</body>
</html>
