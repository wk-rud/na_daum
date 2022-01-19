<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>payReady결과</title>
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

<%-- <h3>${payReady}</h3> --%>
<h2> 사용자 입력값 반환</h2>
<h3> cid = ${payReady.cid}</h3>
<h3> partnerOrderId = ${payReady.partnerOrderId}</h3>
<h3> partnerUserId = ${payReady.partnerUserId}</h3>
<h3> itemName = ${payReady.itemName}</h3>
<h3> quantity = ${payReady.quantity}</h3>
<h3> card = ${payReady.CARDS}</h3>
<h2> 발급된 키</h2>
<h3> tid = ${payAuth.tid}</h3>
<h3> pgToken = ${payAuth.pgToken}</h3>

</body>
</html>