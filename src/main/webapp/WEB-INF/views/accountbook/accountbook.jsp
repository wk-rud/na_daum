<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="가계부" name="title"/>
</jsp:include>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<sec:authentication property="principal" var="loginMember"/>
<link href='${pageContext.request.contextPath}/resources/css/accountbook/main2.css' rel='stylesheet' />
<link href='https://use.fontawesome.com/releases/v5.0.6/css/all.css' rel='stylesheet'>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<%
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("M월");
	String today = sdf.format(date);
%>

<div class="accountWrapper">
<!-- 가계부 입력 모달창 -->
	<div class="modal-background">
	<div class="insertAccountModal">
		<input type="hidden" name="incomeExpense" id="income" value="I" />
		<input type="hidden" name="incomeExpense" id="expense" value="E" /> 
		<form 
			name="insertFrm" 
			method="POST"
			action="${pageContext.request.contextPath}/accountbook/accountInsert.do">
		<table class="insertAccountTable">
			<thead>
			<tr>
				<th colspan="4">새로운 거래</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td colspan="2" rowspan="2">
					<input type="date" name="regDate" id="regDate" />
				</td>
				<td>
					<input class="checkbox-tools" type="radio" name="payment" id="cash" value ="cash"/>
					<label class="for-checkbox-tools" for="cash">
						<span><i class="far fa-money-bill-alt"></i></span>
					</label>
				</td>
				<td>
					<input class="checkbox-tools" type="radio" name="payment" id="card" value ="card"/>
					<label class="for-checkbox-tools" for="card">
						<span><i class="far fa-credit-card" id="card"></i></span>
					</label>
				</td>
			</tr>
			<tr>
				<td>
					<select name="incomeExpense" id="main">
						<option value="I">수입</option>
						<option value="E">지출</option>
					</select>
				</td>
				<td>
					<select name="category" id="sub">
						<option value="급여">급여</option>
						<option value="용돈">용돈</option>
						<option value="기타">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<label for="detail">
						<input type="text" name="detail" id="" placeholder="내역을 입력하세요" />
					</label>
				</td>
			</tr>
			<tr>
				<td colspan="4">
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
			</tbody>
		</table>
			<input type="submit" class="defaultBtn addAccountBtn" value="등록" />
		</form>
			<button id="modalCloseBtn"><i class="fas fa-sign-in-alt"></i></button>
	</div>
	</div>

<input type="hidden" name="incomeExpense" id="income" value="I" />
<input type="hidden" name="incomeExpense" id="expense" value="E" /> 
<!-- 차트 부분 -->
<section class="chartSection">
	<a href="${pageContext.request.contextPath}/accountbook/detailChart.do" id="detailChartLink">더 보기</a>
	<div id="incomeChart"></div>
	<div id="expenseChart"></div>
</section>
<section class="search_list_section">
		<!-- 검색창 -->
		<div class="search_box">
			<form 
				action="${pageContext.request.contextPath}/accountbook/searchList.do"
				method="GET"
				name = "searchFrm"
				id="searchFrm">
				<select name="incomeExpense" id="mainCategory">
					<option value="" selected>대분류</option>
					<option value="I">수입</option>
					<option value="E">지출</option>
				</select>
				<select name="category" id="subCategory">
					<option value="">소분류</option>
				</select>
				<input type="text" name="detail" id="search"/>
				<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
 				<button id="searchBtn" class="defaultBtn"><i class="fas fa-search"></i></button>
			</form>
		</div>
		<!-- 필터링 -->
		<div class="fillterSection">
			<button id="AllListBtn" class="defaultBtn" onclick="location href=' ${pageContext.request.contextPath}/accountbook/selectAllAccountList.do'">전체보기</button>
			<button class="FilterBtn defaultBtn" id="incomeFilterBtn">수입</button>
			<button class="FilterBtn defaultBtn" id="expenseFilterBtn">지출</button>
			<a href="${pageContext.request.contextPath}/accountbook/excel">엑셀 다운로드</a>
		</div>
		<!-- 가계부 리스트 -->
		<div id="account_list">
			<c:forEach items="${accountList}" var = "account">
				<div class="accountListDiv">
				<table class="accountTable">
					<tr class="account_side_column">
						<td><span class="accountRegDate"><fmt:formatDate value="${account.regDate}" pattern="yyyy/MM/dd"/></span></td>
						<td rowspan="2" class="accountPrice">
							<c:choose>
								<c:when test="${accountList eq null}">
									
								</c:when>
								<c:when test="${account.incomeExpense eq 'I' }">
									<span class="income">+ <fmt:formatNumber value="${account.price}" type="number"/></span>
								</c:when>
								<c:when test="${account.incomeExpense eq 'E' }">
									<span class="expense">- <fmt:formatNumber value="-${account.price}" type="number"/></span>
								</c:when>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td class="accountDetail">${account.detail}</td>
					</tr>
					</table>
				</div>
				<div class="accountUpdate">
					<button class="deleteBtn" onclick="deleteDetail('${account.code}')">삭제</button>
				</div>
			</c:forEach>
			<div class="accountPage">${pagebar}</div>
		</div>
	</section>
	<!-- 사용자별 가계부 월별 금액 -->
	<section class="infoSection">
		<div class="account">
			<table class="account-info">
				<tr>
					<td colspan="2">${loginMember.name}님의</td>
				</tr>
				<tr>
					<td colspan="2"><%= today %> 총 자산</td>
				</tr>
				<tr id="total_income">
					<td colspan="2" style="font-size:40px"><fmt:formatNumber value="${monthlyAccount}" type="number"/>원</td>
				</tr>
				<tr>
					<td>수입</td>
					<td>지출</td>
				</tr>
				<tr class="user_income_expense">
					<td>
						<span class="income"><fmt:formatNumber value="${incomeExpenseList.income}" type="number"/></span>
					</td>
					<td>
						<span class="expense"><fmt:formatNumber value="${incomeExpenseList.expense}" type="number"/></span>
					</td>
				</tr>
			</table>
		</div>
		<div class="insertForm">
			<button id="insertBtn"><i class="fas fa-plus plus"></i><br />거래내역 입력하기</button>
		</div>
	</section>
</div>

<input type="hidden" id="chartData" value="${chartData}" />
<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" />
<script src='${pageContext.request.contextPath}/resources/js/accountbook/main.js'></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />