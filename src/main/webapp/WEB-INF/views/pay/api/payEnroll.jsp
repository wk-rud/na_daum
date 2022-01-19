<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>payments</title>
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
	<div class="enroll-container">
		<h2>단건결제준비(VO)</h2>
		<form method="post" action="${pageContext.request.contextPath}/payready/api/payEnroll">
			<table id="tbl-student">
				
				<tr>
					<th>주문번호</th>
					<td>
						<input type="text" name="orderCode" value="nd0120" required/>
					</td>
				</tr>
				<tr>
					<th>회원 id</th>
					<td>
						<input type="text" name="memberId" value="jimmer3" required/>
					</td>
				</tr>
				<tr>
					<th>서비스 코드 </th>
					<td>
						<input type="text" name="cid" value="nadaum2022" readonly/>
					</td>
				</tr>
				<tr>
					<th>상품명</th>
					<td>
						<input type="text" name="itemName" value="샤베트용냉동딸기" required/>
					</td>
				</tr>
				<tr>
					<th>상품 수량</th>
					<td>
						<input type="number" name="quantity" value="1" required />
					</td>
				</tr>
				<tr>
					<th>상품 총액</th>
					<td>
						<input type="number" name="totalAmount" value="13200" required/>
					</td>
				</tr>
				<tr>
					<th>결제카드사</th>
					<td>
						<input type="text" name="CARDS" value="SINHAN" required/>
					</td>
					<td>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					</td>
				</tr>		
				<tr>
					<td colspan="2">
						<input type="submit" value="등록" />
					</td>
				</tr>
			</table>
		</form>
		
		<hr />
		

</body>
</html>
