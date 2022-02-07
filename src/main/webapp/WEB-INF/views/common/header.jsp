<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
    Date now = new Date();
    SimpleDateFormat date = new SimpleDateFormat("yyyy-MM");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.title}</title>

<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<!-- 부트스트랩 js/css -->
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script> 

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/member/stomp.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/member/info.js"></script>

<script src="https://kit.fontawesome.com/cd5e4bcf92.js" crossorigin="anonymous"></script>



<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/style2.css" /> 
<!-- member -->
<link href='${pageContext.request.contextPath}/resources/css/member/admin/admin.css' rel='stylesheet' />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/profile.css" />
<link href='${pageContext.request.contextPath}/resources/css/member/mypage/member.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/css/member/mypage/help.css' rel='stylesheet' />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/mypage/memberDetail.css" />

<%-- RedirectAttriutes가 session에 저장한 msg를 꺼내서 출력(바로 제거) --%>
<c:if test="${not empty msg}">
	<script>
		alert("${msg}");
	</script>
</c:if>
</head>
<body>
<!-- 비회원 / 로그인 X -->
<sec:authorize access="isAnonymous()">
	<a href="${pageContext.request.contextPath}/member/memberLogin.do">로그인폼</a>
</sec:authorize>

<!-- 로그인 O -->
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal" var="loginMember"/>
 <!-- 전체 영역 -->
  <div class="wrapper">
    <!-- 내비게이션 영역 -->
      <nav class="nadaum_header">
        <a href="${pageContext.request.contextPath}/main/main.do" class="logo">나:다움</a>
        <!-- 메뉴 -->
          <!-- 개인 메뉴 -->
        <div>
          <ul class="main-nav">
            <li class="nav-list activeOn">
              <a href="${pageContext.request.contextPath}/main/main.do">
                <i class="fas fa-home"></i>
                <span>홈</span>
              </a>
            </li>
            <li class="nav-list accept-drag">
              <a href="">
                <i class="fas fa-comment-dots"></i>
                <span>피드</span>
              </a>
            </li>
            <li class="nav-list accept-drag" id="calendar">
              <a href="${pageContext.request.contextPath}/calendar/calendarView.do">
                <i class="far fa-calendar-alt"></i>
                <span>캘린더</span>
              </a>
            </li>
            <li class="nav-list">
              <a href="${pageContext.request.contextPath}/board/boardList.do">
                <i class="fas fa-book-open"></i>
                <span>게시판</span>
              </a>
            </li>
          </ul>
          </div>
          <hr style="width: 100%; border-top: 1px solid #4b4b4b;" />
          <!-- 메뉴 -->
          <div>
          <ul class="menu-nav">
            <li class="nav-list personal-main">
                <i class="far fa-address-book"></i>
                <span>퍼스널</span>
            </li>
              <div class="personal-sub">
                <ul>
                  <li class="nav-list" id="diary">
                  	<a href="${pageContext.request.contextPath}/diary/diaryMain.do?date=<%= date.format(now) %>-01" class="accept-drag"><span>일기</span></a>
                  </li>
                  <li class="nav-list" id="accountBook">
                  	<a href="${pageContext.request.contextPath}/accountbook/accountbook.do" class="accept-drag"><span>가계부</span></a>
                  </li>
                  <li class="nav-list" id="memo">
                  	<a href="${pageContext.request.contextPath}/accountbook/accountbook.do" class="accept-drag"><span>메모</span></a>
                  </li>
                  <li class="nav-list" id="todoList">
                  	<a href="${pageContext.request.contextPath}/accountbook/accountbook.do" class="accept-drag"><span>투두리스트</span></a>
                  </li>
                </ul>
              </div>
            <li class="nav-list culture-main">
                <i class="fas fa-user-friends"></i>
                <span>문화</span>
            </li>
            <div class="culture-sub">
              <ul>
                <li class="nav-list">
                	<a href="${pageContext.request.contextPath}/culture/board/1"><span>전시</span></a>
                </li>
                <li class="nav-list">
                	<a href="${pageContext.request.contextPath}/movie/movieList.do"><span>영화</span></a>
                </li>
              </ul>
            </div>
            <li class="nav-list accept-drag" id="game">
              <a href="${pageContext.request.contextPath}/riot/riotheader.do">
                <i class="fas fa-gamepad"></i>
                <span>게임</span>
              </a>
            </li>
            <li class="nav-list">
              <a href="https://audioclip.naver.com">
                <i class="far fa-play-circle"></i>
                <span>오디오북</span>
              </a>
            </li>
          </ul>
        </div>
        <!-- 도움말 -->
        <div class="help-nav-wrap">
        <ul class="help-nav">
         <li class="nav-list">
          <a class="nav-link" href="${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=myPage">
         	<i class="fas fa-cog"></i>
          </a>
         </li>
          <li class="nav-list">
            <a id="help" class="nav-link">
              <i class="far fa-question-circle"></i>
              <!-- <span>도움말</span> -->
             </a>
          </li>
        </ul>
        </div>
      </nav>
        <!-- 헤더 -->
      <header class="nadaum-header">
        <!-- 뱃지생성완료, 클릭시 알람 영역 숨기기 완료 비동기 통신후 알람이 있을경우 다시 표기.-->
		<!-- 프로필 사진으로 보일시 크기에 맞게 이미지를 넣어야됨, 썸네일용 이미지 따로 저장하는 방법도 좋으나 일이 많아짐.-->
		<!-- 아래 span에서 동적으로 메시지 갯수다르게 처리하기 필요 -->
		<!-- 클릭하면 알림창이 나오게 하는 ui는 답이없음. -->
		<div class="user-factors">
			<span class="head-nickname-span">
				<a href="${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=myPage">
					<sec:authentication property="principal.nickname"/>님의 나:다움
				</a>
			</span>
		</div>
		<div class="profile-wrap user-factors">
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
							<img src="${pageContext.request.contextPath}/resources/upload/member/profile/${loginMember.profile}" alt="" style="width:45px; height:45px; object-fit:cover;" />										 		
						</c:if>								
					</c:if>								
				</div>						    
			</button>
			<div class="collapse" id="alarmList"></div>
		</div>
		<!--로그아웃  -->
		<div class="user-factors">
			<form
	    		name="logoutFrm"
	    		method="POST"
	    		action="${pageContext.request.contextPath}/member/memberLogout.do">
		    	<button id="sign-out" class="nav-link" type="submit">
					<i class="fas fa-sign-out-alt"></i>
				</button>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	    	</form>						
		</div>
      </header>
      <!-- 도움말 창 -->
      <div id="infowrap" style="display:none;">
		<div id="infowrapheader">
			<div class="info-title">			
				<h1>도움말</h1>
				<button type="button" id="closeInfo" class="close" data-dismiss="modal" aria-label="Close">
		        	<span aria-hidden="true">&times;</span>
		        </button>
			</div>
			<iframe id="nadaumInfo" title="Nadaum Info" src="${pageContext.request.contextPath}/member/mypage/memberInfo.do" >
			</iframe>
		</div>
	</div>
	
<script>			
	$(() => {	
		connect();
		countBedge();
	});
	var dest = '${loginMember.nickname}';
	
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
					const {no, code, id, status, content, regDate} = v;
					count++;
					
					let alarmDiv = `<div class="card card-body alarmContent">\${content}</div>`;
					if(code.substring(0,2) == 'he'){
						alarmDiv = `<div class="card card-body alarmContent">
						<a href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=\${code}">\${content}</a>								
						</div>`;
					}else{
						alarmDiv = `<div class="card card-body alarmContent">\${content}</div>`;
					}
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
    	$("#infowrap").css("display","block");
    });
    $("#closeInfo").click((e) => {
    	$("#infowrap").css("display","none");
	});
    
    $(".personal-main").click((e) => {
    	$(".personal-sub").slideToggle();
    });
    
    $(".culture-main").click((e) => {
    	$(".culture-sub").slideToggle();
    });
    
    
    /* iframe 드래그 */
    dragElement(document.getElementById("infowrap"));
</script>
</sec:authorize>

<!-- 각자 페이지 영역 -->
<section class="contentWrapper">
