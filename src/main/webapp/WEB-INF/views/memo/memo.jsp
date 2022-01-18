<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="문화" name="title"/>
</jsp:include>

<style>
div#memo-container{width:60%; margin:0 auto;text-align:center;}
</style>
<div id="memo-container">
    <br />
	<table class="table">
	    <tr>
	      <th>번호</th>
	      <th>제목</th>
	      <th>시작일</th>
	      <th>종료일</th>
	    </tr>
	    <c:forEach items="${list}" var="memo">
	    	<tr>
	    		<td>${culture.code}</td>
	    		<td>${culture.title}</td>
	    		<td><fmt:formatDate value="${culture.start_date}" pattern="yyyy/MM/dd"/></td>
	    		<td><fmt:formatDate value="${culture.end_date}" pattern="yyyy/MM/dd"/></td>	</tr>
	    </c:forEach>
	</table>
</div>
<!-- Modal -->
<div class="modal fade" id="deleteMemoModal" tabindex="-1" role="dialog" aria-labelledby="deleteMemoModalTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
	<div class="modal-content">
		<div class="modal-header">
		  <h5 class="modal-title" id="deleteMemoModalTitle">비밀번호를 입력하세요.</h5>
		  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		  </button>
		</div>
		<form name="memoDelFrm" action="deleteMemo.do" method="post">
		   <div class="modal-body">
			 <input type="hidden" name="no" />
			 <input 
				type="password" 
				class="form-control" 
				name="password"
				placeholder="비밀번호" 
				required>
		   </div>
		   <div class="modal-footer">
			 <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			 <button type="submit" class="btn btn-danger">삭제</button>
		   </div>
		</form>
	</div>
  </div>
</div>
<script>
$(".btn-memo-delete").click((e) => {
		const no = $(e.target).data("no");
		$(deleteMemoModal)
			.modal()
			.find("[name=memoDelFrm] [name=no]")
			.val(no);
});
</script>





<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
