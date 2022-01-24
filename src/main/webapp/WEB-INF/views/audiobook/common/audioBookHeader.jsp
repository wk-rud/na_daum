<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Le Café Livres</title>

<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">

<!-- 사용자작성 css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/audiobook/abstyle.css" />

<!-- 토글용 테스트용 다른 ui속성과 충돌나는중-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/audiobook/darkmode.css" />
<!-- 토글용 css 파일 로딩이 안되서 직접 붙여놓음. -->
<style>
input[id="switch"] {
	height: 0;
	width: 0;
	visibility: hidden;
}

.dk-tg {
	cursor: pointer;
	text-indent: -9999px;
	width: 52px;
	height: 27px;
	background: grey;
	float: right;
	border-radius: 100px;
	position: relative;
}

.dk-tg::after {
	content: '';
	position: absolute;
	top: 3px;
	left: 3px;
	width: 20px;
	height: 20px;
	background-color: white;
	border-radius: 90px;
	transition: 0.3s;
}

.darkmode:checked+.dk-tg {
	background-color: blue;
}

.darkmode:checked+.dk-tg::after {
	left: calc(100% - 5px);
	transform: translateX(-100%);
}

.dk-tg:active:after {
	width: 45px;
}
</style>
<%-- RedirectAttriutes가 session에 저장한 msg를 꺼내서 출력(바로 제거) --%>
<c:if test="${not empty msg}">
	<script>
		alert("${msg}");
	</script>
</c:if>
</head>
<body>
	<div id="container">
		<header>
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<div class="container-fluid">
					<button class="navbar-toggler" type="button"
						data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo03"
						aria-controls="navbarTogglerDemo03" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<a class="navbar-brand" href="${pageContext.request.contextPath}/audiobook/main">Le Café Livres</a>
					<div class="collapse navbar-collapse" id="navbarTogglerDemo03">
						<ul class="navbar-nav me-auto mb-2 mb-lg-0">
							<li class="nav-item"><a class="nav-link active"
								aria-current="page" href="${pageContext.request.contextPath}/audiobook/search/list">검색하기</a></li>
							<li class="nav-item"><a class="nav-link" href="#">추천</a></li>
							<li class="nav-item"><a class="nav-link" href="#"></a></li>
						</ul>

					</div>
				</div>


				<ul class="navbar-nav justify-content-end">
					<li class="nav-item">
						<div class="form-check pl-0 toggle darkmode">
							<input id="switch" type="checkbox" name="theme" class="darkmode">
							<label for="switch" class="dk-tg">Toggle</label>
						</div>
					</li>
				</ul>
				<form class="d-flex">
					<input class="form-control me-2" type="search" placeholder="Search"
						aria-label="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
				<button id="profile" type="button"
					class="btn btn-primary position-relative bg-light border-light rounded-circle">
					<svg height="32" aria-hidden="true" viewBox="0 0 16 16"
						version="1.1" width="32" data-view-component="true"
						class="octicon octicon-mark-github">
						    <path fill-rule="evenodd"
							d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"></path>
					</svg>
					<span id="bg-alarm"
						class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
						9 </span>
				</button>
				<ul class="navbar-nav justify-content-end">
						<li class="nav-item">
						<a id="sign-out" class="nav-link" href="#">
							<svg width="24px" height="24px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M13 12H22M22 12L18.6667 8M22 12L18.6667 16" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
							<path d="M14 7V5.1736C14 4.00352 12.9999 3.08334 11.8339 3.18051L3.83391 3.84717C2.79732 3.93356 2 4.80009 2 5.84027V18.1597C2 19.1999 2.79733 20.0664 3.83391 20.1528L11.8339 20.8195C12.9999 20.9167 14 19.9965 14 18.8264V17" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
							</svg>
						</a>
						</li>	
					</ul>

			</nav>

		</header>
		<script>
			/* 샘플코드 */
			/*$("#profile").click(function(){
				$("#bg-alarm").css("display","");
				let alarm_num = 1;
				$("#bg-alarm").text(alarm_num);
			});*/
			$("#sign-out").click(function() {
				alert("로그아웃되었습니다.");
			});

			$("#main-link").click(function() {
				alert("나중에 우리 포털 메인으로!");
			});

			/*실제 넣을 코드 : 알람 영역 있을때 클릭시 알람표시 사라짐*/

			$("#profile").click(function() {
				$("#bg-alarm").css("display", "none");
				let alarm_num = 5;

				$("#bg-alarm").text(alarm_num);
			});

			/* 비동기 통신할 영역
			    - 알람보낼부분이 없거나 사용자 클릭시 .css("display","none");
			    - 알람보낼부분이 있다면 .css("display","");
			    - 알람보낼개수는 .text(alarm_num);		
			 */

			/*비동기 통신하고 알람영역 보이게 할때 다음 함수 적용하세요  */
			/*  
			$("#profile").click(function(){
				$("#bg-alarm").css("display","");
				let alarm_num = 5; 여기에서 알람 보낼 갯수 받아온걸 매핑하시면 됩니다!
				$("#bg-alarm").text(alarm_num);
			 */
		</script>
		<section id="content">