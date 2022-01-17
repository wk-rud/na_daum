<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공지사항" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<div class="announcement-wrap">
	<div class="announcement-header">
		<span>공지사항</span>	
		<sec:authorize access="hasRole('ADMIN')">
			<button type="button" id="announce-write" class="btn btn-light">공지작성</button>
		</sec:authorize>
	</div>
	<div class="announcement-body">
		<div class="list-group">
			<table>
				<thead>
					<tr>
						<th colspan="5">제목</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="5">
							<a href="${pageContext.request.contextPath}/member/announcementMain.do" class="list-group-item list-group-item-action">
				  				${announce.title}
				  			</a>
						</td>
						<td><fmt:formatDate value="${announce.regDate}" pattern="yy/MM/dd"/></td>
					</tr>		
				</tbody>
			</table>
			<c:forEach items="${announceList}" var="announce">
	  			<a href="${pageContext.request.contextPath}/member/announcementMain.do" class="list-group-item list-group-item-action">
	  				${announce.title}
	  			</a>
			</c:forEach>
  		</div>
  		<div class="list-controller">
  			${pagebar}
  		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>