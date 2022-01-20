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
<script>
$(() => {
	$(enrollModal)
		.modal()
		.on("hide.bs.modal", (e) => {
			location.href='${empty header.referer || header.referer.contains('/member/memberLogin.do') ? pageContext.request.contextPath : header.referer}';
		});
});
</script>
</head>
<body>
	<!-- Modal -->
	<div class="modal fade" id="enrollModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">회원가입</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<form
					id="memberEnrollFrm"
					method="post">
					<div class="modal-body">	
						<div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
							<div class="carousel-inner">
								<div class="carousel-item active">
									<label for="id">아이디</label>						
									<input
										type="text" class="form-control" name="id" id="id" value="testid"
										placeholder="영문으로 시작하고 숫자포함 4~20글자 입니다." required>
									<span class="text-success guide ok">이 아이디는 사용가능합니다.</span>
									<span class="text-danger guide error">이 아이디는 사용불가능합니다.</span>
									<input type="hidden" id="idValid" value="0" />
									<br /> 
									<label for="password">비밀번호</label>
									<input
										type="password" class="form-control" name="password" id="password" value="qwer1234"
										placeholder="비밀번호는 숫자, 영어포함 8 ~ 15자리 사이 입니다." required>									
									<br /> 
									<label for="passwordCheck">비밀번호 확인</label>
									<input
										type="password" class="form-control" id="passwordCheck" value="qwer1234"
										placeholder="비밀번호 확인" required>
									<br /> 
									<label for="nickname">별명</label>
									<input type="text" class="form-control" name="nickname" id="nickname" value="qwer1234"
										placeholder="한글과 영어 숫자만 사용 가능합니다." required>
									<span class="text-success guide n-ok">사용가능한 별명입니다.</span>
									<span class="text-danger guide n-error">사용할 수 없는 별명입니다.</span>
									<input type="hidden" id="nValid" value="0" />
								</div>
								<div class="carousel-item">
									<label for="name">이름</label>
									<input
										type="text" class="form-control" name="name" id="name" value="dlfma"
										placeholder="이름" required>									
									<br /> 
									<label for="birthday">생일</label>
									<input type="date" class="form-control" name="birthday" id="birthday">
									<br />
									<label for="phone">핸드폰</label>
									<input type="tel" class="form-control" name="phone" id="phone" value="01051515151">
									<br />
									<label for="email">이메일</label>
									<input
										type="text" id="email" value="testid"
										placeholder="이메일" required>@
									<input type="text" id="selfWrite" />
									<input type="hidden" name="email" id="addEmail" required/>
									<select id="siteSelect">
										<option value="">선택</option>
										<option value="self">직접입력</option>
										<option value="naver.com" selected>네이버</option>
										<option value="gmail.com">구글</option>
									</select>
									<br /> 
									<!-- <div class="phone-wrap">
										<input type="text" />
									</div> -->									
								</div>
								<div class="carousel-item">									
									<div>
										<div class="address-wrap">
											<input type="text" id="postcode" readonly="readonly"/>
											<input type="button" class="address_button" onclick="findAddress()" value="주소검색"><br />											
											<input type="text" id="allAddress" class="form-control" readonly="readonly"/><br />
											<input type="text" id="detailAddress" class="form-control" readonly="readonly"/>
											<input type="hidden" name="address" class="form-control addAddress" required />
										</div>
										<input type="submit" class="btn btn-outline-success enroll" value="회원가입">
										<button type="button" class="btn btn-outline-danger" data-dismiss="modal">닫기</button>
									</div>
									<br />									
								</div>
								<div class="modal-footer space-between">
									<button type="button" id="prev-page" class="btn btn-info">
										<span class="carousel-control-prev-icon" aria-hidden="true"></span>
									</button>
									<button type="button" id="next-page" class="btn btn-info">
										<span class="carousel-control-next-icon" aria-hidden="false"></span>
									</button>
								</div>
							</div>
							
						</div>
						
						
					</div>
					
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</form>
			</div>
		</div>
	</div>
	
<script>
$('.carousel').carousel({
	interval: false,
	wrap: false
});

$("#prev-page").on("click", () => {
	$(".carousel").carousel('prev');
});
$("#next-page").on("click", () => {
	$(".carousel").carousel('next');
});


// 이메일
$(selfWrite).hide();

$(siteSelect).change(() => {
	if($(siteSelect).val() == 'self'){
		$(selfWrite).show();
	}else{
		$(selfWrite).hide();
	}
	
	$(addEmail).val($(email).val() + '@' + $(siteSelect).val())
	
});

$(selfWrite).blur(() => {
	$(addEmail).val($(email).val() + '@' + $(selfWrite).val());
});


// 유효성 검사
$("#memberEnrollFrm").submit((e) => {
	const $password = $(password);
	const $passwordCheck = $(passwordCheck);
	const $nickname = $(nickname);
	const $name = $(name);
	const $phone = $(phone);
	let $email = $(addEmail).val();

	// 아이디
	if($(idValid) == '0'){
		alert("사용할 수 없는 아이디 입니다.");
        return false;
	}
	
	// 별명
	if($(nValid) == '0'){
		alert("사용할 수 없는 아이디 입니다.");
        return false;
	}
	
	// 비밀번호
	if($password.val() == ''){
		alert("비밀번호를 입력해 주세요");
        return false;
	}
	if(!/^.{8,15}$/.test($password.val())){
		alert("비밀번호는 8~15자리 입니다.");
        return false;
    }
    if(!/[0-9]/.test($password.val()) || !/[a-zA-Z]/.test($password.val())){
        alert("비밀번호는 숫자와 영문이 포함되야 합니다.");
        return false;
    }
    if($password.val() != $passwordCheck.val()){
    	alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
    
    // 이름
    if($name.val() == ''){
    	alert("이름을 입력해 주세요.");
        return false;
    }
    /* if(!/^[가-힣]{2,5}$/.test($name.val())){
    	alert("이름은 한글로만 이루어져야 합니다.");
    	return false;
    } */
    
    // 핸드폰 번호
    if(!/^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/.test($phone.val())){
    	alert("잘못된 번호입니다.");
    	return false;
    }
    
    // 이메일
    if($email == ''){
    	alert("이메일을 입력해 주세요.");
    	return false;
    }
    
    return true
	
});


// 별명 중복 검사
const $nError = $(".guide.n-error");
const $nOk = $(".guide.n-ok");
$nError.hide();
$nOk.hide();
$(nickname).keyup((e) => {
	const nVal = $(e.target).val();	
	const $nValid = $(nValid);
	
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
				$nError.hide();
				$nOk.show();
				$nValid.val(1);
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
$idError.hide();
$idOk.hide();
$(id).keyup((e) => {
	const idVal = $(e.target).val();	
	const $idValid = $(idValid);
	
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
				$idError.hide();
				$idOk.show();
				$idValid.val(1);
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