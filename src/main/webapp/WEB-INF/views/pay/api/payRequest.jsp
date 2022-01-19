<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>payment진행</title>
<script src="<%=request.getContextPath()%>/resources/js/jquery-3.6.0.js"></script>
<style>
div.enroll-container {
	text-align: center;
}

table#tbl-student {
	margin: 0 auto;
	border: 1px solid;
	border-collapse: collapse;
}

table#tbl-student th, table#tbl-student td {
	border: 1px solid;
	padding: 5px;
}

table#tbl-student th {
	text-align: right;
}

table#tbl-student td {
	text-align: left;
}

table#tbl-student tr:last-of-type td {
	text-align: center;
}
</style>
<c:if test="${not empty msg}">
	<script>
	alert("${msg}");
</script>
	<c:remove var="msg" scope="session" />
</c:if>
</head>
<body>
	
		<h2>Pay Request(VO)</h2>
		<form name="payRequestFrm" method="post"
			action="${pageContext.request.contextPath}/payRequest/api/payRequest">
			<table id="tbl-student">
				<tr>
					<th></th>
					<td><input type="hidden" name="orderCode"
						value="${payReady.orderCode}" readonly /></td>
				</tr>
				<tr>
					<th></th>
					<td><input type="hidden" name="memberId"
						value="${payReady.memberId}" readonly /></td>
				</tr>
				<tr>
					<th></th>
					<td><input type="hidden" name="cid" value="${payReady.cid}"
						readonly /></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td><input type="text" name="itemName"
						value="${payReady.itemName}" readonly /></td>
				</tr>
				<tr>
					<th>상품 수량</th>
					<td><input type="number" name="quantity"
						value="${payReady.quantity}" readonly /></td>
				</tr>
				<tr>
					<th>상품 총액</th>
					<td><input type="number" name="totalAmount"
						value="${payReady.totalAmount}" readonly /></td>
				</tr>
				<tr>
					<th>결제카드사</th>
					<td><input type="text" name="CARDS" value="${payReady.CARDS}"
						readonly /></td>
				</tr>
				<tr>
					<th>결제 비밀번호입력</th>
					<td><input type="text" name="payPw" value="" required /></td>
				</tr>
				<tr>
					<th>결제고유번호</th>
					<td><input type="text" name="tid" value="${payAuth.tid}"
						readonly /></td>
				</tr>
				<tr>
					<th>결제고유토큰</th>
					<td><input type="text" name="pgToken"
						value="${payAuth.pgToken}" readonly /></td>
				</tr>
				<tr>
					<th></th>
					<td><input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" readonly /></td>
				</tr>
				<tr>
				 	<td></td>
					 <td >
						<input type="submit" value="결제" />
						<button type="button" value="취소" data-dismiss="modal">닫기</button>
					</td> 
				</tr>
			</table>
			<!-- <div class="d-grid gap-2 d-md-flex justify-content-md-end">
				<button class="btn btn-primary me-md-2" type="button">결제</button>
				<button class="btn btn-primary" type="button">취소</button>
			</div> -->
		</form>


</body>
</html>
