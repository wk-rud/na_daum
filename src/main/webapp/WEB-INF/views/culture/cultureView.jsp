<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<sec:authentication property="principal" var="loginMember"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판 상세보기" name="title"/>
</jsp:include>
<!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/culture/cultureDetail.css" />
 -->
 <script src="https://kit.fontawesome.com/4123702f4b.js" crossorigin="anonymous"></script>
<style>
.form-control{
display: inline-block;
}

#culture-container{
    padding: 60px;
    margin: 120px;
    background: white;
    width: 50%;
    border-radius: 5%;
    box-shadow: lightgrey 2px 10px 30px 5px;
}

}
.fa-heart{
font-size: 30px;
}
.wrap{
margin: 0 auto;
/* background-color: #FFFBF5; */
/* background-image: url("${pageContext.request.contextPath}/resources/images/culture/background.jpg") */
}
#insertCommentFrm{
text-align: center;
}
#comment-table{
    margin-left: 10%;
    width: 100%;
    margin-top: 50px;
}
#comment-delete{
	width: 30%;
}
#deleteComment-btn{
    border: 0;
    outline: 0;
    background: none;
}
.kakao-map:before{
margin: 0 auto;
}
</style>
		<div class="wrap">
	<div id="culture-container" class="mx-auto text-center">
		<!-- 상세내용 -->
		 <c:forEach var="culture" items="${list}">
			<div class="culture_detail">
			<h1 id="culture-title">${culture.title}</h1>
			
			<span><fmt:parseDate value="${culture.startDate}" var="startDateParse" pattern="yyyyMMdd"/>
			<fmt:formatDate value="${startDateParse}" pattern="yyyy년 MM월 dd일"/>
			<span>~</span>
			</span><fmt:parseDate value="${culture.endDate}" var="endDateParse" pattern="yyyyMMdd"/>
			<fmt:formatDate value="${endDateParse}" pattern="yyyy년 MM월 dd일"/>
			
			<p><img src="${culture.imgUrl}" alt="" style="width: 20%;"/></p>
			<span>${culture.area}</span>
			<span>${culture.realmName}</span>
			<br />
			<span id="placeAddr">${culture.placeAddr}</span>
			<br />
			<span>${culture.price}</span>
			<br />
			<span>${culture.placeUrl}</span>
			</div>
		</c:forEach>
		<br />
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
 		캘린더에 추가
		</button>
				<!-- Modal -->
		<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <form >
		    <div class="modal-dialog modal-dialog-centered" role="document">
		      <div class="modal-content">
		        <div class="modal-header">
		          <h5 class="modal-title" id="exampleModalCenterTitle">약 속</h5>
		          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		            <span aria-hidden="true">&times;</span>
		          </button>
		        </div>
		        <div class="modal-body">
		         <span>약속일</span>
		         <input type="date" />
		         <br />
		         <br />
		         <span>@친구</span>
		         <input type="text" />
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
		          <button type="button" class="btn btn-primary">추가</button>
		        </div>
		      </div>
		    </div>
		  </form>
		</div>
		<form id="likeFrm">
			<input type="hidden" name="apiCode" value="${apiCode}" />
			<input type="hidden" name="id" value="${loginMember.id}" />
		 	<c:if test="">
		 	
		 	</c:if><button type="submit" id="like-btn">스크랩하기</button>
		</form>
		<i class="far fa-heart"></i>
		
		
	<hr>
	<div class="kakao-map">
		<p >
		    <em class="link">
		        <a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
		        </a>
		    </em>
		</p>
		<div id="map" style="width:80%;height:400px; margin: 0 auto;"></div>
	</div>
		
	</div>
	<!-- culture-container 끝 -->
	</div>
	<div class="container">
	<hr />
	<br />
		<div class="insert-comment">
			<form id="insertCommentFrm">
				<input type="hidden" name="apiCode" value="${apiCode}"/>
	            <input type="hidden" name="id" value="${loginMember.id}" />
	            <input type="hidden" name="commentLevel" value="1" />
	            <input type="hidden" name="commentRef" value="" />    
		           <select name="star">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				<textarea name="content"class="form-control col-sm-6" rows="3" ></textarea>
	            <button type="submit" class="btn btn-light">등록</button>
			</form>
		</div>
		<table id="comment-table">
		<c:forEach var="comment" items="${commentList}">
				<tr class="level1">
					<td id="comment">
						
						<sub class="comment-writer"></sub>
						<sub class="comment-date">
						<fmt:formatDate value="${comment.regDate}" pattern="yyyy/MM/dd"/>
						</sub>
						<sub class="star">${comment.star}</sub>
						<br />
						${comment.content}
						<br />
						
				    	<%-- <form id="updateCommentFrm">
				    		<input type="hidden" name="code" value="${comment.code}"/>
				    		<input type="submit" id="updateComment-btn" value="수정" >
				    	</form>
				    	 --%>
					</td>		
					<td id="comment-delete">
						<form id="deleteCommentFrm">
							<input type="hidden" name="code" value="${comment.code}"></input>
				    		<input type="submit" id="deleteComment-btn" value="삭제" >
				    	</form>
					</td>
				</tr>
				
				</c:forEach>
				</table>
				</div>
	<script>
			//댓글 등록
			$(insertCommentFrm).submit((e) => {
				e.preventDefault();
				
				const csrfHeader = "${_csrf.headerName}";
		        const csrfToken = "${_csrf.token}";
		        const headers = {};
		        headers[csrfHeader] = csrfToken;
				$.ajax({
					headers : headers,
					url: `${pageContext.request.contextPath}/culture/board/view/${apiCode}`,
					method: "POST",
					data: $(insertCommentFrm).serialize(),
					success(resp){
						console.log(resp)
						location.reload();
						alert(resp.msg);
						
					},
					error: console.log
				});
				
			});
			
			
			
			//댓글삭제
			 $(deleteCommentFrm).submit((e) => {
				e.preventDefault();
				const code = $(e.target).find("[name=code]").val();
				console.log(code);
				
				const csrfHeader = "${_csrf.headerName}";
		        const csrfToken = "${_csrf.token}";
		        const headers = {};
		        headers[csrfHeader] = csrfToken;
				var data = {"code" : code};
		        
				$.ajax({
					url:`${pageContext.request.contextPath}/culture/board/view/${apiCode}/\${code}`,
					method: "DELETE",
					headers : headers, 
					type : "POST",
					data : JSON.stringify(data),
					success(resp){
						console.log(resp);
						location.reload();
						alert(resp.msg);
					},
					error(xhr,statusText){
						switch(xhr.status){
						case 404: alert("해당 댓글이 존재하지않습니다."); break;
						default: console.log(xhr, statusText);
						}				
					}
				});
			}); 
			$(likeFrm).submit((e) => {
				e.preventDefault();

				const csrfHeader = "${_csrf.headerName}";
		        const csrfToken = "${_csrf.token}";
		        const headers = {};
		        headers[csrfHeader] = csrfToken;
				
				$.ajax({
					url:`${pageContext.request.contextPath}/culture/board/view/${apiCode}/likes`,
					method: "POST",
					headers : headers, 
					data : $(likeFrm).serialize(),
					success(resp){
						console.log(resp);
						location.reload();
						alert(resp.msg);
					},
					error: console.log
				});
			});
			/* //댓글수정
			$(updateCommentFrm).submit((e) => {
				
				e.preventDefault();

				const csrfHeader = "${_csrf.headerName}";
		        const csrfToken = "${_csrf.token}";
		        const headers = {};
		        headers[csrfHeader] = csrfToken;
		        
				$.ajax({
					headers : headers,
					url: `${pageContext.request.contextPath}/culture/board/view/${apiCode}`,
					method: "PUT",
					data: $(updateCommentFrm).serialize(),
					success(resp){
						console.log(resp)
						location.reload();
						alert(resp.msg);
					},
					error: console.log
				});
				
			}); */
			</script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=457ac91e7faa203823d1c0761486f8d7&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

const title = $(e.target).find("[id=culture-title]").val();
const place = $(e.target).find("[id=placeAddr]").val();

console.log(title);
console.log(place);
// 주소로 좌표를 검색합니다
geocoder.addressSearch(place, function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">'
            '</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
