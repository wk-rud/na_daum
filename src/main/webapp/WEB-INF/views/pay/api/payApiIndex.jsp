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
		<li><a href="${pageContext.request.contextPath}/payready/servlet">서블릿 처리</a></li>
		<li><a href="${pageContext.request.contextPath}/payready/rest">REST API 처리</a></li>
	</ul>
	
	<h2>정기결제</h2>
	<ul>
		<li><a href="${pageContext.request.contextPath}/payready/empSearch1.do">/emp/empSearch1.do</a></li>
		<li><a href="${pageContext.request.contextPath}/payready/empSearch2.do">/emp/empSearch2.do</a></li>
		<li><a href="${pageContext.request.contextPath}/payready/empSearch3.do">/emp/empSearch3.do</a></li>
	</ul>
	
</body>
</html>
