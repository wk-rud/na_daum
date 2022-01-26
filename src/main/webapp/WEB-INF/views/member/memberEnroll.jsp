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
<title>나:다움 회원가입</title>
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
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href='${pageContext.request.contextPath}/resources/css/member/enroll.css' rel='stylesheet' />
<script>
</script>
</head>
<body>

<div class="enroll-wrapper">	
	
	<form id="memberEnrollFrm" method="post">
		<div class="enroll-body">	
			<div class="logo-wrap">
				<div class="logo">나:다움</div>
			</div>
			<div id="enrollFrmCarousel" class="carousel slide" data-ride="carousel">
				<div class="carousel-inner">				
					<div class="carousel-item active">
						<label for="id">아이디<span class="text-danger must-need"> 필수</span></label>						
						<input type="text" class="form-control" name="id" id="id" value="wowo" 
							placeholder="영문 한글 숫자 4~10 글자입니다." required>
						<span class="text-success guide ok">이 아이디는 사용가능합니다.</span>
						<span class="text-danger guide error">이 아이디는 사용불가능합니다.</span>
						<input type="hidden" id="idValid" value="0" />
						<br /> 
						<label for="password">비밀번호<span class="text-danger must-need"> 필수</span></label>
						<input type="password" class="form-control" name="password" id="password" value="qwer1234"
							placeholder="비밀번호는 숫자, 영어포함 8 ~ 15자리 사이 입니다." required>									
						<br /> 
						<label for="passwordCheck">비밀번호 확인</label>
						<input type="password" class="form-control" id="passwordCheck" value="qwer1234"
							placeholder="비밀번호 확인" required>
						<br /> 
						<label for="nickname">별명<span class="text-danger must-need"> 필수</span></label>
						<input type="text" class="form-control" name="nickname" id="nickname" value="qwer1234"
							placeholder="한글과 영어 숫자 사용 4~8 글자입니다." required>
						<span class="text-success guide n-ok">사용가능한 별명입니다.</span>
						<span class="text-danger guide n-error">사용할 수 없는 별명입니다.</span>
						<input type="hidden" id="nValid" value="0" />
					</div>
					<div class="carousel-item">
						<label for="nameCheck">이름<span class="text-danger must-need"> 필수</span></label>
						<input type="text" class="form-control" name="name" id="nameCheck" value="dlfma" placeholder="이름" required>									
						<br /> 
					<label for="email">이메일<span class="text-danger must-need"> 필수</span></label>						
						<div class="input-group mb-3" >
							<input type="text" id="email" class="form-control" placeholder="이메일" aria-label="Recipient's username" aria-describedby="basic-addon2">
							<div class="input-group-append">
								<span class="input-group-text" id="basic-addon2">@</span>
							</div>
							<input type="text" class="form-control" id="selfWrite" readonly="readonly"/>
							<select id="siteSelect" class="custom-select">
								<option value="" selected>선택</option>
								<option value="self">직접입력</option>
								<option value="naver">네이버</option>
								<option value="gmail">구글</option>
							</select>
						</div>	
						<span class="text-success email-ok">사용가능한 이메일입니다.</span>
						<span class="text-danger email-error">사용할 수 없는 이메일입니다.</span>	
						<input type="hidden" id="emailValid" value="0" />				
						<input type="hidden" name="email" id="addEmail"/>						
						<br /> 
						<div class="address-wrap">
						
							<label for="postcode">주소</label>
							<div class="input-group mb-3">
								<input type="text" class="form-control" id="postcode" aria-label="Recipient's username" aria-describedby="button-addon2" readonly="readonly">
								<div class="input-group-append">
									<button class="btn btn-outline-secondary address_button" type="button" id="button-addon2" onclick="findAddress();">주소검색</button>
								</div>
							</div>
									
							<input type="text" id="allAddress" class="form-control" readonly="readonly"/><br />
							<input type="text" id="detailAddress" class="form-control" readonly="readonly"/>
							<input type="hidden" name="address" class="form-control addAddress" required />
							<div class="enroll-btn-wrap">
								<button type="submit" id="enroll-btn" class="btn btn-outline-success enroll">회원가입</button>
							</div>
						</div>				
					</div>
					
					<div class="page-move-btn-wrap">
						<div class="page-move-btn">
							<button type="button" id="prev-page" class="btn btn-warning">
								<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							</button>
							<button type="button" id="next-page" class="btn btn-warning">
								<span class="carousel-control-next-icon" aria-hidden="false"></span>
							</button>
						</div>
					</div>
				</div>	
							
			</div>
		</div>
		
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
</div>	
<script>
$(".logo").click((e) => {
	location.replace('${pageContext.request.contextPath}/member/memberLogin.do');
});

