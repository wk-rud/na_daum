<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/audiobook/common/audioBookHeader.jsp">
	<jsp:param value="Le Café Livres" name="title" />
</jsp:include>
<div class="col-lg-12 text-center mt-5">
	<h1>AudioBook</h1>
	
</div>
<div class="col-md-4 offset-md-4 mt-5 border border-success pt-3">
	<div class="input-group mb-3">
		<input type="text" class="form-control" placeholder="지금 뜨는 작품!"
			aria-label="Recipient's username">
		<div class="input-group-append">
			<span class="input-group-text"><i class="fa fa-search"></i></span>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />