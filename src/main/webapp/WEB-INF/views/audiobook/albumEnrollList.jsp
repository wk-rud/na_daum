<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/audiobook/common/audioBookHeader.jsp">
	<jsp:param value="게시판" name="title"/>
</jsp:include>
<style>
/*글쓰기버튼*/
input#btn-add{float:right; margin: 0 0 15px;}
tr[data-no] {cursor: pointer;}
</style>
<script>
function goAlbumForm(){
	location.href = "${pageContext.request.contextPath}/audiobook/albumForm";
}

$(() => {
	$("tr[data-no]").click((e) => {
		// console.log(e.target); // td
		const $tr = $(e.target).parent();
		const code = $tr.data("code");
		location.href = `${pageContext.request.contextPath}/audiobook/albumDetail?code=\${code}`;
	});
});
</script>
<section id="board-container" class="container">
	<input 
		type="button" value="앨범등록하기" id="btn-add" class="btn btn-outline-success" 
		onclick="goAlbumForm();"/>
	<table id="tbl-board" class="table table-striped table-hover">
		<tr>
			<th>코드</th>
			<th>제목</th>
			<th>창작자</th>
			<th>작성일</th>
			<th>첨부파일</th> <!-- 첨부파일 있을 경우, /resources/images/file.png 표시 width: 16px-->
			<th>제작사</th>
			<th>플레이타임</th>
			<th>장르</th>
		</tr>
		<c:forEach items="${list}" var="album">
			<tr data-no="${album.no}">
				<td>${album.code}</td>
				<td>${album.title}</td>
				<td>${album.creator}</td>
				<td><fmt:formatDate value="${album.regDate}" pattern="yy/MM/dd HH:mm"/> </td>
				<td>
					<c:if test ="${album.attachCount} gt 0">
						<img src="${pageContext.request.contextPath}/resources/images/audiobook/file.png" style="width:16px;" />
					</c:if>
				</td>
				<td>
					<c:if test="${not empty album.provider}">
						${album.provider}
					</c:if>
				</td>
				<td>${album.playTime}</td>
				<td>${album.kind}</td>
			</tr>
		</c:forEach>
	</table>
	${pagebar}
</section> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
