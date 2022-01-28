<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<sec:authentication property="principal" var="loginMember"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.container{
padding-top: 100px;
}
</style>
<body>
<div class="container">
	<h1>댓글</h1>
		<div class="insert-comment">
			<form id="insertCommentFrm">
				<input type="hidden" name="apiCode" value="${apiCode}"/>
	            <input type="hidden" name="id" value="${loginMember.id}" />
	            <input type="hidden" name="commentLevel" value="1" />
	            <input type="hidden" name="commentRef" value="" />   
	            <input type="text" name="star" value="4" />
				<textarea name="content" cols="60" rows="3"></textarea>
	            <button type="submit" class="btn btn-light">등록</button>
			</form>
		</div>
		<form id="deleteCommentFrm">
		<table id="comment-table">
			 <c:forEach var="comment" items="${list}">
				<tr class="level1">
					<td>
						<input type="hidden" name="code" value="${comment.code}"></input>
						<sub class="comment-writer">${comment.id}</sub>
						<sub class="comment-date">
						<fmt:formatDate value="${comment.regDate}" pattern="yyyy/MM/dd"/>
						</sub>
						<sub class="star">${comment.star}</sub>
						<br />
						${comment.content}
						<br />
						<button type="submit" class="btn-delete" value="${comment.code}">삭제</button>
					</td>		
				</tr>
				</c:forEach>
				</table>
			</form>
		<script>
				//댓글 등록
				$(insertCommentFrm).submit((e) => {
					e.preventDefault();
					//csfr토큰 headers (post 전송시 필요)
				    
				    
					const obj = {
						id : $("[name=id]", e.target).val(),	
						apiCode: $("[name=apiCode]", e.target).val(),
						commentLevel : $("[name=commentLevel]", e.target).val(),	
						commentRef : $("[name=commentRef]", e.target).val(),	
						content : $("[name=content]", e.target).val(),	
						star : $("[name=star]", e.target).val(),	
					};
					
					console.log(obj); // javascript객체
					const jsonStr = JSON.stringify(obj);
					console.log(jsonStr); // json문자열
					
					const csrfHeader = "${_csrf.headerName}";
			        const csrfToken = "${_csrf.token}";
			        const headers = {};
			        headers[csrfHeader] = csrfToken;
				    
					$.ajax({
						headers : headers,
						url: `${pageContext.request.contextPath}/culture/comment/${apiCode}`,
						method: "POST",
						data: jsonStr,
						contentType: "application/json; charset=utf-8",
						success(resp){
							console.log(resp)
							location.reload();
							alert(resp.msg);
						},
						error: console.log
					});
					
				});
				
				//댓글 삭제
				$(".btn-delete").click((e) => {
					
					
				});
				$(deleteCommentFrm).submit((e) => {
					e.preventDefault();
					const code = $(e.target).find("[name=code]").val();
					console.log(code);
					
					$.ajax({
						url:`${pageContext.request.contextPath}/culture/comment/\${code}`,
						method: "DELETE",
						success(resp){
							console.log(resp);
							alert(resp.msp);
						},
						error(xhr,statusText){
							switch(xhr.status){
							case 404: alert("해당 댓글이 존재하지않습니다."); break;
							default: console.log(xhr, statusText,err);
							}				
						}
					});
				});
				</script>

</div>
	
</body>
</html>