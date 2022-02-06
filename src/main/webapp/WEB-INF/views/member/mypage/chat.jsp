<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<sec:authentication property="principal" var="loginMember"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나:다움 DM</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script> 
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/mypage/chat.css" type="text/css" charset="UTF-8" />
</head>
<body>
	<div class="chat-body">
		<div class="chat-wrap">
			<div id="msgArea" class="col">
				<div class="guest-msg-wrap">
				
				</div>
				<div class="host-msg-wrap">
				
				</div>
			</div>
			<div class="chat-send-btn-wrap">
				<div class="emotion-wrap-body">
					<div class="emotion-wrap">
						<div class="emotion-img-wrap blanket"><input type="hidden" value="blanket" /></div>
						<div class="emotion-img-wrap daechoong"><input type="hidden" value="daechoong" /></div>
						<div class="emotion-img-wrap gogo"><input type="hidden" value="gogo" /></div>
						<div class="emotion-img-wrap happy"><input type="hidden" value="happy" /></div>
						<div class="emotion-img-wrap trash"><input type="hidden" value="trash" /></div>
						<div class="emotion-img-wrap eat"><input type="hidden" value="eat" /></div>
					</div>
				</div>
				<div class="input-group mb-3 chat-btn-group-wrap">
					<div class="input-group-append">
						<button class="btn btn-outline-primary" id="emotion" type="button">이모티콘</button>
					</div>
					<input type="text" id="chat-msg-input" class="form-control" aria-label="Recipient's username" aria-describedby="basic-addon2">
					<div class="input-group-append">
						<button class="btn btn-outline-secondary" id="chat-send-btn" type="button">전송</button>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
var room = '${room}';
const $msgArea = $("#msgArea");
const $msg = $("#chat-msg-input");
$(() => {
	connect();
	$(".chat-btn-group-wrap").hide();
	if('${guest}' == 'guest'){
		$(".chat-btn-group-wrap").show();
	}
	$(".emotion-wrap").hide();
});

/* 이모티콘 관련 */
$("#emotion").click((e) => {
	$(".emotion-wrap").slideToggle();
});

$(".emotion-img-wrap").click((e) => {
	let emo = $(e.target).find('input').val();
	console.log(emo);
	$(".emotion-wrap").hide();
	emotionSend(emo);
});

/* 채팅창 종료시 상대에게 보내는 이벤트 */
window.onbeforeunload = function(e) {
	out();
	return;
};

/* 엔터로 메세지 전송 */
$msg.on('keyup', function(e) {
	if($msg.val() != ''){
		if(e.key === 'Enter' || e.keyCode === 13){
			$("#chat-send-btn").trigger('click');
		};		
	};
});

//전송 버튼 누르는 이벤트
$("#chat-send-btn").on("click", function(e) {	
	if($msg.val() != ''){
		send();	
		$msg.val('');		
	}
});

function connect() {
	var socket = new SockJS("http://localhost:9090/nadaum/chat");
	stompClient = Stomp.over(socket);
	
	stompClient.connect({}, function(frame){
		stompClient.send('/nadaum/chat/join', {}, JSON.stringify({
			'room':room,
			'writer': '${loginMember.nickname}'
		}));
		stompClient.subscribe("/topic/" + room, function(response){
			console.log('response = ' + response);
			console.log(JSON.parse(response.body));
			var resp = JSON.parse(response.body);
			console.log('resp = ' + resp.writer);
			var msg = '';
			console.log('resp.map = ' + resp.nickname);
			if(resp.writer != '${loginMember.nickname}' && resp.type == 'GREETING'){
				msg = `<div class="greeting-msg-wrap">
				<div class="greeting-body">
				<div class="greeting-msg"><span>\${resp.greeting}</span></div>
				<div class="greeting-time">\${resp.time}</div>
				</div>
				</div>`;
				$(".chat-btn-group-wrap").show();
			}else if(resp.writer != '${loginMember.nickname}' && resp.type == 'EMOTION'){
				msg = `<div class='guest-msg'>
					<div class="profile-wrapper">
						<div class="chat-profile-wrap">
							<img class="chat-profile" src="\${resp.profile}" alt="" />			
						</div>
						<div class="profile-nickname">
							\${resp.writer}
							<div class="guest-chat-wrap">
								<div class="emotion-img-wrap \${resp.message}"></div>
								<div class="chat-time-wrap">
									<div class="chat-time">\${resp.time}</div>
								</div>
							</div>
						</div>
					</div>					
				</div>`;
			}else if(resp.writer == '${loginMember.nickname}' && resp.type == 'EMOTION'){
				msg = `<div class='host-msg'>
				<div class="chat-time-wrap">
					<div class="chat-time">\${resp.time}</div>
				</div>
				<div class="emotion-img-wrap \${resp.message}"></div>
				</div>`;
			}else if(resp.writer == '${loginMember.nickname}' && resp.type != 'GREETING'){
				msg = `<div class='host-msg'>
				<div class="chat-time-wrap">
					<div class="chat-time">\${resp.time}</div>
				</div>
				<div class="chat-msg-wrap">\${resp.message}</div>
				</div>`;
			}else if(resp.type == 'CHAT_TYPE'){
				msg = `<div class='guest-msg'>
					<div class="profile-wrapper">
						<div class="chat-profile-wrap">
							<img class="chat-profile" src="\${resp.profile}" alt="" />			
						</div>
						<div class="profile-nickname">
							\${resp.writer}
							<div class="guest-chat-wrap">
								<div class="chat-msg-wrap"><p>\${resp.message}</p></div>
								<div class="chat-time-wrap">
									<div class="chat-time">\${resp.time}</div>
								</div>
							</div>
						</div>
					</div>					
				</div>`;
			}else if(resp.writer != '${loginMember.nickname}' && resp.type == 'OUT'){
				msg = `<div class="greeting-msg-wrap">
				<div class="greeting-body">
				<div class="greeting-msg"><span>\${resp.out}</span></div>
				</div>
				</div>`;
				$(".chat-btn-group-wrap").hide();
			}
			showMsg(msg);
		});
	});
};

function send(){
	var msg = $msg.val();
	var joinData = {
			'room': room,
			'writer': '${loginMember.nickname}',
			'loginType' : '${loginMember.loginType}',
			'profileStatus' : '${loginMember.profileStatus}',
			'profile' : '${loginMember.profile}',
			'message' : msg
		};
	console.log('msg = ' + msg);
	stompClient.send("/nadaum/chat/" + room,{},JSON.stringify(joinData));
	
};

function emotionSend(emo){
	var emotionData = {
			'room': room,
			'type': 'EMOTION',
			'writer': '${loginMember.nickname}',
			'loginType' : '${loginMember.loginType}',
			'profileStatus' : '${loginMember.profileStatus}',
			'profile' : '${loginMember.profile}',
			'message' : emo
		};
	stompClient.send("/nadaum/chat/" + room,{},JSON.stringify(emotionData));
}

function out(){
	var outData = {
			'room': room,
			'writer': '${loginMember.nickname}'
		};
	stompClient.send("/nadaum/chat/out/" + room,{},JSON.stringify(outData));
}

function showMsg(e){
	$msgArea.append(e);
	$msgArea.scrollTop($msgArea[0].scrollHeight);
};
</script>
</body>
</html>