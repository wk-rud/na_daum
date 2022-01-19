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
<sec:authentication property="principal" var="loginMember"/>

<link href='${pageContext.request.contextPath}/resources/css/accountbook/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/resources/js/accountbook/main.js'></script>
<link href='https://use.fontawesome.com/releases/v5.0.6/css/all.css' rel='stylesheet'>

	<div class="insertAccount box">
		<h2>가계부 테스트</h2>
		<form action="">
			<input type="date" name="reg_date" id="reg_date" value="" />
			<label for="reg_date">날짜</label>
			<input type="checkbox" name="income_expense" id="income_checkbox" value="I" />
			<label for="income_checkbox">수입</label>
			<input type="checkbox" name="income_expense" id="income_checkbox" value="E"/>
			<label for="income_checkbox">지출</label>
			<br />
			<label for="detail">내역</label>
			<input type="text" name="detail" id="detail" placeholder="내역을 입력하세요." />
			<br />
			<label for="price">가격</label>
			<input type="text" name="price" id="price" placeholder="가격을 입력하세요." />
			<select name="payment" id="payment">
				<option value="cash" name="payment">현금</option>
				<option value="card" name="payment">카드</option>
			</select>
			<input type="submit" value="제출하기" />
			<input type="hidden" name="Id" value="${loginMember.id}" />
		</form>
	</div>

	<section class="box1">
		<div class="account_tip">
			<h3>1월의 소비 목표 : 500,000</h3>
			<p>목표로 설정한 소비 금액 진행률에 따른 멘트 변화
			<br>예시 : 건강한 소비 패턴을 지니고 계시군요! 이대로 목표 달성까지!
			<br>목표로 설정한 금액의 50%를 소비하셨어요! 성공을 위해서 남은 기간 절대 존버해
			<br>아무튼... 이런 랜덤 멘트...
		</div>
		<div class="chart box">
		</div>
	</section>
	<section class="box2">
		<div class="search_box">
			<form action="">
				<h3>검색</h3>
				<select name="mainCategory" id="mainCategory">
					<option value="">대분류</option>
				</select>
				<select name="subCategory" id="subCategory">
					<option value="">소분류</option>
				</select>
				<input type="text" name="search" id="search">
				<input type="submit" value="검색">
			</form>
		</div>
		<!-- 화면만 잡고 리스트 싹 불러오기 -->
		<div class="account_list">
			<table class="account_list_table">
			<hr>
				<tr>
					<td rowspan="2">용돈</td>
					<td colspan="2">2022-01-17</td>
					<td rowspan="2" class="income">+18,000</td>
				</tr>
				<tr>
					<td>용돈 받았음</td>
				</tr>
			</table>
			<hr>
			<table class="account_list_table">
				<tr>
					<td rowspan="2">식비</td>
					<td colspan="2">2022-01-15</td>
					<td rowspan="2" class="expense">-20,000</td>
				</tr>
				<tr>
					<td>배달 음식</td>
				</tr>
			</table>
			<hr>
			<table class="account_list_table">
				<tr>
					<td rowspan="2">생활비</td>
					<td colspan="2">2022-01-13</td>
					<td rowspan="2" class="expense">-66,000</td>
				</tr>
				<tr>
					<td>교통비</td>
				</tr>
			</table>
			<hr>
			<table class="account_list_table">
				<tr>
					<td rowspan="2">급여</td>
					<td colspan="2">2022-01-10</td>
					<td rowspan="2" class="income">+3,000,000</td>
				</tr>
				<tr>
					<td>월급</td>
				</tr>
			</table>
			<hr>
			<table class="account_list_table">
				<tr>
					<td rowspan="2">쇼핑</td>
					<td colspan="2">2022-01-04</td>
					<td rowspan="2" class="expense">-99,000</td>
				</tr>
				<tr>
					<td>신발</td>
				</tr>
			</table>
			<hr>
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
				<tr>
					<td colspan="2">2,833,000원</td>
				</tr>
				<tr>
					<td>수입</td>
					<td>지출</td>
				</tr>
				<tr>
					<td><span class="income">3,018,000</span>원</td>
					<td><span class="expense">185,000</span>원</td>
				</tr>
			</table>
		</div>
		<div class="insertForm">
			<button id="btn1"><i class="fas fa-plus plus"></i><br />거래내역 입력하기</button>
		</div>
	</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />