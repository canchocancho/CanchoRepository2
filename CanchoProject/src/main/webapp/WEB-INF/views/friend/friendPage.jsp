<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js" />"></script>
<title>[ 친구페이지 ]</title>
<script type="text/javascript">
	<c:if test ="${errorMsg != null}">
		alert("${errorMsg}")
	</c:if> 
	
	function insertFriend(user_id){
		if (confirm("해당 ID를 친구로 추가할까요?")) {
			location.href = 'insertFriend?user_id='+ user_id;
		} else {
			return false;
		}
	}
	
	//유효성 검사
	$(function(){
		$('#s1').on('submit', function(){
			var id = $('user_id').val();
			
			if (id.length == 0) {
				alert("검색할 ID를 입력하세요");
				return;
			}
		});
	});
</script>
</head>
<body>
	<form action="searchFriendId" method="post" id="s1">
		<h3>${sessionScope.loginName }님의 친구 페이지</h3>
		<input type="text" id="user_id" name="user_id" placeholder="검색할 친구 ID">
		<input type="submit" value="검색">  <input type="reset" value="다시 쓰기">
	</form>
			
	<br>
	<a href="">친구 설정</a>
	
	<!-- 친구목록 -->
	<c:if test="${list != null }">
		<p>검색한 친구 아이디</p>
		<table>
			<c:forEach var="user" items="${list }">
				<tr>
					<td><a href="javascript:insertFriend('${user.user_id }')">${user.user_id}</a></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<br>
	
	<!-- 친구리스트 -->
	<h3>나의 친구 리스트</h3><br>
		<c:if test="${fList != null }">
			<table>
				<c:forEach var="friend" items="${fList }">
					<tr>
						<td>${friend.friend_id}</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>


</body>
</html>