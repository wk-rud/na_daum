<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Dev등록" name="title" />
</jsp:include>
<br><br><br><br><br><br>
<h2>찾은사람의 정보는?</h2>
<form id="riotnick" method="GET">
	<input type="text" id="nickname" name="nickname" />
	
</form>
<button type="button" onclick="submit('riot1')">전적검색</button>

<p>${summoner.name}</p>
<img alt="아이콘" src=${ imgURL}>


<script>
const submit = (name) => {
	$(riotnick)
		.attr("action", `${pageContext.request.contextPath}/riot/\${name}.do`)
		.submit();
		
};

</script>

