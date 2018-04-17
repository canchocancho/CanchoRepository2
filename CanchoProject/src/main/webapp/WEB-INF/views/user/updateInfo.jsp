<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>[ 회원정보 수정 ]</title>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js" />"></script>
<script type="text/javascript">
	<c:if test ="${errorMsg != null}">
		alert("${errorMsg}");
	</c:if>
	
	
	$(function(){
		
		//유효성 검사
		$('#u1').on('submit',function(){
			var password = $('#user_password').val();
			var password2 = $('#password2').val();
			var name =  $('#user_name').val();
			var email = $('#user_email').val();
			
			if (password.length == 0) {
				alert("비밀번호를 입력하세요");
				return false;
			} else if (password2.length == 0) {
				alert("비밀번호 확인값을 입력하세요");
				return false;
			} else if (password != password2) {
				alert("동일한 비밀번호를 입력하세요");
				return false;
			} else if (name.length == 0) {
				alert("이름을 입력하세요");
				return false;
			} else if (email.length == 0) {
				alert("이메일을 입력하세요");
				return false;
			}
		});
	});
</script>

</head>
<body>
	<form action="update" method="post" onsubmit="return formCheck();" id="u1">
			<table>
				<tr>
					<th>ID</th>
					<td>
						${user.user_id }
						<input type="hidden" id="userid" name="userid" value="${user.user_id }" >
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="user_password" id="user_password" placeholder="비밀번호 입력"><br>
						<input type="password" id="password2" placeholder="비밀번호 다시 입력">
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="user_name" id="user_name" value="${user.user_name }">
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" name="user_email" id="user_email" value="${user.user_email }">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="수정">  <input type="reset" value="다시 쓰기"></td>
				</tr>
			</table>
		</form>
	
	

</body>
</html>