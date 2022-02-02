	var $contextPath = $("#contextPath").val(); //contextPath jsp에서 가져온 값(js파일에서 el을 못 씀)
	
	//csfr토큰 headers (post 전송시 필요)
	const csrfToken = $("meta[name='_csrf']").attr("content");
	const csrfHeader = $("meta[name='_csrf_header']").attr("content");
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	//차트 로딩하는 메소드
	google.charts.load('visualization', '1', {'packages':['corechart']});
	//구글 시각화 api가 로딩되면 인자로 전달된 콜백함수를 내부적으로 호출해서 차트를 그림
	google.charts.setOnLoadCallback(drawYearlyChart);
	
	//차트 그리는 함수
	function drawYearlyChart() {
		//차트에 구성되는 데이터는 [['Header','Header']['', ''], ['','']] 타입으로 배열의 배열 형식. 
		//Header는 각 배열을 설명할 수 있는 필수값. ['String', 'String']
		//json 데이터 ajax로 받아오기
		$.ajax({
			url : $contextPath+'/accountbook/detailMonthlyChart.do',
			type : "POST",
			contentType : "application/json; charset=UTF-8",
			headers : headers,
			dataType : "json",
			async : false, //ajax는 비동기 통신이기 때문에 해당 옵션을 동기식으로 변경해서 차트가 그려지기 전에 다른 작업을 못하도록 막음
			success(data) {
				let outer =[['Year-Month', '수입', '지출']];
				for(const obj in data) {
					let inner = [];
					inner.push(data[obj].monthly);
					inner.push(data[obj].income);
					inner.push(data[obj].expense);
					outer.push(inner);
				}
			var chartData = google.visualization.arrayToDataTable(outer);
			var options = { 
			//차트 상단의 제목
			title: '월별 차트',
			 //차트 크기 설정
			 width : 700,
			 height : 300
			};
			var chart = new google.visualization.LineChart(document.getElementById('yearly_chart'));
			chart.draw(chartData, options);
			}
		});
	};
	
	
	//past month
		let monthly = 0;
		function count(type) {
			if(type=="plus") {
				monthly = ++monthly;
			} else if(type=="minus") {
				monthly = --monthly;
			}
			$.ajax({
				url : $contextPath+'/accountbook/detailChart.do',
				data : monthly,
				success(data) {
					console.log(data);
				}
			})
		}
