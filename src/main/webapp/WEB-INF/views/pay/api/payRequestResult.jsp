<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>payResult결과</title>
<style>
div.enroll-container{text-align:center;}
table#tbl-student{margin:0 auto;border:1px solid; border-collapse:collapse;}
table#tbl-student th,table#tbl-student td{
	border:1px solid;
	padding:5px;
}
table#tbl-student th{text-align:right;}
table#tbl-student td{text-align:left;}
table#tbl-student tr:last-of-type td{text-align:center;}
</style>
<c:if test="${not empty msg}">
<script>
	alert("${msg}");
</script>
<c:remove var="msg" scope="session"/>
</c:if>
</head>
<body>

<%-- <h3>${payResult}</h3> --%>
<h2> 결제완료 </h2>
<h3> orderCode = ${payResult.orderCode}</h3>
<h3> memberId = ${payResult.memberId}</h3>
<h3> cid = ${payResult.cid}</h3>
<h3> itemName = ${payResult.itemName}</h3>
<h3> quantity = ${payResult.quantity}</h3>
<h3> card = ${payResult.CARDS}</h3>
<h2> 승인날짜</h2>
<h3> createdAt= <fmt:formatDate value="${payResult.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></h3>

<h3><a href="${pageContext.request.contextPath}/">메인으로</a></h3>
<h3><a href="${pageContext.request.contextPath}/payready/api/payIndex">API Index로 돌아가기</a></h3>
</body>
</html>