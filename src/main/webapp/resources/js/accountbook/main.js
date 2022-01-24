/**
 * 
 */
 
 
 /* 검색 카테고리 js*/
 
/* $(() => {
	
	var category0 = ["수입", "지출"];
	var category1 = ["급여", "용돈", "기타"];
	var category2 = ["식비", "쇼핑", "유흥", "저축", "생활비", "자기계발", "기타"];
	
	var category = [category0, category1, category2];
	
	$.each(category0, (key, value) => {
		$('#mainCategory').append($("<option></option>").attr("value", key).text(value));
	});
	
	console.log(category[0]);
	
	$("#mainCategory").change((e) => {
		let $no = Number($("#mainCategory").val() + 1);
		$("subCategory").empty();
		
		const option = `<option hidden = "" selected disabled>소분류</option>`;
		for(let i = 0; i <= category.length; i++) {
			if($no == i) {
				$("#subCategory").append(option);
				$.each(category[i], (key, value) => {
					$('#subCategory').append($("<option></option>").attr("value", key).text(value));
				}); 
			};
		};
	});
	
});*/


/*버튼 테스트*/

$("#closeBtn").on('click', function(){
	$(".modal-background").fadeOut();
});
	
$("#btn1").on('click', function(){
	$(".modal-background").fadeIn();
});

  	//ajax 로딩시 필요한 값 변수 선언
    var $id = $("#id").val();
   	var $income = $("#income").val();
	var $expense = $("#expense").val();
	
	//수입 지출 변환 함수
	function IE(x) {
		if(x == 'I')
			return "수입";
		else if(x == 'E')
			return "지출";
	}
	
	//날짜 기본값 세팅
	window.onload = function() {
		today = new Date();
		today = today.toISOString().slice(0, 10);
		bir = document.getElementById("reg_date");
		bir.value = today;
	}
    
   //가계부 리스트 조회
 	$.ajax({
		url: "/nadaum/accountbook/selectAllAccountList.do",
		type: "GET",
		data: {
			id : $id
		},
		dataType : "json",
		contentType : "application/json; charset=UTF-8",
		success : function(accountList){
			console.log(accountList);
			
			$.each(accountList, function(i, account) {
			var result = `
				<tr>
					<td rowspan="2">`+IE(`${account.incomeExpense}`)+`</td>
					<td colspan="2">${account.regDate}</td>
					<td>`+numberWithCommas(`${account.price}`)+`</td>
				</tr>		
				<tr>
					<td>${account.detail}</td>
					<td><button id="deleteBtn" onclick="deleteDetail();">삭제하기</button></td>	
					<input type="hidden" name="code" value="${account.code}" />
				</tr>
				`
			$('.account_list').append(result);
			})
			
		},
		error : function(data){
			console.log(data);
			console.log("어디가 문제일까,,,,,,,,,,,");
		}	
	});
	
	//삭제

	
	
	//원화표시 정규식
	function numberWithCommas(n) {
    	return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	//수입 지출 조회
    $.ajax({
		url: "/nadaum/accountbook/monthlyTotalIncome.do",
		type: "GET",
		data: {
			id : $id
		},
		dataType : "json",
		contentType : "application/json; charset=UTF-8",
		success(incomeList){		
			var result = `
				<td>\\<span style="color:green">`+numberWithCommas(incomeList[1].total)+`</span></td>
				<td>\\<span style="color:red">`+numberWithCommas(incomeList[0].total)+`</span></td>`	
				
			$('.user_income_expense').append(result);

		}
	});
	
    
    //이달의 총 자산
    $.ajax({
		url: "/nadaum/accountbook/monthlyAccount.do",
		type: "GET",
		data: {
			id : $id
		},
		dataType : "json",
		contentType : "application/json; charset=UTF-8",
		success(monthlyAccount){
			var result = 
					`<td colspan="2" style="font-size:40px">`+numberWithCommas(monthlyAccount)+`원 </td>`
			$('#total_income').append(result);

		}
	});

	
	//수입 필터링
	$('#income_filter_btn').click(function() {
		$.ajax({
			url : '/nadaum/accountbook/income_expense_filter.do',
			type : "GET",
			data : {
				id : $id,
				income_expense : $income
			},
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			success(incomeList) {
				console.log($id);
				console.log($income);
				console.log(incomeList);
			},
			error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}
		});
	});
	
	//지출
	$('#expense_filter_btn').click(function() {
		$.ajax({
			url : '/nadaum/accountbook/income_expense_filter.do',
			type : "GET",
			data : {
				id : $id,
				income_expense : $expense
			},
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			success(incomeList) {
				console.log($expense);
				console.log(incomeList);
			},
			error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}
		});
	});
