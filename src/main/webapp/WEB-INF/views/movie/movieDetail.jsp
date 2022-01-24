<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page
	import="com.project.nadaum.culture.movie.controller.GetMovieDetailApi"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="영화상세보기 " name="title" />
</jsp:include>
<style>
div#board-container {
	width: 400px;
}

input, button, textarea {
	margin-bottom: 15px;
}

button {
	overflow: hidden;
}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label {
	text-align: left;
}
</style>
<div id="movie-container" class="mx-auto text-center">

	<div id="movie-detail">
		 <c:forEach var="movie" items="${list}">
		 	<input type="text" class="form-control-" name="movieCd" title="영화코드"
				id="movieCd" value="${movie.movieCd}" readonly>
			<input type="text" class="form-control-" placeholder="제목"
				name="title" id="title" value="${movie.movieNm}" readonly>
			<input type="text" class="form-control-" name="openDt" title="개봉일"
				id="date" value="${movie.openDt}" readonly>
			<input type="text" class="form-control-" name="nation" title="제작국가"
				id="nationNm" value="${movie.nation}" readonly>
			<input type="text" class="form-control-" name="genreNm" title="장르"
				id="genreNm" value="${movie.genreNm}" readonly>
			<input type="text" class="form-control-" name="director" title="감독"
				id="director" value="${movie.director}" readonly>
			<p>${movie.movieCd}</p>
			<p>${movie.movieNm}</p>
			<p>${movie.openDt}</p>
			<p>${movie.nation}</p>
			<p>${movie.genreNm}</p>
			<p>${movie.director}</p>
		</c:forEach>
	</div>
	
</div>

<div class="movie-detail-container">
	<!-- 영화상세보기 정보 -->
	<div class="movie-detail-content">

		<div class="row featurette">
			<div class="col-md-7 order-md-2">
				<h2 class="featurette-heading">
					Oh yeah, it’s that good. <span class="text-muted">See for
						yourself.</span>
				</h2>
				<p class="lead">Donec ullamcorper nulla non metus auctor
					fringilla. Vestibulum id ligula porta felis euismod semper.
					Praesent commodo cursus magna, vel scelerisque nisl consectetur.
					Fusce dapibus, tellus ac cursus commodo.</p>
			</div>
			<div class="col-md-5 order-md-1">
				<svg
					class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto"
					width="500" height="500" xmlns="http://www.w3.org/2000/svg"
					preserveAspectRatio="xMidYMid slice" focusable="false" role="img"
					aria-label="Placeholder: 500x500">
					<title>Placeholder</title><rect width="100%" height="100%"
						fill="#eee" />
					<text x="50%" y="50%" fill="#aaa" dy=".3em">500x500</text></svg>
			</div>
		</div>
		<!-- 캘린더 약속 버튼 -->
		<div>
			<p>
				<a class="btn btn-secondary" href="#" role="button">View details
					&raquo;</a>
			</p>
		</div>

		<!-- 영화 줄거리 -->
		<hr />
		<h2 class="blog-post-title">영화 줄거리</h2>
		<p class="blog-post-meta">
			January 1, 2014 by <a href="#">Mark</a>
		</p>

		<p>This blog post shows a few different types of content that’s
			supported and styled with Bootstrap. Basic typography, images, and
			code are all supported.</p>

	</div>
	<hr class="featurette-divider" />

	<!-- 영화 평점 -->
	<div class="movie-rating">
		<h2 class="blog-post-title">영화 평점</h2>
		<p class="blog-post-meta">
			January 1, 2014 by <a href="#">Mark</a>
		</p>

		<p>This blog post shows a few different types of content that’s
			supported and styled with Bootstrap. Basic typography, images, and
			code are all supported.</p>

	</div>

	<hr class="featurette-divider" />

	<!-- 총 영화 댓글 -->
	<div class="movie-comments">
		<!-- 댓글 작성 부분 -->
		<div class-="write-comments">
			<aside class="col-md-4 blog-sidebar">
				<div class="p-4 mb-3 bg-light rounded">
					<h4 class="font-italic">About</h4>
					<p class="mb-0">
						Etiam porta <em>sem malesuada magna</em> mollis euismod. Cras
						mattis consectetur purus sit amet fermentum. Aenean lacinia
						bibendum nulla sed consectetur.
					</p>

					<!-- 댓글 버튼 -->
					<div class="comments-btn">
						<nav class="blog-pagination">
							<a class="btn btn-outline-primary" href="#">등록</a> <a
								class="btn btn-outline-secondary disabled" href="#"
								tabindex="-1" aria-disabled="true">취소</a>
						</nav>
					</div>
				</div>

				<!-- 댓글 목록 -->
		</div>

		<hr class="featurette-divider" />

	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