const $enrollCarousel = $("#enrollFrmCarousel");
$enrollCarousel.carousel({
	interval: false,
	wrap: false
});

$("#prev-page").on("click", () => {
	$enrollCarousel.carousel('prev');
});
$("#next-page").on("click", () => {
	$enrollCarousel.carousel('next');
});

// 이메일
const $siteSelect = $("#siteSelect");
const $selfWrite = $("#selfWrite");
$siteSelect.change(() => {
	if($siteSelect.val() == 'naver'){
		$selfWrite
			.attr('readonly', true)
			.val('naver.com');		
		$(addEmail).val($(email).val() + '@naver.com');
	}else if($siteSelect.val() == 'gmail'){
		$selfWrite
			.attr('readonly', true)
			.val('gmail.com');
		$(addEmail).val($(email).val() + '@gmail.com');
	}else{
		$selfWrite
			.attr('readonly', false)
			.val('');
		$selfWrite.blur(() => {
			$(addEmail).val($(email).val() + '@' + $siteSelect.val());
		});
	}
});


// 유효성 검사
$("#enroll-btn").click((e) => {
		
	const $password = $(password);
	const $passwordCheck = $(passwordCheck);
	const $nickname = $(nickname);
	const $name = $(nameCheck);

	// 아이디
	if($idValid.val() == '0'){
		alert("사용할 수 없는 아이디 입니다.");
		$enrollCarousel.carousel(0);
		$(id).focus();
		return false;
	}

	// 비밀번호	
	if(! /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,15}$/.test($password.val())){
        alert("비밀번호는 숫자와 영문이 포함된 8~15자리입니다");
        $enrollCarousel.carousel(0);
		$password.focus();
		return false;
    }
	
	// 비밀번호 일치 확인
	if($password.val() != $passwordCheck.val()){
    	alert("비밀번호가 일치하지 않습니다.");
    	$enrollCarousel.carousel(0);
		$passwordCheck.focus();
		return false;
	}
	
	// 별명
	if($nValid.val() == '0'){
		alert("사용할 수 없는 별명 입니다.");
		$enrollCarousel.carousel(0);
		$nickname.focus();
		return false;
	}
	
	// 이름
	if(!/^[가-힣]{2,5}$/.test($name.val())){
    	alert("이름은 한글로만 이루어져야 합니다.");
    	$enrollCarousel.carousel(1);
    	$name.focus();
    	return false;
    }
	
	// 이메일	
	if($(email).val() == ''){
    	alert("이메일을 입력해 주세요.");
    	$enrollCarousel.carousel(1);
    	$(email).focus();
    	return false;
    }
	if($emailValid.val() == '0'){
		alert("사용할 수 없는 이메일 입니다.");
    	$enrollCarousel.carousel(1);
    	$(email).focus();
    	return false;
	}
	if($siteSelect.val() == ''){
    	alert("이메일 주소를 선택해 주세요.");
    	$enrollCarousel.carousel(1);
    	$(siteSelect).focus();
    	return false;
    }
	if($siteSelect.val() == 'self'){
		if($selfWrite.val() == ''){
			alert("이메일 주소를 입력해 주세요.");
			$enrollCarousel.carousel(1);
			$selfWrite.focus();
	    	return false;
		}
	}
	
	
	return true;
});	

