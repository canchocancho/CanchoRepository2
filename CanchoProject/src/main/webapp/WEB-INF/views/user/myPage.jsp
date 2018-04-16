<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>[ 마이페이지 ]</title>
</head>
<body>
	<ul>
		<c:choose>
			<c:when test="${sessionScope.loginId != null }">
				<h3>${sessionScope.loginName }님의 마이페이지 </h3>
				<li><a href="">회원정보 수정</a></li>
				<li><a href="">친구리스트</a></li>
				<li><a href="">나의 쪽지함</a></li>
				<li><a href="">친구 검색</a></li>
				<li><a href="">설정(Block 기능)</a></li>
			</c:when>
		</c:choose>
	</ul>

</body>
</html>