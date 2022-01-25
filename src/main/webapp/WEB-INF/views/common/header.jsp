<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.title}</title>

<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script> 

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<!-- bootstrap css -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">

<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/style.css" /> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/profile.css" />

<!-- 토글용 테스트용 다른 ui속성과 충돌나는중-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/darkmode.css" />
<!-- 토글용 css 파일 로딩이 안되서 직접 붙여놓음. -->
<style>
input[id="switch"]{
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
.dk-tg::after{
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

.darkmode:checked + .dk-tg {
  background-color: blue;
}

.darkmode:checked + .dk-tg::after {
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
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal" var="loginMember"/>
	<div id="container">
		<header class="head-header">
			<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
				<!-- 타이틀 클릭시 메인으로 -->
				<a id="main-link" class="navbar-brand" href="#">나:다움</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav mr-auto">
						
						<!--요일 링크누르면 원하는 페이지 이동, 요일 날짜 출력 완료.-->
						<li class="nav-item active" ><a class="nav-link" href="#"> 
						<c:set var="now" value="<%=new java.util.Date()%>" /> 
						<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />
						</a></li>
						<!--날씨에 따라서 출력값이 바뀌게하기 -->
						<li class="nav-item active">
							<a class="nav-link" href="https://weather.naver.com/"> ❄ </a>
						</li>
					</ul>
					<ul class="navbar-nav justify-content-end">
                        <li class="nav-item dropdown">
                        	<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                        	data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <!-- 각자페이지 링크거시면 됩니다 -->
                                <a class="dropdown-item" href="https://www.naver.com">메인</a> 
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/accountbook/accountbook.do">가계부</a> 
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/culture/cultureBoardList.do">문화생활</a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/movie/movieList.do">영화</a> 
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/audiobook/">오디오북</a> 
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/riot/riotheader.do">롤전적</a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/calendar/calendarView.do">캘린더</a>
                            </div></li>
                    </ul>
					<!-- 뱃지생성완료, 클릭시 알람 영역 숨기기 완료 비동기 통신후 알람이 있을경우 다시 표기.-->
					<!-- 프로필 사진으로 보일시 크기에 맞게 이미지를 넣어야됨, 썸네일용 이미지 따로 저장하는 방법도 좋으나 일이 많아짐.-->
					<!-- 아래 span에서 동적으로 메시지 갯수다르게 처리하기 필요 -->
					<!-- 클릭하면 알림창이 나오게 하는 ui는 답이없음. -->
					<span class="head-nickname-span">
						<a href="${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=myPage">
							안녕하세요, <sec:authentication property="principal.nickname"/>님
						</a>
					</span>
					<div class="profile-wrap">
						<button id="profile" type="button"
							data-toggle="collapse" data-target="#alarmList" aria-expanded="false" aria-controls="alarmList">
							<div class="bedge-wrap"></div>
							<div class="thumbnail-wrap" style="border-radius:50%; width:45px; height: 45px; overflow:hidden; padding: 0;">
								<c:if test="${loginMember.loginType eq 'K'}">
									<img src="${loginMember.profile}" alt="" style="width:45px; height:45px; object-fit:cover;" />
								</c:if>	
								<c:if test="${loginMember.loginType eq 'D'}">
									<c:if test="${loginMember.profileStatus eq 'N'}">							 		
										<img src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png" alt="" style="width:45px; height:45px; object-fit:cover;" />
									</c:if>						
									<c:if test="${loginMember.profileStatus eq 'Y'}">		
										<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${attach.renamedFilename}" alt="" style="width:45px; height:45px; object-fit:cover;" />										 		
									</c:if>								
								</c:if>								
							</div>						    
						</button>
						<div class="collapse" id="alarmList"></div>
					</div>					

					<ul class="navbar-nav justify-content-end">
						<li class="nav-item">
							<div class="form-check pl-0">

							</div>
						</li>
					</ul>
					<ul class="navbar-nav justify-content-end">
					    <li class="nav-item">
					        <div class="form-check pl-0 toggle darkmode">
					            <input id="switch" type="checkbox" name="theme" class="darkmode">
					            <label for="switch" class="dk-tg">Toggle</label>
					        </div>
					    </li>
					</ul> 
					<!-- 다크모드 실험 중 -->
					<!-- <button onclick='changeToDarkMode();' class="btn btn-light">Dark</button> -->
					
					<!-- 도움말 버튼 -->
					<ul class="navbar-nav justify-content-end">
						<li class="nav-item">											
							<a id="help" class="nav-link">					
								<svg width="16px" height="16px" viewBox="0 0 16 16"	xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-question-circle">
									<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
									<path d="M5.255 5.786a.237.237 0 0 0 .241.247h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286zm1.557 5.763c0 .533.425.927 1.01.927.609 0 1.028-.394 1.028-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94z" />
								</svg>
							</a>
						</li>
					</ul>
					
					<ul class="navbar-nav justify-content-end">
						<li class="nav-item">
						</li>
					</ul>
					<!--로그아웃  -->
					<ul class="navbar-nav justify-content-end">
						<li class="nav-item">
						<form
				    		name="logoutFrm"
				    		method="POST"
				    		action="${pageContext.request.contextPath}/member/memberLogout.do">
					    	<button id="sign-out" class="nav-link" type="submit">
								<svg width="24px" height="24px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path d="M13 12H22M22 12L18.6667 8M22 12L18.6667 16" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
								<path d="M14 7V5.1736C14 4.00352 12.9999 3.08334 11.8339 3.18051L3.83391 3.84717C2.79732 3.93356 2 4.80009 2 5.84027V18.1597C2 19.1999 2.79733 20.0664 3.83391 20.1528L11.8339 20.8195C12.9999 20.9167 14 19.9965 14 18.8264V17" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
								</svg>
							</button>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				    	</form>
						
						</li>	
					</ul>
				</div>
			</nav>

		</header>
		<div id="infowrap">
			<div id="infowrapheader">
				<iframe id="nadaumInfo" title="Nadaum Info" src="${pageContext.request.contextPath}/member/mypage/memberInfo.do" >
				</iframe>
			</div>
		</div>
		<script>
			$(() => {
				countBedge();	
				$("#infowrap").hide();
			});
			
			$("#profile").click(function(){
				if($("#alarmList").hasClass("show")){
					console.log($("#alarmList").hasClass("show"));
					checkBedge();
				}
			});
			/* 샘플코드 */
			$("#sign-out").click(function(){
				alert("로그아웃되었습니다.");
			});
			
			$("#main-link").click(function(){
				alert("나중에 우리 포털 메인으로!");
			});
			
						
			/*실제 넣을 코드 : 알람 영역 있을때 클릭시 알람표시 사라짐*/
			/* const $alarmList = $(".alarm-list");
			$alarmList.hide();
			$("#profile").click((e) => {
				$alarmList.show();
			});
			
 			$("#profile").click(function(){
				$("#bg-alarm").css("display","none");
				
				
				$("#bg-alarm").text(alarm_num);
			});  */
			

			
			/* 비동기 통신할 영역
			    - 알람보낼부분이 없거나 사용자 클릭시 .css("display","none");
			    - 알람보낼부분이 있다면 .css("display","");
			    - 알람보낼개수는 .text(alarm_num);		
			*/
			/*$.ajax()*/			
			
			/*비동기 통신하고 알람영역 보이게 할때 다음 함수 적용하세요  */
			/*  
			$("#profile").click(function(){
				$("#bg-alarm").css("display","");
				let alarm_num = 5; 여기에서 알람 보낼 갯수 받아온걸 매핑하시면 됩니다!
				$("#bg-alarm").text(alarm_num);
			*/
	
			var socket = null;

		    $(document).ready(function (){
			    connectWs();
		    });
		    function connectWs(){
			   	sock = new SockJS("<c:url value='/echo'/>");
			   	socket = sock;
	
			   	sock.onopen = function() {
		           console.log('info: connection opened.');
			   	};
			
				sock.onmessage = function(evt) {
					var data = evt.data;
					console.log("ReceivMessage : " + data + "\n");
					
					countBedge();
					
				};
				sock.onclose = function() {
			      	console.log('connect close');
			      	/* setTimeout(function(){conntectWs();} , 1000); */
			    };
	
			    sock.onerror = function (err) {console.log('Errors : ' , err);};
		    };
		    
		    const countBedge = () => {
		    	$.ajax({
					url: `${pageContext.request.contextPath}/websocket/wsCountAlarm.do`,
					success(resp){
						
						const $alarmList = $("#alarmList");
						const $bedgeWrap = $(".bedge-wrap");
						$alarmList.empty();
						$bedgeWrap.empty();
						
						let count = 0;
						$(resp).each((i, v) => {
							count++;
							let alarmDiv = `<div class="card card-body alarmContent">\${v.content}</div>`;
							$alarmList.append(alarmDiv);
						});						
						
						if(count > 0){
							let bedge = `
							<span id='bg-alarm' class='badge rounded-pill bg-danger'>\${count}</span>
							`;
							
							$bedgeWrap.append(bedge);
						}						
					},
					error: console.log
				});		
		    };
		    
		    const checkBedge = () => {
		    	$.ajax({
					url: `${pageContext.request.contextPath}/websocket/checkAlarm.do`,
					success(resp){
						countBedge();
					},
					error: console.log
				});	
		    };
		    
		    /* iframe보이기 */
		    $("#help").click((e) => {
		    	$("#infowrap").show();
		    });
		    
		    /* iframe 드래그 */
		    dragElement(document.getElementById("infowrap"));
		  	
		  	function dragElement(element) {		  		
		  	
		  		var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
		  		if(document.getElementById(element.id + "header")){
		  			document.getElementById(element.id + "header").onmousedown = dragMouseDown;
		  		}else{
		  			element.onmousedown = dragMouseDown;
		  		}
		  			  	
			  	function dragMouseDown(e){
			  		e = e || window.event;
			  		e.preventDefault();
			  		pos3 = e.clientX;
			  		pos4 = e.clientY;
			  		document.onmouseup = closeDragElement;
			  		document.onmousemove = elementDrag;
			  	};
			  	
			  	function elementDrag(e) {
			  		e = e || window.event;
			        e.preventDefault();
			        pos1 = pos3 - e.clientX;
			        pos2 = pos4 - e.clientY;
			        pos3 = e.clientX;
			        pos4 = e.clientY;
			        element.style.top = (element.offsetTop - pos2) + "px";
			        element.style.left = (element.offsetLeft - pos1) + "px";
			  	};
			  	
			  	function closeDragElement() {
			  		document.onmouseup = null;
			        document.onmousemove = null;
			  	};
		  	
		  	};
			
		    
		    
		</script>
</sec:authorize>
		<section id="content">
			<sec:authorize access="isAnonymous()">
				<a href="${pageContext.request.contextPath}/member/memberLogin.do">로그인폼</a>
			</sec:authorize>