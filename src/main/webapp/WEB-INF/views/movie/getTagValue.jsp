<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="com.project.nadaum.culture.movie.controller.GetMovieApi"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/movie/movieList.css" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	
<table>
	<thead>
	
		<tr>
			<th>코드 : </th>
			<th>영화이름 : </th>
			<th>제작년도 : </th>
			<th>개봉일 : </th>
			<th>영화유형 : </th>
			<th>제작국가 : </th>
			<th>장르 : </th>
			<th>영화감독 : </th>
		</tr>
	
	</thead>

	<tbody>
	 <c:forEach items="${list}" var="list">
		<tr>
			<th>${list.movieCd}</th>
			<th>${list.movieNm}</th>
			<th>${list.prdYear}</th>
			<th>${list.openDt}</th>
			<th>${list.typeNm}</th>
			<th>${list.nationAlt}</th>
			<th>${list.genreAlt}</th>
			<th>${list.peopleNm}</th>
		</tr>
	</c:forEach>
	</tbody>
	
</table>

</div>
</body>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
<script	src="https://pingendo.com/assets/bootstrap/bootstrap-4.0.0-alpha.6.min.js"></script>
</html>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>