<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js" />"></script>
		<title>계정 복구</title>
		<script type="text/javascript">

			<c:if test="${errorMsg !=null }">
	   		alert('${errorMsg }');
	 	  	</c:if>
	
			function formCheck(){
				var id = document.getElementById('user_id');
				var password = document.getElementById('user_password');
				
				if (id.value == "") {
					alert("아이디를 입력해주세요");
					return false;
				} else if (password.value == ""){
					alert("비밀번호를 입력해주세요");
					return false;
				}
			}
		</script>
	</head>
	
	<body>
		<h1>휴면 계정 복구</h1>
		
		<form action="activate" method="post" onsubmit="return formCheck();">
			<table>
				<tr>
					<th>ID</th>
					<td><input type="text" name="user_id" id="user_id" autocomplete="off"></td>
				</tr>
				<tr>
					<th>Password</th>
					<td><input type="password" name="user_password" id="user_password"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="계정 복구하기"></td>
				</tr>
			</table>
		</form>
	</body>
</html>