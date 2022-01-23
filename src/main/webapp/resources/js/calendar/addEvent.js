var eventModal = $('#eventModal');

var modalTitle = $('.modal-title');
var editAllDay = $('#edit-allDay');
var editTitle = $('#edit-title');
var editStart = $('#edit-start');
var editEnd = $('#edit-end');
var editType = $('#edit-type');
var editColor = $('#edit-color');
var editDesc = $('#edit-desc');
var id = $('#id').val();

var addBtnContainer = $('.modalBtnContainer-addEvent');
var modifyBtnContainer = $('.modalBtnContainer-modifyEvent');


/* ****************
 *  새로운 일정 생성
 * ************** */

var newEvent = function (start, end, eventType) {

    $("#contextMenu").hide(); //메뉴 숨김

    modalTitle.html('새로운 일정');
    editType.val(eventType).prop('selected', true);
    editTitle.val('');
    editStart.val(start);
    editEnd.val(end);
    editDesc.val('');
    
    addBtnContainer.show();
    modifyBtnContainer.hide();
    eventModal.modal('show');

    //새로운 일정 저장버튼 클릭
    $('#save-event').unbind();
    $('#save-event').on('click', function () {

		var eventData = {
			"id" : id,
			title : editTitle.val(),
			start : editStart.val(),
			end : editEnd.val(),
			description : editDesc.val(),
			type : editType.val(),
			username : '',
			backgroundColor : editColor.val(),
			textColor : '#ffffff',
			allDay : ''
		};


        if (eventData.start > eventData.end) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (eventData.title === '') {
            alert('일정명은 필수입니다.');
            return false;
        }

        var realEndDay;

        if (editAllDay.is(':checked')) {
            eventData.start = moment(eventData.start).format('YYYY-MM-DD');
            //render시 날짜표기수정
            eventData.end = moment(eventData.end).add(1, 'days').format('YYYY-MM-DD');
            //DB에 넣을때(선택)
            realEndDay = moment(eventData.end).format('YYYY-MM-DD');

            eventData.allDay = 1;
        }

        $("#calendar").fullCalendar('renderEvent', eventData, true);
        eventModal.find('input, textarea').val('');
        editAllDay.prop('checked', false);
        eventModal.modal('hide');

		// 403에러방지 csrf토큰 headers
		const csrfToken = $("meta[name='_csrf']").attr("content");
		const csrfHeader = $("meta[name='_csrf_header']").attr("content");
		const headers = {};
		headers[csrfHeader] = csrfToken;
		//console.log(headers);
		
        //새로운 일정 저장
        $.ajax({
            type: "post",
			headers: headers,
            url: "/nadaum/calendar/addCalendar.do",
			dataType: "json",
			contentType: "application/json",
            data: JSON.stringify(
				eventData
			),
            success: function (response) {
				console.log("캘린더 등록");
				console.log(response);
                //DB연동시 중복이벤트 방지
                $('#calendar').fullCalendar('removeEvents');
                $('#calendar').fullCalendar('refetchEvents');
            },
			error: function(response){
				console.log(response);
				console.log("캘린더 등록 실패");
			}
        });
    });
};