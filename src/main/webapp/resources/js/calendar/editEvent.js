/* ****************
 *  일정 편집
 * ************** */
var editEvent = function (event, element, view) {
    $('#deleteEvent').data('id', event._id); //클릭한 이벤트 ID

    $('.popover.fade.top').remove();
    $(element).popover("hide");
	
	// 403에러방지 csrf토큰 headers
	const csrfToken = $("meta[name='_csrf']").attr("content");
	const csrfHeader = $("meta[name='_csrf_header']").attr("content");
	const headers = {};
	headers[csrfHeader] = csrfToken;


    if (event.allDay === true) {
        editAllDay.prop('checked', 1);
    } else {
        editAllDay.prop('checked', 0);
    }

    if (event.end === null) {
        event.end = event.start;
    }

    if (event.allDay === true && event.end !== event.start) {
        editEnd.val(moment(event.end).subtract(1, 'days').format('YYYY-MM-DD HH:mm'))
    } else {
        editEnd.val(event.end.format('YYYY-MM-DD HH:mm'));
    }

    modalTitle.html('일정 수정');
    editTitle.val(event.title);
    editStart.val(event.start.format('YYYY-MM-DD HH:mm'));
    editType.val(event.type);
    editDesc.val(event.description);
    editColor.val(event.backgroundColor).css('color', event.backgroundColor);

    addBtnContainer.hide();
    modifyBtnContainer.show();
    eventModal.modal('show');

    //업데이트 버튼 클릭시
    $('#updateEvent').unbind();
    $('#updateEvent').on('click', function () {

        if (editStart.val() > editEnd.val()) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (editTitle.val() === '') {
            alert('일정명은 필수입니다.')
            return false;
        }

        var statusAllDay;
        var startDate;
        var endDate;
        var displayDate;

        if (editAllDay.is(':checked')) {
            statusAllDay = true;
            startDate = moment(editStart.val()).format('YYYY-MM-DD');
            endDate = moment(editEnd.val()).format('YYYY-MM-DD');
            displayDate = moment(editEnd.val()).add(1, 'days').format('YYYY-MM-DD');
        } else {
            statusAllDay = false;
            startDate = editStart.val();
            endDate = editEnd.val();
            displayDate = endDate;
        }

        eventModal.modal('hide');

        event.allDay = statusAllDay;
        event.title = editTitle.val();
        event.start = startDate;
        event.end = displayDate;
        event.type = editType.val();
        event.backgroundColor = editColor.val();
        event.description = editDesc.val();

		var calendarDetail = {
			allDay : event.allDay,
	        title : event.title,
	        startDate : event.start,
	        endDate : event.end,
	        type : event.type, 
	        backgroundColor : event.backgroundColor,
	        content : event.description,
			no : event.id
		}		

        $("#calendar").fullCalendar('updateEvent', event);
		
        //일정 업데이트
        $.ajax({
            type: "post",
			headers: headers,
            url: "/nadaum/calendar/updateCalendar.do",
			dataType: "json",
			contentType: "application/json",
            data: JSON.stringify(calendarDetail),
            success: function (response) {
				alert("수정했습니다.");
            },
			error: function(response){
				console.log("캘린더 수정 실패");
			} 
        });

    });
	// 삭제버튼
	$('#deleteEvent').on('click', function () {
	    
	    $('#deleteEvent').unbind();
	    $("#calendar").fullCalendar('removeEvents', $(this).data('id'));
	    eventModal.modal('hide');
		var no = {no : event.id};
	    //삭제시
	    $.ajax({
	        type: "post",
			headers: headers,
	        url: "/nadaum/calendar/deleteCalendar.do",
			dataType: "json",
			contentType: "application/json",
	        data: JSON.stringify(no),
	        success: function (response) {
	            alert('삭제되었습니다.');
	        },
			error: function(response){
				console.log("캘린더 삭제 실패");
			} 
	    });
	
	});
};
