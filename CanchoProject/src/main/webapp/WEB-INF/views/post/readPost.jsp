<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>READ</title>
		
		<script type="text/javascript" src="../resources/js/jquery-1.12.4.min.js"></script>

		<link rel="stylesheet" href="../resources/css/firepad.css" />
		<link rel="stylesheet" href="../resources/css/firepad_fc_fs.css" />
		
		<script type="text/javascript">
		
			<c:if test="${errorMsg != null }">
				alert('${errorMsg }');
			</c:if>
		
			function deleteCheck(){
				if(confirm("게시글을 삭제할까요?")){
					location.href = 'deletePost?post_num=${post.post_num }';
				} else {
					return false;
				}
			}
			
			function checkComment(){
				
				var comment_text = document.getElementById("comment_text");
				
				if(comment_text.value == ''){
					alert('댓글의 내용을 입력하세요.');
					return false;
				}
				
				return true;
			}
			
			function deleteComment(comment_num, post_num){
				if(confirm("댓글을 삭제할까요?")){
					location.href = 'deleteComment?comment_num='+comment_num+'&post_num='+post_num;
				} else {
					return false;
				}				
			}
			
		      function updateCommentForm(comment_num, post_num, comment_text){

		         var div = document.getElementById("div"+comment_num);
		         
		         var str = '<form id="editForm'+comment_num+'" action="updateComment" method="post">';
				 str += '<input type="text" name="comment_text" value="'+comment_text+'" autocomplete="off">';
				 
		         str += '<input type="hidden" name="comment_num" value="'+comment_num+'">';
		         str += '<input type="hidden" name="post_num" value="'+post_num+'">';
		         
		         str += '<a href="javascript:updateComment('+comment_num+')">[확인]</a>';
		         str += '<a href="javascript:commentCancel(div'+comment_num+')">[취소]</a>';
		         str += '</form>';
		         
		         div.innerHTML = str;
		         
		      }
			
			function commentCancel(div){
				div.innerHTML = "";
			}
			
			function updateComment(comment_num){

				var form = document.getElementById("editForm"+comment_num);
				form.submit();
			}			
		</script>
		
		<style>
			table{
				border-collapse: collapse;
			}
			
			table, th, td{
				text-align: center; border: 1px solid black;
			}
		</style>
	</head>
	
	<body>

	<div>${postText }</div>
	
	<br><br>
		
	<div style="text-align: center; width: 100%;">
		<form action="insertComment" method="post" onsubmit="checkComment();">
			<input type="hidden" name="post_num" value="${post.post_num }">
			댓글 : <input type="text" name="comment_text" id="comment_text">
					<input type="submit" value="작성">
		</form>
	</div>

	<br>

	<table style="margin: 0 auto;">
		<tr>
			<th>작성자</th>
			<th style="width: 300px;">내용</th>
			<th>날짜</th>
			<th></th>
		</tr>
	
		<c:forEach items="${commentList }" var="comment">
			<tr>
				<td>${comment.user_id }</td>
				<td style="text-align: left;">${comment.comment_text }</td>
				<td>${comment.comment_date }</td>
				<td>
					<c:if test="${sessionScope.loginId == comment.user_id }">
						<a href="javascript:updateCommentForm('${comment.comment_num }', '${comment.post_num }', '${comment.comment_text }')">[수정]</a>
						<a href="javascript:deleteComment('${comment.comment_num }', '${comment.post_num }')">[삭제]</a>
					</c:if>
				
				</td>
			</tr>
			<tr>
				<!-- 리플 수정 폼이 나타날 위치 -->
				<td colspan="2">
					<div id="div${comment.comment_num }"></div>
				</td>
			</tr>
		</c:forEach>

	</table>

	<br>

	<div style="text-align: center; width: 100%;">
		<c:if test="${sessionScope.loginId == post.user_id }">
			<button onclick="deleteCheck()">삭제</button>
			<a href="updatePost?post_num=${post.post_num }"><button>수정</button></a>
		</c:if>
		<a href="postList"><button>목록으로</button></a>
	</div>


	<h3>본문 수정/삭제는 아직</h3>
	</body>
</html>