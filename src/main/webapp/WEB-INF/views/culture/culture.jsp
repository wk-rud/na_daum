<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="문화" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/culture/cultureBoardList.css" />

<style>
.search-form label{
padding-right: 8px;
}
div#culture-container{width:100%; margin:0 auto;text-align:center;}
.thumnail{width: 20%; }
#culture_code{
	display:none;
}
</style>
<script>
//cultureDetail
	$(".card[data-code]").click((e) => {
		e.preventDefault();
		 //console.log(e.target); // td
		const $card = $(e.target).parent().parent();
		const code = $card.data("code");
		location.href = `${pageContext.request.contextPath}/culture/cultureDetail.do?code=\${code}`;
	});
</script>
<body>
	<div class="container">
		<div class="culture-thumnail">
			<!-- 썸네일 그림, 타이틀  -->
			<img src="${pageContext.request.contextPath}/resources/images/culture/festival.jpg" alt="문화썸네일" />
			<h1 class="title">Culture</h1>
			<form class="form-inline search-form">
				 
				  <div class="form-group">
				    <label for="Date" class="control-label">기간</label>
				    <input type="date" class="form-control" id="startDate">
				    <input type="date" class="form-control" id="endDate">
				  </div>
				  
				  <div class="form-group">
				    <label for="TRL" class="control-label">지역</label>
				      <select class="form-control" name="TRL" id="TRL">
				        <option value="1">서울</option>
				        <option value="2">경기</option>
				        <option value="3">3</option>
				        <option value="4">4</option>
				        <option value="5">5</option>
				      </select>
				  </div>
				  <div class="form-group">
				    <label for="TRL" class="control-label">장르</label>
				      <select class="form-control" name="TRL" id="TRL">
				        <option value="1">1</option>
				        <option value="2">2</option>
				        <option value="3">3</option>
				        <option value="4">4</option>
				        <option value="5">5</option>
				      </select>
				  </div>
				  <button type="submit" class="btn orange btn-default">Search</button>
			</form>
		</div>
<div id="culture-container">
    <br />
     <div class="py-5">
    <div class="container">
      <div class="row hidden-md-up">
       
     <c:forEach items="${list}" var="culture">
    	<div class="col-md-4">
          <div class="card" data-code="${culture.code}">
            <div class="card-block">
            	 <p class="card-text p-y-1" id="culture_code">${culture.code}</p>
              <h4 class="card-title">${culture.title}</h4>
              <h6 class="card-subtitle text-muted"><fmt:formatDate value="${culture.startDate}" pattern="yyyy/MM/dd"/></h6>
              <h6 class="card-subtitle text-muted"><fmt:formatDate value="${culture.endDate}" pattern="yyyy/MM/dd"/></h6>             
              <p class="card-text p-y-1">${culture.area}</p>
              <p class="card-text p-y-1">${culture.place}</p>
              <p class="card-text p-y-1">${culture.realmName}</p>
              <img class="thumnail" src="${culture.imgUrl}" alt="" />
               </div>
          </div>
        </div>
	   </c:forEach>
	    			</div>
	    		</div>
	    	</div>
		</div>
		
	</div>
</body>


  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
  <script src="https://pingendo.com/assets/bootstrap/bootstrap-4.0.0-alpha.6.min.js"></script>
</html>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
