<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js" />"></script>
		<title>회원탈퇴</title>
		<script>
			<c:if test ="${errorMsg != null}">
				alert("${errorMsg}")
			</c:if>
	
			$(function(){
				$('#deleteForm').on('submit',function(){
					var password = $('#password').val();
					
					if (password.length == 0) {
						alert("비밀번호를 입력하세요.");
						return false;
					}
				});
			});
		</script>
	</head>
	
	<body>
		<h1>회원탈퇴</h1>
		<h3>정말 탈퇴하시겠습니까? 회원탈퇴를 원하시면 비밀번호를 한 번 더 입력해주세요.</h3>
		
		<form action="deleteAccount" method="post" id="deleteForm">
			<input type="password" id="password" name="password">
			<input type="submit" value="탈퇴하기ㅠ">
		</form>
	</body>
</html>