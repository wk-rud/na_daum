<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="친구관리" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<br /><br /><br /><br />
<button type="button" class="btn btn-outline-warning" id="searchFriendBtn">친구검색</button>
<script>
$(searchFriendBtn).click((e) => {
	const spec = "left=500px, top=500px, width=400px, height=150px";
	const popup = open('${pageContext.request.contextPath}/member/mypage/memberFindFriend.do', '친구찾기', spec);
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>