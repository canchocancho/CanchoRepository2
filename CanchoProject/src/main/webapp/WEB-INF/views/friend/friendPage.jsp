<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>[ 친구페이지 ]</title>
</head>
<body>
	<ul>
		<c:choose>
			<c:when test="${sessionScope.loginId != null }">
				<h3>${sessionScope.loginName }님의 친구 페이지</h3>
				<li><a href="">친구 검색</a></li>
				<li><a href="">친구 설정</a></li>
			</c:when>
		</c:choose>
	</ul>
	
	<!-- 친구목록 -->
	

</body>
</html>