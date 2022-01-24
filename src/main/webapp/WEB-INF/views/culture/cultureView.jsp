<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판 상세보기" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/culture/cultureDetail.css" />

<style>

</style>
<section class="content">
<div id="culture-container" class="mx-auto text-center">
	
	<!-- 상세내용 -->
	 <c:forEach var="culture" items="${list}">
	<div class="culture_detail">
	<input type="text" class="form-control-" 
		   placeholder="제목" name="title" id="title" 
		   value="${culture.title}" readonly>
	<input type="text" class="form-control-" 
		   placeholder="시작 날짜" name="startDate" id="startDate" 
		   value='<fmt:parseDate value="${culture.startDate}" var="startDateParse" pattern="yyyyMMdd"/>
<fmt:formatDate value="${startDateParse}" pattern="yyyy년 MM월 dd일"/>' readonly>
	
	<input type="text" class="form-control-" 
		   placeholder="시작 날짜" name="startDate" id="startDate" 
		   value='<fmt:parseDate value="${culture.endDate}" var="endDateParse" pattern="yyyyMMdd"/>
<fmt:formatDate value="${endDateParse}" pattern="yyyy년 MM월 dd일"/>' readonly>

	<input type="image" class="form-control-" name="imgUrl" title="썸네일" id="imgUrl"
			style="width: 30%; display:flex;"
		   src="${culture.imgUrl}" readonly>
	<input type="text" class="form-control-" name="area" title="지역" id="area"
		   value="${culture.area}" readonly>
	<input type="text" class="form-control-" name="place" title="장소" id="place"
		   value="${culture.place}" readonly>
	<input type="text" class="form-control-" name="realmName" title="장르" id="genre"
		   value="${culture.realmName}" readonly>
	<input type="text" class="form-control-" name="realmName" title="장르" id="genre"
		   value="${culture.placeAddr}" readonly>
	<input type="text" class="form-control-" name="realmName" title="장르" id="genre"
		   value="${culture.price}" readonly>
	<input type="text" class="form-control-" name="realmName" title="장르" id="genre"
		   value="${culture.placeUrl}" readonly>
	
	</div>
	</c:forEach>
	<!-- culture-container 끝 -->
</div>

<!-- kakao 지도 -->

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
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
