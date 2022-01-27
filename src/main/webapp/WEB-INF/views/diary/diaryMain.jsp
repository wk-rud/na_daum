<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 Diary" name="title"/>
</jsp:include>
<style>
#diaryMain-container {backgroundColor : yellow;}
 [type=radio] { 
  position: absolute;
  opacity: 0;
  width: 0;
  height: 0;
} 
[type=radio] + div { cursor: pointer; }

[type=radio]:checked + div { height:160px; }

.form-group { 
	text-align: center; display: flex;
    flex-direction: column;
    align-items: center;
}

.emotionChoose { 
	display: flex;
    flex-wrap: wrap;
    justify-content: center;
}
.blanket{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/blanket.png");
    height:130px;
}
.daechoong{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/daechoong.png");
    height:130px;
}
.gogo{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/gogo.png");
    height:130px;
}
.happy{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/happy.png");
    height:130px;
}
.trash{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/trash.png");
    height:130px;
}
.eat{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/eat.png");
    height:130px;
}

</style>

<div id="diaryMain-container">
	<div id="diaryPreview-container">
		<div id="diarySearch-container">
			<input type="text" class="diarySearch" name="diarySearch" id="diarySearch" placeholder="검색">
			<button type="button" class="searchBtn" id="searchBtn">검색</button>		
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">+</button>
			<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h4 class="modal-title" id="exampleModalLabel">New Diary</h4>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			      </div>
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
			          	<input type="hidden" name="id" id="id" value="${loginMember.id}" />
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
		<div id="diaryPreviewContent">
			다이어리 프리뷰
		</div>
	</div>
	<div id="recentlyDiary">
		다이어리 최근 포스트
	</div>
</div>

<script>
window.onload = function() {
    //가계부 insert 모달창에 date 기본값 오늘 날짜로 뜨게 설정
    today = new Date();
    today = today.toISOString().slice(0, 10);
    bir = document.getElementById("reg_date");
    bir.value = today;
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />