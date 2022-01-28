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
<style>
#culture-container{
padding-top: 100px;
}
</style>
<section class="content">
	<div id="culture-container" class="mx-auto text-center">
		
		<!-- 상세내용 -->
		 <c:forEach var="culture" items="${list}">
			<div class="culture_detail">
			<h1>${culture.title}</h1>
			
			<span><fmt:parseDate value="${culture.startDate}" var="startDateParse" pattern="yyyyMMdd"/>
			<fmt:formatDate value="${startDateParse}" pattern="yyyy년 MM월 dd일"/>
			<span>~</span>
			</span><fmt:parseDate value="${culture.endDate}" var="endDateParse" pattern="yyyyMMdd"/>
			<fmt:formatDate value="${endDateParse}" pattern="yyyy년 MM월 dd일"/>
			
			<p><img src="${culture.imgUrl}" alt="" style="width: 20%;"/></p>
			<span>${culture.area}</span>
			<span>${culture.realmName}</span>
			<span>${culture.placeAddr}</span>
			<br />
			<span>${culture.price}</span>
			
			<span>${culture.placeUrl}</span>
			</div>
		</c:forEach>
	<!-- culture-container 끝 -->
	<hr />
<h1>댓글</h1>
	<div class="insert-comment">
		<form id="insertCommentFrm">
			<input type="hidden" name="apiCode" value="${apiCode}"/>
            <input type="hidden" name="id" value="${loginMember.id}" />
            <input type="hidden" name="commentLevel" value="1" />
            <input type="hidden" name="commentRef" value="" />    
            <input type="text" name="star" value="4" />
			<textarea name="content" cols="60" rows="3"></textarea>
            <button type="submit" class="btn btn-light">등록</button>
		</form>
	</div>
	
	<table id="comment-table">
	<c:forEach var="comment" items="${commentList}">
			<tr class="level1">
				<td id="comment">
					<input type="hidden" name="code" value="${comment.code}"></input>
					<sub class="comment-writer"></sub>
					<sub class="comment-date">
					<fmt:formatDate value="${comment.regDate}" pattern="yyyy/MM/dd"/>
					</sub>
					<sub class="star">${comment.star}</sub>
					<br />
					${comment.content}
					<br />
			    		<input type="submit" value="삭제" >
				</td>		
			</tr>
			</c:forEach>
			</table>
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
				
				$.ajax({
					url:`${pageContext.request.contextPath}/culture/board/view/${apiCode}`,
					method: "DELETE",
					success(resp){
						console.log(resp);
						alert(resp.msp);
					},
					error(xhr,statusText){
						switch(xhr.status){
						case 404: alert("해당 댓글이 존재하지않습니다."); break;
						default: console.log(xhr, statusText,err);
						}				
					}
				});
			}); 
			
			//댓글수정
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
				
			});
			</script>


<!-- kakao 지도 

	<hr style="border: solid 2px grey;">
	<div class="kakao-map">
		<p style="margin-top:-12px">
		    <em class="link">
		        <a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
		        </a>
		    </em>
		</p>
		<div id="map" style="width:80%;height:400px;"></div>
	</div>

</section>
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

// 주소로 좌표를 검색합니다
geocoder.addressSearch('서울특별시 서초구 강남대로39길 15-3 2층 301호', function(result, status) {

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
            content: '<div style="width:150px;text-align:center;padding:6px 0;">전시회</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>-->
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
