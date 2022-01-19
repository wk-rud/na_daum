<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="com.project.nadaum.culture.movie.controller.MovieApi"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/movie/movieList.css" />
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
<body>
	<div class="container">
		<div class="culture-thumnail">
			<!-- 썸네일 그림, 타이틀  -->
			<img
				src="${pageContext.request.contextPath}/resources/image/movie/movie_popcorn.png"
				alt="영화간판" />
			<h1 class="title">Movie</h1>
			<form class="form-inline search-form">

				<div class="form-group">
					<label for="Date" class="control-label">기간</label> <input
						type="text" class="form-control" id="startDate"> <input
						type="text" class="form-control" id="endDate">
				</div>

				<div class="form-group">
					<label for="TRL" class="control-label">지역</label> <select
						class="form-control" name="TRL" id="TRL">
						<option value="1">서울</option>
						<option value="2">경기</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</div>
				<div class="form-group">
					<label for="TRL" class="control-label">장르</label> <select
						class="form-control" name="TRL" id="TRL">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</div>
				<button type="submit" class="btn orange btn-default">Search</button>
			</form>
		</div>

		<!-- 검색 api -->
		<div class="col-md-12">
			<h1>영화 검색</h1>
			<div class="col-md-4">
				<form>
					<div class="form-group">
						<input type="text" class="form-control" id="keyword"
							placeholder="검색어를 입력하세요">
						<button type="button" class="btn btn-primary" id="btn-movies-find">검색</button>
					</div>
			</div>
		</div>


		<div class="py-5">
			<div class="container">
				<div class="row hidden-md-up">
					<div class="col-md-4">
						<div class="card">
							<div class="card-block">
								<h4 class="card-title">[BTS X Futura] HUMBLE SOULS</h4>
								<p class="card-text p-y-1">HYBE INSIGHT</p>
								<p class="card-text p-y-1">서울</p>
								<p class="card-text p-y-1">전시회장</p>
								<p class="card-text p-y-1">미술</p>
								<h6 class="card-subtitle text-muted">2021-11-30 ~
									2022-05-29</h6>
								<!--  <img class="content-img" src="http://www.culture.go.kr/upload/rdf/21/11/rdf_2021111913292645184.jpg" class="rounded" alt="Cinque Terre" /> -->
							</div>

						</div>
					</div>
					<table id=movie-container>
					<c:forEach var="i" begin="1" end="10"> 

						<div class="col-md-4">
							<div class="card">
								<div class="card-block">
			
									<h4 class="card-title">${movieCd}</h4>								
									<p class="card-text p-y-1" >${movieNm}</p>							
									<h6 class="card-subtitle text-muted">${prdYear}</h6>									
									<p class="card-text p-y-1">${openDt}</p>
									<p class="card-text p-y-1">${typeNm}</p>
									<p class="card-text p-y-1">${nationAlt}</p>
									<p class="card-text p-y-1">${genreAlt}</p>
									<p class="card-trfext p-y-1">${peopleNm}</p>
									<h6 class="card-subtitle text-muted">
										<a href="#" class="card-link">Second link</a> <a href="#"
											class="card-link"><img class="thumnail"
											src="${movie.imgUrl}" alt="" /></a>
										<fmt:formatDate value="${movie.pubDate}" pattern="yyyy/MM/dd" />
								</tr>
								</div>
							</div>
						</div>
					 </c:forEach>
		</table>
					
					
	
					<table id=movie-container>
					<c:forEach items="${list}" var="movie">

						<div class="col-md-4">
							<div class="card">
								<div class="card-block">
			
									<p class="card-text p-y-1" >${movie.code}</p>							
									<h4 class="card-title">${movie.title}</h4>								
									<h6 class="card-subtitle text-muted">${movie.director}</h6>									
									<p class="card-text p-y-1">${movie.actor}</p>
									<h6 class="card-subtitle text-muted">
										<a href="#" class="card-link">Second link</a> <a href="#"
											class="card-link"><img class="thumnail"
											src="${movie.imgUrl}" alt="" /></a>
										<fmt:formatDate value="${movie.pubDate}" pattern="yyyy/MM/dd" />
								</tr>
								</div>
							</div>
						</div>
					</c:forEach>
					</table>
					
				</div>
			</div>
		</div>
	</div>

</body>
<script>
	/* 검색api 버튼 누를 시  */
	var main = {
		init : function() {
			var _this = this;
			$('#btn-movies-find').on('click', function() {
				_this.find();
			});
		},
		find : function() {
			var keyword = $('#keyword').val();
			$.ajax({
				type : 'GET',
				url : '/movie/moviesearch.do/' + keyword,
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
			}).done(function(res) {
				alert(JSON.stringify(res));
			}).fail(function(error) {
				alert(JSON.stringify(error));
			});
		}
	};
	
	/* 영화불러오기 */
	
/* 클릭시 상세보기 */

$(() => {
	$("p[data-code]").click((e) => {
		// console.log(e.target); // td
		const code = $tr.data("code");
		location.href = `${pageContext.request.contextPath}/movie/movieDetail.do?code=\${code}`;
	});
});

$()
</script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
<script
	src="https://pingendo.com/assets/bootstrap/bootstrap-4.0.0-alpha.6.min.js"></script>
</html>