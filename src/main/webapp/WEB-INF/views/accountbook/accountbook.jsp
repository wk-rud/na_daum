<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="가계부" name="title"/>
</jsp:include>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<sec:authentication property="principal" var="loginMember"/>

<link href='${pageContext.request.contextPath}/resources/css/accountbook/main.css' rel='stylesheet' />
<link href='https://use.fontawesome.com/releases/v5.0.6/css/all.css' rel='stylesheet'>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>

	<div class="modal-background">
	<div class="insertAccountModal">
		<h2>가계부 입력</h2>
		<input type="hidden" name="income_expense" id="income" value="I" />
		<input type="hidden" name="income_expense" id="expense" value="E" /> 
		<form 
			name="insertFrm" 
			method="POST"
			action="${pageContext.request.contextPath}/accountbook/accountInsert.do">
		<table>
			<tr>
				<td colspan="2">
					<input type="date" name="reg_date" id="regDate" />
				</td>
			</tr>
			<tr>
				<td>
					<label for="payment">
						<input type="radio" name="payment" id="" value ="cash"/> 현금
					</label>
				</td>
				<td>
					<label for="payment">
						<input type="radio" name="payment" id="" value ="card"/> 카드
					</label>
				</td>
			</tr>
			<tr>
				<td>
					<select name="income_expense" id="main">
						<option value="I">수입</option>
						<option value="E">지출</option>
					</select>
					<select name="category" id="sub">
						<option value="급여">급여</option>
						<option value="용돈">용돈</option>
						<option value="기타">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<label for="detail">
						<input type="text" name="detail" id="" placeholder="내역을 입력하세요" />
					</label>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<label for="price">
						<input type="text" name="price" id="insertPrice" placeholder="금액을 입력하세요" onkeyup="numberWithCommas(this.value)" />
					</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="hidden" name="id" id="id" value="${loginMember.id}" />
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</td>
			</tr>
		</table>
			<input type="submit" value="등록" />
		</form>
			<button id="modalCloseBtn">X</button>
	</div>
	</div>

	<section class="box1">
		<div id="incomeChart"></div>
		<div id="expenseChart"></div>

	</section>
	<section class="box2">
		<div class="search_box">
			<form 
				action="${pageContext.request.contextPath}/accountbook/searchList.do"
				method="POST"
				name = "searchFrm"
				id="searchFrm">
				<h3>검색</h3>
				<select name="income_expense" id="mainCategory">
					<option value="" selected>대분류</option>
					<option value="I">수입</option>
					<option value="E">지출</option>
				</select>
				<select name="category" id="subCategory">
					<option value="">소분류</option>
				</select>
				<input type="text" name="detail" id="search"/>
				<input type="hidden" name="id" value="${loginMember.id}" />
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="button" id="searchBtn" value="검색">
			</form>
		</div>
		<button id="AllListBtn" onclick="AllList();">전체보기</button>
		<button class="FilterBtn" id="incomeFilterBtn">수입</button>
		<button class="FilterBtn" id="expenseFilterBtn">지출</button>
		<div id="account_list">
		</div>
	</section>
	<section class="box3">
		<div class="account">
			<table class="account-info">
				<tr>
					<td colspan="2">${loginMember.name}님의</td>
				</tr>
				<tr>
					<td colspan="2">1월 총 자산</td>
				</tr>
				<tr id="total_income">
				</tr>
				<tr>
					<td>수입</td>
					<td>지출</td>
				</tr>
				<tr class="user_income_expense">
				</tr>
			</table>
		</div>
		<div class="insertForm">
			<button id="btn1"><i class="fas fa-plus plus"></i><br />거래내역 입력하기</button>
		</div>
	</section>
<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" />
<script src='${pageContext.request.contextPath}/resources/js/accountbook/main.js'></script>
<script>

</script>
<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp" /> --%>