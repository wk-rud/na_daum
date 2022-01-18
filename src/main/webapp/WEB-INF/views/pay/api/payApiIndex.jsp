<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="utf-8" %>
<html>
<body>
	<h1>PayApiIndexPage</h1>
	<h2>단건결제</h2>
	<ul>
		<li><a href="${pageContext.request.contextPath}/payready/api/payEnroll">/payready/api/payEnroll</a></li>
		<li><a href="${pageContext.request.contextPath}/payready/payRequest">/payready/payRequest</a></li>
		<li><a href="${pageContext.request.contextPath}/payready/selectList">/payready/selectList</a></li>
	</ul>
	
	<h2>정기결제</h2>
	<ul>
		<li><a href="${pageContext.request.contextPath}/payready/empSearch1.do">/emp/empSearch1.do</a></li>
		<li><a href="${pageContext.request.contextPath}/payready/empSearch2.do">/emp/empSearch2.do</a></li>
		<li><a href="${pageContext.request.contextPath}/payready/empSearch3.do">/emp/empSearch3.do</a></li>
	</ul>
	
</body>
</html>