const $emailError = $(".email-error");
const $emailOk = $(".email-ok");
const $emailValid = $("#emailValid");
$emailError.hide();
$emailOk.hide();
$(email).keyup((e) => {
	const emailVal = $(e.target).val();
	
	if(emailVal.length < 4){
		$emailError.hide();
		$emailOk.hide();
		$emailValid.val(0);
		return;
	};
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/checkEmailDuplicate.do",
		data:{
			email: emailVal
		},
		success(resp){
			console.log(resp);
			const {available} = resp;
			if(available){
				if(/^[A-Za-z0-9가-힣._+%-]{4,20}$/.test(emailVal)){
					$emailError.hide();
					$emailOk.show();
					$emailValid.val(1);					
				}else{
					$emailError.show();
					$emailOk.hide();
					$emailValid.val(0);
				}
			}else{
				$emailError.show();
				$emailOk.hide();
				$emailValid.val(0);
			}
		},
		error: console.log
	})
});

// 별명 중복 검사
const $nError = $(".guide.n-error");
const $nOk = $(".guide.n-ok");	
const $nValid = $("#nValid");
$nError.hide();
$nOk.hide();
$(nickname).keyup((e) => {
	
	const nVal = $(e.target).val();
	
	if(nVal.length < 2){
		$nError.hide();
		$nOk.hide();
		$nValid.val(0);
		return;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/checkNicknameDuplicate.do",
		data:{
			nickname: nVal 
		},
		success(resp){
			console.log(resp);
			const {available} = resp;
			if(available){
				if(/^[A-Z|가-힣|0-9|a-z]{4,10}$/.test(nVal)){
					$nError.hide();
					$nOk.show();
					$nValid.val(1);					
				}else{
					$nError.show();
					$nOk.hide();
					$nValid.val(0);
				}
			}else{
				$nError.show();
				$nOk.hide();
				$nValid.val(0);
			}
		},
		error: console.log
	});
});

// 아이디 중복 검사
const $idError = $(".guide.error");
const $idOk = $(".guide.ok");
const $idValid = $("#idValid");
$idError.hide();
$idOk.hide();
$(id).keyup((e) => {
	
	const idVal = $(e.target).val();		
	
	if(idVal.length < 4){
		$idError.hide();
		$idOk.hide();
		$idValid.val(0);
		return;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
		data:{
			id: idVal 
		},
		success(resp){
			console.log(resp);
			const {available} = resp;
			if(available){
				if(/^[A-Z|가-힣|0-9|a-z]{4,10}$/.test(idVal)){
					$idError.hide();
					$idOk.show();
					$idValid.val(1);					
				}else{
					$idError.show();
					$idOk.hide();
					$idValid.val(0);
				}
			}else{
				$idError.show();
				$idOk.hide();
				$idValid.val(0);
			}
		},
		error: console.log
	});
});



// 주소 합치기
$(detailAddress).blur((e) => {
	$(".addAddress").val($(allAddress).val() + ' ' + $(detailAddress).val());
});

$("#postcode").click((e) => {
	findAddress();
});

// 카카오 우편번호 서비스
//http://postcode.map.daum.net/guide
function findAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
        	
        	 var addr = ''; // 주소 변수
             var extraAddr = ''; // 참고항목 변수

             //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
             if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                 addr = data.roadAddress;
             } else { // 사용자가 지번 주소를 선택했을 경우(J)
                 addr = data.jibunAddress;
             }

             // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
             if(data.userSelectedType === 'R'){
                 // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                 // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                 if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                     extraAddr += data.bname;
                 }
                 // 건물명이 있고, 공동주택일 경우 추가한다.
                 if(data.buildingName !== '' && data.apartment === 'Y'){
                     extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                 }
                 // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                 if(extraAddr !== ''){
                     extraAddr = ' (' + extraAddr + ')';
                 }
                 // 조합된 참고항목을 해당 필드에 넣는다.
                 addr += extraAddr;
             
             } else {
                 addr += ' ';
             }

             // 우편번호와 주소 정보를 해당 필드에 넣는다.
             $("#postcode").val(data.zonecode);
             $("#allAddress").val(addr);
             // 커서를 상세주소 필드로 이동한다.
             $("#detailAddress")
             	.attr('readonly', false)
             	.focus();
        }
    }).open();
}
</script>

</body>
</html>