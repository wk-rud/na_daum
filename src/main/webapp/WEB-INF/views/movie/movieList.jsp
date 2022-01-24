<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="com.project.nadaum.culture.movie.controller.GetMovieApi"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movie/movieList.css" />
 --%>
<body>
	<style>
#container {
	padding: 0;
}

.container {
	padding: 0;
}

section {
	background-color: #FFFBF5;
}

body {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100vh;
	background-color: #EEEEEE;
}

/* 썸네일 이미지 설정*/
.movie-thumnail {
	position: relative;
	padding: 0;
}

.movie-thumnail img {
	height: 450px;
	width: 100%;
	opacity: 0.75;
}

.title {
	position: absolute;
	top: 30%;
	left: 60%;
}
/*검색 폼 */
.search-form {
	/* position: absolute; */
	position: relative;
	background: #F2F2F2;
	left: 30%;
	bottom: -10%;
	padding: 15px;
	border-radius: 10px;
	box-shadow: 5px 5px 10px grey;
	margin-bottom: 20px;
	width: 50%
}

/* 오렌지색 버튼*/
.btn {
	border-radius: 10px;
	text-decoration: none;
	color: #fff;
	position: relative;
	display: inline-block;
}

.btn:active {
	transform: translate(0px, 5px);
	-webkit-transform: translate(0px, 5px);
	box-shadow: 0px 1px 0px 0px;
}

.orange {
	background-color: #F6953C;
	box-shadow: 0px 4px 0px 0px #CD6509;
}

.orange:hover {
	background-color: #FF983C;
}
</style>
	<div class="movie-container">

		<!-- 썸네일 그림, 타이틀  -->
		<div class="culture-thumnail"></div>


		<!-- 검색창 -->
		<form class="form-inline search-form">
			<div class="form-group">
				<label for="Date" class="control-label">검색</label> <input
					type="text" class="form-control" id="keyword"
					placeholder="검색어를 입력하세요.">
			</div>
			<button type="submit" class="btn orange btn-default" id="search-btn">검색</button>
		</form>
	</div>


	<!-- 영화정보진흥원 api -->
	<div id="movie-container">
		<div class="py-5">
			<div class="container">
				<div class="row hidden-md-up">

					<c:forEach var="movie" items="${list}">
						<form action="${pageContext.request.contextPath}/movieDetail?movieCd={movieCode}" method="get" id="movieFrm"> 
							<div class="col-md-4">
								
									<div class="card-block">
										<h4 class="card-title">${movie.movieCd}</h4>
										<p class="card-text p-y-1">${movie.movieNm}</p>
										<h6 class="card-subtitle text-muted">${movie.prdtYear}</h6>
										<p class="card-text p-y-1">${movie.typeNm}</p>
										<p class="card-text p-y-1">${movie.nationAlt}</p>
										<p class="card-trfext p-y-1">${movie.genreAlt}</p>
										<p class="card-trfext p-y-1">${movie.peopleNm}</p>
										<h6 class="card-subtitle text-muted" />
										<a href="#" class="card-link"><input type="hidden"
											name="movieCd" value="${movie.movieCd}" />Second link</a> <a
											href="#" class="card-link"> <img class="thumnail"
											src="${movie.imgUrl}" alt="영화사진" />
										</a>
										<button type="submit" class="btn btn-sm btn-outline-secondary"
											id="goDetail" name="">+More</button>
										<input type="hidden" id="moviecd" value="${movie.movieCd}"/>
									</div>
								
							</div>
						</form>
					</c:forEach>

				</div>

			</div>
		</div>
	</div>


	

	<!-- themovie fav movie -->
	<h1 class="title">Movies</h1>
	<ul id="top_rated">
	</ul>

</body>
<script>
/* the movie api 에서 top_rated  불러오기*/


/* 페이지 로딩 될때 영화 */

 
 /*  버튼 누를 시 영화 상세보기로 이동 */
 /* $("#goDetail").click((e) => {
	 const movieCode = $("#moviecd").val();
	console.log(movieCode);
	
 }); */
 
 	
 
 	
</script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
<script
	src="https://pingendo.com/assets/bootstrap/bootstrap-4.0.0-alpha.6.min.js"></script>
</html>