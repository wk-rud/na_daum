<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	String nowDate = request.getParameter("date");
%>
<fmt:requestEncoding value="utf-8" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 Diary" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/diary/diaryMain.css"/> 
<div id="diaryMain-container">
	<div id="diaryYear">
		<i class="fas fa-angle-left" onclick='yearMinus()'></i>	
		<h2 id="year"><c:set var="TextValue" value="<%= nowDate %>"/>${fn:substring(TextValue,0,4)}</h2>
		<i class="fas fa-angle-right" onclick='yearPlus()'></i>
	</div>
	<div id="diaryMonth">	
		<ul id="monthUl">
			<li id="month1">1</li>
			<li>2</li>
			<li>3</li>
			<li>4</li>
			<li>5</li>
			<li>6</li>
			<li>7</li>
			<li>8</li>
			<li>9</li>
			<li>10</li>
			<li>11</li>
			<li id="month12">12</li>
		</ul>
	</div>
	<div id="diaryPreview-container">
		<div id="diaryPreviewContent">
			<div id="diaryPreview">
				<div id="diarySearch-container">
					<div class="search-box">
					    <input type="text" class="input-search" placeholder="Search...">
					    <button class="btn-search"><i class="fas fa-search"></i></button>
					</div> 	
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">+</button>
				<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h4 class="modal-title" id="exampleModalLabel">New Diary</h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				      </div>
				      <!-- 모달 -->
				      <div class="modal-body">
				        <form action="${pageContext.request.contextPath}/diary/diaryEnroll.do">			     
				          <div class="form-group">
				            <label for="recipient-name" id="emotionTitle" class="control-label">오늘의 감정을 골라보세요</label>
				            <input type="date" name="regDate" id="reg_date" />
				          </div>
				          <div class="emotionChoose">
				          	<label><input type= "radio" name="emotion" value="blanket"><div class="blanket"></div></input></label>
				          	<label><input type= "radio" name="emotion" value="daechoong"><div class="daechoong"></div></input></label>
				          	<label><input type= "radio" name="emotion" value="gogo"><div class="gogo"></div></input></label>
				          	<label><input type= "radio" name="emotion" value="happy"><div class="happy"></div></input></label>
				          	<label><input type= "radio" name="emotion" value="trash"><div class="trash"></div></input></label>
				          	<label><input type= "radio" name="emotion" value="eat"><div class="eat"></div></input></label>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				          </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					        <input type="submit" class="btn btn-primary" value="전송">
					      </div>
				        </form>
				      </div>
				      
				    </div>
				  </div>
				</div>
			</div>			
			<!-- 일기 목록 -->
			<div class="row">
			  <div class="col-4">
			    <div class="list-group" id="list-tab" role="tablist">
			    <c:forEach items="${searchList}" var="diary" varStatus="vs">
			    	<c:choose>
			    		<c:when test="${vs.first}">
					      <a class="list-group-item list-group-item-action active" id="${diary.code}-list" data-toggle="list" href="#${diary.code}" role="tab" aria-controls="${diary.code}">
					      <h4><fmt:formatDate value="${diary.regDate}" pattern="yy년 mm월 dd일 E"/>요일</h4><h5>${diary.title}</h5></a>
			    		</c:when>
			    		<c:otherwise>
					      <a class="list-group-item list-group-item-action" id="${diary.code}-list" data-toggle="list" href="#${diary.code}" role="tab" aria-controls="${diary.code}">
					      <h4><fmt:formatDate value="${diary.regDate}" pattern="yy년 mm월 dd일 E"/>요일</h4><h5>${diary.title}</h5></a>
			    		</c:otherwise>
			    	</c:choose>
				   </c:forEach>
			    </div>
			  </div>
			  <div class="col-8">
			    <div class="tab-content" id="nav-tabContent">
			    	<c:forEach items="${searchList}" var="diary" varStatus="vs">
				    	<c:choose>
				    		<c:when test="${vs.first}">
						      <div class="tab-pane fade show active" id="${diary.code}" role="tabpanel" aria-labelledby="${diary.code}-list">
						      	<div class="diaryContentTitle" onclick="location.href=`${pageContext.request.contextPath}/diary/diaryDetail.do?code=${diary.code}`">
							      	<div><h4><fmt:formatDate value="${diary.regDate}" pattern="yy년 mm월 dd일 E"/>요일</h4></div>
							      	<div>
							      		<c:choose>
										    <c:when test="${diary.isPublic eq 'Y'}">공개</c:when>
										    <c:otherwise>비공개</c:otherwise>
										</c:choose>
							      	</div>
						      	</div>
						      	<h5>${diary.title}</h5>
						      	${diary.content}
						      </div>
				    		</c:when>
				    		<c:otherwise>
						      <div class="tab-pane fade show" id="${diary.code}" role="tabpanel" aria-labelledby="${diary.code}-list">
						      	<div class="diaryContentTitle" onclick="location.href=`${pageContext.request.contextPath}/diary/diaryDetail.do?code=${diary.code}`">
							      	<div><h4><fmt:formatDate value="${diary.regDate}" pattern="yy년 mm월 dd일 E"/>요일</h4></div>
							      	<div>
							      		<c:choose>
										    <c:when test="${diary.isPublic eq 'Y'}">공개</c:when>
										    <c:otherwise>비공개</c:otherwise>
										</c:choose>
							      	</div>
						      	</div>
						      	<h5>${diary.title}</h5>
						      	${diary.content}
						      </div>
				    		</c:otherwise>
				    	</c:choose>
			    	</c:forEach>
			    </div>
			  </div>
			</div>
		</div>					
	</div>
	</div>
</div>
<script>
window.onload = function() {
	document.getElementById("reg_date").value = new Date().toISOString().substring(0, 10);
}

$('#monthUl').children('li').off().on('click', function(e) {
	var year = document.getElementById('year').innerHTML;
    var Rmonth = $(this).text();
    // 월 2자리수 변환 
    var month = Rmonth.padStart(2, '0');
    var date = year + '-' + month + '-01';
    console.log(date);
    location.href = `${pageContext.request.contextPath}/diary/diaryMain.do?date=\${date}`;
});

// 검색 창
function searchToggle(obj, evt){
    var container = $(obj).closest('.search-wrapper');
        if(!container.hasClass('active')){
            container.addClass('active');
            evt.preventDefault();
        }
        else if(container.hasClass('active') && $(obj).closest('.input-holder').length == 0){
            container.removeClass('active');
            // clear input
            container.find('.search-input').val('');
        }
}

// 년도 수정 jsp반영
var year = document.getElementById('year').innerHTML;
function yearPlus() {
    updateYear(++year);
}
function yearMinus() {
	updateYear(--year);
}
function resetCounter() {
	year = 0;
	updateYear(year);
}
// 년도 별 조회
function updateYear(val) {
    document.getElementById("year").innerHTML = val;
    let today = new Date();
    let month = today.getMonth() + 1;
    var date = val + '-' + month + '-01';

	location.href = `${pageContext.request.contextPath}/diary/diaryMain.do?date=\${date}`;
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />