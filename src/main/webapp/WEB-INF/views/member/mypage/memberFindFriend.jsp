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
<title>친구찾기</title>

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
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"ajax csrf 토큰
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
</head>

<body>
	<sec:authentication property="principal" var="loginMember"/>
	<label for="find-friends">친구검색</label>
	<input type="text" list="all-friends" name="friend" id="find-friends" />
	<datalist id="all-friends"></datalist>
	<div class="recommend-friends">
		
	</div>
	<div class="selected-friend"></div>
	
	<script>
	$(() => {
		requestAllFriend();
	});
	
	const requestFriend = (name, flag) => {
		
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
		
		$.ajax({
			url: `${pageContext.request.contextPath}/member/mypage/requestFriend.do`,
			data: {name,flag},
			/* csrf token */
			headers: headers,
			type: "POST",
			success(resp) {
				console.log(resp);
				if(resp == '1')									
					location.reload();
				
			},
			error: console.log
		});
		
	};
	
	
	// 시작시 불러오는 정보
	const requestAllFriend = () => {
		$.ajax({
			url: "${pageContext.request.contextPath}/member/mypage/requestAllFriend.do",
			success(resp){
				const $dList = $("#all-friends");
				$dList.empty();
				$(resp).each((e, v) => {
					/* 내가 팔로잉 ff */
					var ff = [];
					$(v.ffriend).each((i, ffr) => {
						ff.push(ffr.id);
					});
					/* 맞팔 fr */
					var fr = [];
					$(v.friend).each((i, frr) => {
						fr.push(frr.friendId);
					});
					/* 나를 팔로우 rf */
					var rf = [];
					$(v.rfriend).each((i, rfr) => {
						rf.push(rfr.follower);
					});
					/* 전체 회원 m 닉네임 */
					var noRelation = [];
					var follower = [];
					var friend = [];
					var following = [];
					$(v.memberList).each((i, ml) => {
						if(ff.includes(ml.id)){
							following.push(ml.nickname);
						}else if(fr.includes(ml.id)){
							friend.push(ml.nickname);
						}else if(rf.includes(ml.id)){
							follower.push(ml.nickname);
						}
						
						if(!ff.includes(ml.id)){
							if(!fr.includes(ml.id)){
								if(!rf.includes(ml.id)){
									noRelation.push(ml.nickname);									
								}
							}
						}
						
						let op = `<option value="\${ml.nickname}"/>`;					
						$dList.append(op);
						
					});					
					
					makeButton(noRelation, follower, friend, following);
					
				});
			}
		});
	};
	
	const makeButton = (noRelation, follower, friend, following) => {
		console.log(noRelation, follower, friend, following);
		$("#find-friends").change(() => {
			
			const $selectedFriend = $(".selected-friend");
			let button = '';
			let flag = '';
			let findVal = $("#find-friends").val();
			if(noRelation.includes(findVal)){
				flag = 'noRelation';				
				button = `<span>\${findVal}</span>
					<input type="checkbox" class="btn-check addFriend" id="btn-check-outlined" autocomplete="off" style="display:none;">
					<label class="btn btn-outline-warning" for="btn-check-outlined">친구추가</label>`;
			}else if(follower.includes(findVal)){
				flag = 'follower';
				button = `<span>\${findVal}</span>
					<input type="checkbox" class="btn-check addFriend" id="btn-check-outlined" autocomplete="off" style="display:none;">
					<label class="btn btn-outline-warning" for="btn-check-outlined">친구수락</label>`;
			}else if(friend.includes(findVal)){
				flag = 'friend';
				button = `<span>\${findVal}</span>
					<input type="checkbox" class="btn-check addFriend" checked id="btn-check-outlined" autocomplete="off" style="display:none;">
					<label class="btn btn-success" for="btn-check-outlined">친구</label>`;
			}else if(following.includes(findVal)){
				flag = 'following';
				button = `<span>\${findVal}</span>
					<input type="checkbox" class="btn-check addFriend" checked id="btn-check-outlined" autocomplete="off" style="display:none;">
					<label class="btn btn-success" for="btn-check-outlined">친추중</label>`;
			}
			
			$selectedFriend
				.empty()
				.append(button);
		
			$("#btn-check-outlined").change((e) => {
				console.log(flag);			
				
				if(flag == 'noRelation'){			
					button = `<span>\${findVal}</span>
						<input type="checkbox" class="btn-check addFriend" checked id="btn-check-outlined" autocomplete="off" style="display:none;">
						<label class="btn btn-success" for="btn-check-outlined">친추중</label>`;
				}else if(flag == 'follower'){
					button = `<span>\${findVal}</span>
						<input type="checkbox" class="btn-check addFriend" checked id="btn-check-outlined" autocomplete="off" style="display:none;">
						<label class="btn btn-success" for="btn-check-outlined">친구</label>`;
				}else if(flag == 'friend'){
					button = `<span>\${findVal}</span>
						<input type="checkbox" class="btn-check addFriend" id="btn-check-outlined" autocomplete="off" style="display:none;">
						<label class="btn btn-outline-warning" for="btn-check-outlined">친구추가</label>`;
				}else if(flag == 'following'){
					button = `<span>\${findVal}</span>
						<input type="checkbox" class="btn-check addFriend" id="btn-check-outlined" autocomplete="off" style="display:none;">
						<label class="btn btn-outline-warning" for="btn-check-outlined">친구추가</label>`;
				}
				
				let senderId = '${loginMember.id}';
				alarmSave(flag, senderId, findVal);
												
				$selectedFriend
					.empty()
					.append(button);
				
				requestFriend(findVal, flag);					

			});
			
		});
	};
	
	const alarmSave = (flag, senderId, findVal) => {
		let socketMsg = flag + "," + senderId + "," + findVal;
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
	      	/* setTimeout(function(){conntectWs();} , 1000); */
	    };
	
	    sock.onerror = function (err) {console.log('Errors : ' , err);};
    }
	</script>

</body>
</html>