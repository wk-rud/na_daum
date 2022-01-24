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
		<div class="culture-thumnail">
			<div id="myCarousel" class="carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel" data-slide-to="1"></li>
					<li data-target="#myCarousel" data-slide-to="2"></li>
				</ol>
				<div class="carousel-inner">
					<div class="carousel-item active">
						<svg class="bd-placeholder-img" width="100%" height="100%"
							xmlns="http://www.w3.org/2000/svg"
							preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
							<rect width="100%" height="100%" fill="#777" /></svg>
						<div class="container">
							<div class="carousel-caption text-left">
								<h1>Example headline.</h1>
								<p>Cras justo odio,</p>
								<p>
									<a class="btn btn-lg btn-primary" href="#" role="button">Sign
										up today</a>
								</p>
							</div>
						</div>
					</div>
					<div class="carousel-item">
						<svg class="bd-placeholder-img" width="100%" height="100%"
							xmlns="http://www.w3.org/2000/svg"
							preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
							<rect width="100%" height="100%" fill="#777" /></svg>
						<div class="container">
							<div class="carousel-caption">
								<h1>Another example headline.</h1>
								<p>Cras justo odio,</p>
								<p>
									<a class="btn btn-lg btn-primary" href="#" role="button">Learn
										more</a>
								</p>
							</div>
						</div>
					</div>
					<div class="carousel-item">
						<svg class="bd-placeholder-img" width="100%" height="100%"
							xmlns="http://www.w3.org/2000/svg"
							preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
							<rect width="100%" height="100%" fill="#777" /></svg>
						<div class="container">
							<div class="carousel-caption text-right">
								<h1>One more for good measure.</h1>
								<p>Cras justo odio, dapibus ac facilisis in,</p>
								<p>
									<a class="btn btn-lg btn-primary" href="#" role="button">Browse
										gallery</a>
								</p>
							</div>
						</div>
					</div>
				</div>
				<a class="carousel-control-prev" href="#myCarousel" role="button"
					data-slide="prev"> <span class="carousel-control-prev-icon"
					aria-hidden="true"></span> <span class="sr-only">Previous</span>
				</a> <a class="carousel-control-next" href="#myCarousel" role="button"
					data-slide="next"> <span class="carousel-control-next-icon"
					aria-hidden="true"></span> <span class="sr-only">Next</span>
				</a>
			</div>


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
							<div class="col-md-4">
								<div class="movieCode" data-code="${movie.movieCd}" name = "${movieCd}">
									<div class="card-block">

										<h4 class="card-title" >${movie.movieCd}</h4>
										<p class="card-text p-y-1">${movie.movieNm}</p>
										<h6 class="card-subtitle text-muted">${movie.prdYear}</h6>
										<p class="card-text p-y-1">${movie.typeNm}</p>
										<p class="card-text p-y-1">${movie.nationAlt}</p>
										<p class="card-trfext p-y-1">${movie.genreAlt}</p>
										<p class="card-trfext p-y-1">${movie.peopleNm}</p>
										<h6 class="card-subtitle text-muted" />
										<a href="#" class="card-link">Second link</a> <a href="#"
											class="card-link"> <img class="thumnail"
											src="${movie.imgUrl}" alt="영화사진" />
										</a> <input type="text" class="form-control-" placeholder="시작 날짜"
											name="startDate" id="startDate"
											value='<fmt:parseDate value="${movie.pubDate}" var="endDateParse" pattern="yyyyMMdd"/>
           									<fmt:formatDate value="${pubDateParse}" pattern="yyyy년 MM월 dd일"/>'
											readonly>
										</h6>
									</div>
								</div>
							</div>
						</c:forEach>

					</div>

				</div>
			</div>
		</div>

		<!-- 영화정보진흥원 api 다른카드 -->
		<div id="movie-container">
			<div class="py-5">
				<div class="container">
					<div class="row hidden-md-up">
						<!-- api 꺼내기 위한 반복문 시작 -->
						<c:forEach var="movie" items="${list}">
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<svg class="bd-placeholder-img card-img-top" width="100%"
										height="225" xmlns="http://www.w3.org/2000/svg"
										preserveAspectRatio="xMidYMid slice" focusable="false"
										role="img" aria-label="Placeholder: Thumbnail">
            	<title>Placeholder</title><rect width="100%" height="100%"	fill="#55595c" />
            	<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text>
           		 </svg>		
            	<input type="hidden" name="movieCode" value="{}"/>
									<div class="card-body">
										<p class="card-text">${movie.movieCd}</p>
										<p class="card-text">${movie.movieNm}</p>
										<p class="card-text">${movie.prdYear}</p>
										<p class="card-text">${movie.typeNm}</p>
										<%-- <p class="card-text">${movie.genreAlt}</p> --%>
										<p class="card-text">${movie.peopleNm}</p>
										<p class="card-text"></p>
										<div class="d-flex justify-content-between align-items-center">
											<small class="text-muted">${movie.nationAlt}</small>
											<div class="btn-group">
												<button type="button"
													class="btn btn-sm btn-outline-secondary" id="goDetail">+More</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>

				</div>
			</div>
		</div>


		<!-- api 꺼내기 위한 반복문 시작 ajax로 -->
		<c:forEach var="movie" items="${list}">
			<div class="col-md-4">
				<div class="card mb-4 shadow-sm">
					<svg class="bd-placeholder-img card-img-top" width="100%"
						height="225" xmlns="http://www.w3.org/2000/svg"
						preserveAspectRatio="xMidYMid slice" focusable="false" role="img"
						aria-label="Placeholder: Thumbnail">
            	<title>Placeholder</title><rect width="100%" height="100%"
							fill="#55595c" />
            	<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text>
            </svg>
					<div class="card-body">
						<thead>
							<tr>
								<th class="card-text">순위</th>
								<th class="card-text">영화제목</th>
								<th class="card-text">누적관객수(만)</th>
							</tr>
						</thead>
						<tbody></tbody>
						<div class="d-flex justify-content-between align-items-center">
							<small class="text-muted">${movie.nationAlt}</small>
							<div class="btn-group">
								<button type="button" class="btn btn-sm btn-outline-secondary"
									id="goDetail">+More</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>


		<!-- themovie fav movie -->
		<h1 class="title">Movies</h1>
		<ul id="top_rated">
		</ul>
		
</body>
<script>
/* the movie api 에서 top_rated  불러오기*/


/* 페이지 로딩 될때 영화 */

 
 /*  버튼 누를 시 영화 상세보기로 이동 */
 
 $(.movieCode).click((e) => {
	 
	 const movieCd = $("[name=movieCode]").val(),
	 console.log(movieCode);
	 /* location.href = `{pageContext.request.contextPath}/movie/movieDetail.do?movieCd=/${movieCode}`; */
	 
	$ajax ({
		url:"{pageContext.request.contextPath}/movie/movieDetail.do?movieCd=/${movieCode}",
		method:"get",
		data : 
		
	}) 
 });
 	
 	
 	
 	$(() => {
 	
 	});
</script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
<script
	src="https://pingendo.com/assets/bootstrap/bootstrap-4.0.0-alpha.6.min.js"></script>
</html>