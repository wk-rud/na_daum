<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="가계부리스트" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>

<h1>test</h1>
<div id="account_list">
		<c:forEach items="${accountList}" var="account">
			<form 
				action="${pageContext.request.contextPath}/accountbook/accountDelete.do"
				method="POST"
				name="deleteFrm">
				<hr>
				<table id="account_list_table">
					<tr>
						<td rowspan="2">${account.incomeExpense}</td>
						<td colspan="2"><fmt:formatDate pattern="yyyy-MM-dd" value="${account.regDate}"/></td>
						<td>${account.price}</td>
					</tr>		
					<tr id="testTd">
					<tr>
						<td>${account.detail}</td>
						<td><button id="deleteBtn">삭제하기</button></td>				
				</table>
						<input type="hidden" name="id" value="${loginMember.id}" />
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						<input type="hidden" name="code" value="${account.code}" />
			</form>
		</c:forEach>
	</div>

</body>
</html>