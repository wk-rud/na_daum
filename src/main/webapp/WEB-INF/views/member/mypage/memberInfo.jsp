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
<title>나:다움 도움말</title>
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

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- bootstrap css -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/profile.css" />
</head>
<body>
	<header class="info-header">		
		<div class="info-search">
			<div class="input-group mb-3 info-head-wrap">
				<div class="input-group-prepend">
					<button id="info-search-help-start" class="btn btn-outline-secondary" type="button">검색</button>
				</div>
				<input id="infosearchHelp" type="text" name="title" class="form-control" required placeholder="질문을 검색해보세요." aria-label="" aria-describedby="basic-addon1">
			</div>
		</div>
		<div class="info-search-result-list">
			<ul id="info-search-result-ul" class="list-group list-group-flush"></ul>
		</div>
	</header>
	<div class="info-body">
		<div class="info-body-title">
			<span>주요 질문들</span>
		</div>
		<ul id="info-search-result-ul" class="list-group list-group-flush">
			<c:forEach items="${mostHelps}" var="help">
				<a target="_top" href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=${help.code}" class="list-group-item list-group-item-action">
					${help.title}
				</a>
			</c:forEach>
		</ul>
	</div>
	<footer class="info-footer">
		<button type="button" class="btn btn-outline-secondary" onclick="parent.location.href='${pageContext.request.contextPath}/member/mypage/memberHelpEnroll.do'">질문하기</button>
	</footer>
	
	
	<script>
	$("#info-search-help-start").click((e) => {
		if($("#infosearchHelp").val() == ''){
			alert("질문을 입력해 주세요.");
			return false;
		}
		let title = $("#infosearchHelp").val();
		$.ajax({
			url: `${pageContext.request.contextPath}/member/mypage/searchStart.do?title=\${title}`,
			success(resp){
				const $resultListUl = $(".info-search-result-list").find('ul');
				$resultListUl.empty();
				let resultList = '';
				if(resp == '0'){
					resultList = `<li class="list-group-item">그런 질문은 없어요.</li>`;
					$resultListUl.append(resultList);	
				}else{
					$(resp).each((i, {CODE, ID, CATEGORY, TITLE, REGDATE, STATUS}) => {
						console.log(i,CODE, ID, CATEGORY, TITLE, REGDATE, STATUS);
						
						let d = new Date(REGDATE);
						let date = `\${d.getFullYear()}.\${d.getMonth() + 1}.\${d.getDate()}`;
						let answer = '';
						if(STATUS == 'T')
							answer = '답변완료';
						else
							answer = '답변대기중';
						
						resultList = `
						<li class="list-group-item"><div class="result-box"><div class="result-title">\${TITLE}</div><div class="result-answer"> - \${answer}</div><div class="result-date">\${date}</div><input type="hidden" name="code" value="\${CODE}" /></input></div></li>
						`;
						
						$resultListUl.append(resultList);
					});
				}
				
				
			},
			error: console.log
		});
		
		$("#info-search-result-ul").click((e) => {
			const selectCode = $(e.currentTarget).find('input[name=code]').val();
			console.log(selectCode);
			if(typeof selectCode != 'undefined')
				parent.location.href=`${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=\${selectCode}`;
		});
		
	});

	$(() => {
		$("#infosearchHelp").autocomplete({
			source: function(request, response){
				$.ajax({
					url: "${pageContext.request.contextPath}/member/mypage/searchHelpTitle.do",
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
	</script>
</body>
</html>