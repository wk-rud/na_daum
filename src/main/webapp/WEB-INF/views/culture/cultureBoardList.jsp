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
</style>
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
		
  <div class="py-5">
    <div class="container">
      <div class="row hidden-md-up">
       
        <div class="col-md-4">
          <div class="card">
            <div class="card-block">
              <h4 class="card-title">Card title</h4>
              <h6 class="card-subtitle text-muted">Support card subtitle</h6>
              <p class="card-text p-y-1">Some quick example text to build on the card title .</p>
              <a href="#" class="card-link">link</a>
              <a href="#" class="card-link">Second link</a>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card">
            <div class="card-block">
              <h4 class="card-title">Card title</h4>
              <h6 class="card-subtitle text-muted">Support card subtitle</h6>
              <p class="card-text p-y-1">Some quick example text to build on the card title .</p>
              <a href="#" class="card-link">link</a>
              <a href="#" class="card-link">Second link</a>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card">
            <div class="card-block">
              <h4 class="card-title">Card title</h4>
              <h6 class="card-subtitle text-muted">Support card subtitle</h6>
              <p class="card-text p-y-1">Some quick example text to build on the card title .</p>
              <a href="#" class="card-link">link</a>
              <a href="#" class="card-link">Second link</a>
            </div>
          </div>
        </div>
      </div><br>
      <div class="row">
      </div>
    </div>
  </div>
  </div>
</body>
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
  <script src="https://pingendo.com/assets/bootstrap/bootstrap-4.0.0-alpha.6.min.js"></script>
</html>