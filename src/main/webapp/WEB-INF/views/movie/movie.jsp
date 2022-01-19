<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="영화" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movie/movieList.css" />
<style>
.search-form label{
padding-right: 8px;
}
div#culture-container{width:60%; margin:0 auto;text-align:center;}
.thumnail{width: 30%; }
#movie_code{
	display:none;
}
</style>
<script>

</script>
<div id="movie-container">
    <br />
	<table class="table">
	    <tr>
	      <th>번호</th>
	      <th>제목</th>
	      <th>제작년도</th>
	      <th>감독</th>
	      <th>배우</th>
	      <th>평점</th>
	      <th>이미지</th>
	    </tr>
	    <c:forEach items="${list}" var="movie">
	    	<tr>
	    		<td>${movie.code}</td>
	    		<td>${movie.title}</td>
	    		<td><fmt:formatDate value="${movie.pubDate}" pattern="yyyy/MM/dd"/></td>
	    		<td>${movie.director}</td>
	    		<td>${movie.actor}</td>
	    		<td>${movie.userRating}</td>
	    		<td><img class="thumnail" src="${movie.imgUrl}" alt="" /></td>
	    		
	    </c:forEach>
	</table>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
