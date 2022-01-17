<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="내가 한 질문" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>

<!-- Modal -->
<div class="modal fade" id="myQuestions" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">내가 한 질문</h5>
			</div>
			<hr />
			<div class="modal-body myQ">
				<c:forEach items="${myHelpList}" var="help">
					<ul class="list-group list-group-flush">${help.title}</ul>
				</c:forEach>
				
			</div>
		</div>
	</div>
</div>
<script>
// modal on
$(() => {
	$(myQuestions)
	.modal()
	.on("hide.bs.modal", (e) => {
		location.href='${empty header.referer ? pageContext.request.contextPath : header.referer}';
	});
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>