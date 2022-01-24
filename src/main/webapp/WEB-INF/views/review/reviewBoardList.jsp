<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="문화" name="title"/>
</jsp:include>
<style>
div, section, header, aside, footer {
     padding: 0px;
}
</style>
<script>
$(() => {
	$(".card").click((e) => {
		 //console.log(e.target);
		const $card = $(e.target).parent().parent();
		const code = $card.data("code");
		location.href = `${pageContext.request.contextPath}/review/reviewDetail.do?code=\${code}`;
	});
});
</script>
<body>

<div class="container">
      <div class="row" style = "display : flex; flex-wrap : wrap;">
        <c:forEach var="review" items="${list}">
        <div class = "col-md-4 col-sm-6 card">
          <div class = "thumbnail">
            <img src = "https://images.unsplash.com/photo-1434725039720-aaad6dd32dfe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=1561ecb2592830316c279b62f1cb75e5&w=1000&q=80">
            <div class = "caption">
              <h3>${review.title}</h3>
              <span>${review.code}</span>
              <span>${review.category}</span>
              <span>${review.readCount}</span>
              <p>
              	<fmt:formatDate value="${review.regDate}" pattern="yyyy/MM/dd"/>
              </p>
          </div>
        </div>
        </div>
 		</c:forEach>
       
  </div>
</div>
</body>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
  <script src="https://pingendo.com/assets/bootstrap/bootstrap-4.0.0-alpha.6.min.js"></script>
</html>