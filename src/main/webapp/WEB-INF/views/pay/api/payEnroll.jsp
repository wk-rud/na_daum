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
					<th>가맹점 코드, 최대11자</th>
					<td>
						<input type="text" name="cid" value="#0221232222" required/>
					</td>
				</tr>
				<tr>
					<th>가맹점 주문번호</th>
					<td>
						<input type="text" name="partnerOrderId" value="1023124" required/>
					</td>
				</tr>
				<tr>
					<th>가맹점 회원 id</th>
					<td>
						<input type="text" name="partnerUserId" value="crunching" required/>
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
				</tr>		
				<tr>
					<td colspan="2">
						<input type="submit" value="등록" />
					</td>
				</tr>
			</table>
		</form>
		
		<hr />
		
		<h2>단건결제준비(Map)</h2>
		<form method="post" action="${pageContext.request.contextPath}/payready/payMapEnroll">
			<table id="tbl-student">
				<tr>
					<th>가맹점 코드, 최대11자</th>
					<td>
						<input type="text" name="cid" value="#0221232222" required/>
					</td>
				</tr>
				<tr>
					<th>가맹점 주문번호</th>
					<td>
						<input type="text" name="partner_order_id" value="1023124" required/>
					</td>
				</tr>
				<tr>
					<th>가맹점 회원 id</th>
					<td>
						<input type="text" name="partner_user_id" value="crunching" required/>
					</td>
				</tr>
				<tr>
					<th>상품명</th>
					<td>
						<input type="text" name="item_name" value="샤베트용냉동딸기" required/>
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
						<input type="number" name="total_amount" value="13200" required/>
					</td>
				</tr>
					
				<tr>
					<td colspan="2">
						<input type="submit" value="등록" />
					</td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>
