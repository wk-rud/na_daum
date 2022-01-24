<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/audiobook/common/audioBookHeader.jsp">
	<jsp:param value="Le Café Livres" name="title" />
</jsp:include>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<style>
/* Make the image fully responsive */
.carousel-inner {
	width: "1100";
	height: "500";
}
/* width: 100%;
	height: 100%; */
</style>
<div id="demo" class="carousel slide" data-ride="carousel">
	<!-- 	<ul class="carousel-indicators">
		<li data-target="#demo" data-slide-to="0" class="active"></li>
		<li data-target="#demo" data-slide-to="1"></li>
		<li data-target="#demo" data-slide-to="2"></li>
	</ul> -->
	<div class="carousel-inner">
		<div class="carousel-item active">
			<img
				src="https://img.sbs.co.kr/newimg/news/20161117/200997114_1280.jpg"
				id="center-image" alt="배너1" class="d-block mx-auto mt-5" />
			<div class="carousel-caption d-none d-md-block">
				<h3></h3>
				<p></p>
			</div>
		</div>
		<div class="carousel-item">
			<img
				src="https://img.sbs.co.kr/newimg/news/20161117/200997114_1280.jpg"
				id="center-image" alt="배너2" class="d-block mx-auto mt-5">
			<div class="carousel-caption">
				<h3>조 성 진</h3>
				<p>리사이틀 공연</p>
			</div>
		</div>
		<div class="carousel-item">
			<img
				src="https://img.sbs.co.kr/newimg/news/20161117/200997114_1280.jpg"
				id="center-image" alt="배너3" class="d-block mx-auto mt-5">
			<div class="carousel-caption">
				<h3>New York</h3>
				<p>New Jersey</p>
			</div>
		</div>
	</div>
	<a class="carousel-control-prev" href="#demo" data-slide="prev"> <span
		class="carousel-control-prev-icon"></span>
	</a> <a class="carousel-control-next" href="#demo" data-slide="next"> <span
		class="carousel-control-next-icon"></span>
	</a>
</div>

<div class="row row-cols-3 row-cols-md-2 ">
	<div class="col mb-4 ">
		<div class="card" style="width: 18rem;">
			<img src="https://pbs.twimg.com/media/DQHKDvhUEAAI0xM.jpg"
				class="card-img-top">
			<div class="card-body">
				<h5 class="card-title">성시경의 오디오북</h5>
				<p class="card-text">밤잠 설치는 당신을 5분만에 잠들게 해주는 자장가 라이브버전</p>
			</div>
			<div class="card-body">
				<a href="#" class="card-link">구매하기</a> <a href="#" class="card-link">둘러보기</a>
			</div>
		</div>
	</div>
	<div class="col mb-4">
		<div class="card" style="width: 18rem;">
			<img src="https://image.yes24.com/momo/TopCate0001/kepub/L_84916.jpg"
				class="card-img-top">
			<div class="card-body">
				<h5 class="card-title">셜록 홈즈 전집1</h5>
				<p class="card-text">자기전에 읽는 셜록홈즈</p>
			</div>
			<div class="card-body">
				<a href="#" class="card-link">구매하기</a> <a href="#" class="card-link">둘러보기</a>
			</div>

		</div>
	</div>
	<div class="col mb-4">
		<div class="card" style="width: 18rem;">
			<img
				src="https://image.yes24.com/momo/TopCate48/MidCate06/4759386.jpg"
				class="card-img-top">
			<div class="card-body">
				<h5 class="card-title">해리포터와 불의 잔</h5>
				<p class="card-text">해리포터 출연진이 녹음한 해리포터 오디오북</p>
			</div>
			<div class="card-body">
				<a href="#" class="card-link">구매하기</a> <a href="#" class="card-link">둘러보기</a>
			</div>
		</div>
	</div>
	<div class="col mb-4">
		<div class="card" style="width: 18rem;">
			<img src="https://newsimg.sedaily.com/2016/11/16/1L3ZQUQWVY_4.jpg"
				class="card-img-top">
			<div class="card-body">
				<h5 class="card-title">조성진의 클래식</h5>
				<p class="card-text">쇼팽 콩쿨 우승자가 당신이 잠들기 까지 연주해주는 라이브 콘서트</p>
			</div>
			<div class="card-body">
				<button type="button" id="testBtn" class="btn btn-primary"
					data-bs-toggle="modal" data-bs-target="#staticBackdrop">
					소개</button>
				<a href="${pageContext.request.contextPath}/audiobook/detail" class="card-link">더보기</a>

				<!-- <a href="#" class="card-link">구매하기</a> <a href="#" class="card-link">둘러보기</a> -->
			</div>
		</div>
	</div>
</div>



<!-- 결제 모달 영역  -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="staticBackdropLabel">결제요청</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">...</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary">진행</button>
			</div>
		</div>
	</div>
</div>


<script>
	$('#testBtn').on(
			'click',
			function() {
				const $test = $('#testBtn');
				const data = $test.parent().parent().children('div.card-body')
						.first().children('h5');
				console.log(data);
				$('#staticBackdrop').modal('show');
			});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />