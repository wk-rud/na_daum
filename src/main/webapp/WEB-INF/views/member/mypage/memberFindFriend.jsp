<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나:다움 친구찾기</title>

<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"ajax csrf 토큰
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
</head>

<body>
<sec:authentication property="principal" var="loginMember"/>

<div class="find-friend-wrap">
	<div class="find-friend-search">
		<h1>친구 찾기</h1>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<button id="search-friend-start" class="btn btn-outline-secondary" type="button">검색</button>
				<input id="searchFriend" type="text" name="title" class="form-control" required placeholder="닉네임을 입력하세요" aria-label="" aria-describedby="basic-addon1">
			</div>
		</div>
		<div class="search-result-list">
			<div class="list-group">
			
			</div>
		</div>
	</div>
</div>
	
	
<script>
$("#search-friend-start").click((e) => {
	if($("#searchFriend").val() == ''){
		alert("닉네임을 입력해주세요");
		return false;
	};
	let friend = $("#searchFriend").val();
	$.ajax({
		url: `${pageContext.request.contextPath}/member/mypage/searchStartFriend.do?friend=\${friend}`,
		success(resp){
			let searched = '';
			const $resultDiv = $(".search-result-list").find("div");
			$resultDiv.empty();
			if(resp == '0'){
				searched = `<span>그런 친구는 없어요</span>`;
				$resultDiv.append(searched);
				return;
			}else{
				if(resp.check == 'friend'){
					searched = `<span>\${resp.nickname}</span>
						<button type="button" class="btn btn-success btn-sm friend">친구</button>`;
				}else if(resp.check == 'follower'){
					searched = `<span>\${resp.nickname}</span>
						<button type="button" class="btn btn-outline-warning btn-sm follower">맞팔하기</button>`;
				}else if(resp.check == 'following'){
					searched = `<span>\${resp.nickname}</span>
						<button type="button" class="btn btn-warning btn-sm following">친구신청중</button>`;
				}else if(resp.check == 'free'){
					searched = `<span>\${resp.nickname}</span>
						<button type="button" class="btn btn-outline-warning btn-sm free">친구추가</button>`;
				}
			}
			
			$resultDiv.append(searched);
			
			$resultDiv.find("button").click((e) => {
				e.preventDefault();
				$resultDiv.empty();
				if(resp.check == 'friend'){
					searched = `<span>\${resp.nickname}</span>
						<button type="button" class="btn btn-outline-warning btn-sm free">친구추가</button>`;
				}else if(resp.check == 'follower'){
					searched = `<span>\${resp.nickname}</span>
						<button type="button" class="btn btn-success btn-sm friend">친구</button>`;
				}else if(resp.check == 'following'){
					searched = `<span>\${resp.nickname}</span>
						<button type="button" class="btn btn-outline-warning btn-sm free">친구추가</button>`;
				}else if(resp.check == 'free'){
					searched = `<span>\${resp.nickname}</span>
						<button type="button" class="btn btn-warning btn-sm following">친구신청중</button>`;
				}
				$resultDiv.append(searched);
				alarmSave('fr', resp.check, '${loginMember.id}', resp.nickname);
				updateFriend(resp.check, resp.nickname);
			});
		},
		error: console.log
	});
});


const updateFriend = (check, friendNickname) => {
	
	const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	$.ajax({
		url: '${pageContext.request.contextPath}/member/mypage/updateFriend.do',
		data: {check, friendNickname},
		headers: headers,
		method: "POST",
		success(resp){
			if(resp == '0')
				location.reload();
			else{
				console.log("change success");
				
			}
		},
		error: console.log
	});
};



$(() => {
	$("#searchFriend").autocomplete({
		source: function(request, response){
			$.ajax({
				url: "${pageContext.request.contextPath}/member/mypage/searchFriendsByNickname.do",
				data: {value: request.term},
				success(data){
					console.log(data);
					response(
						$.map(data, function(item){
							console.log(item)
							return{
								value: item,
							}
						})	
					);	
				},
				error:console.log				
			});
		},
		select: function(event, ui){
			console.log(ui);
			console.log(ui.item.value);
		},
		focus: function(event,ui){
			return false;
		},
		minLength: 1,
		autoFocus: true,
		classes:{
			"ui-autocomplete":"highlight"
		},
		delay: 500,
		position:{
			my: "right top", at: "right bottom"
		},
		close: function(event){
			console.log(event);
		}
	});
});

const alarmSave = (type, flag, senderId, findVal) => {
	let socketMsg = type + "," + flag + "," + senderId + "," + findVal;
	socket.send(socketMsg);		
};

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
		};
		sock.onclose = function() {
	      	console.log('connect close');
	      	
	    };
	
	    sock.onerror = function (err) {console.log('Errors : ' , err);};
};
</script>
</body>
</html>