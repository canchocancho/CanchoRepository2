<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>POST2</title>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js" type="text/javascript"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js" type="text/javascript"></script>

	<link rel="stylesheet" href="../resources/css/postform2.css" />
	
	<script>
		function make(){
			var img = document.createElement('img');
			img.src = '../resources/img/R1.png';
			img.style.cursor = 'pointer';
			document.getElementById('div_con').appendChild(img);
		}
	</script>
	
	<style>
		.div_con img {
       		width : 100px;
    }
	</style>
	</head>
	
	<body>

		<div id="div_root">
			<h1>표지 만들기</h1>
		</div>
		
		<div id="div_top">
			<h3>메뉴 영역</h3>
		</div>
		
		<div id="div_menu" class="div_menu">
			<h3>도구 영역</h3>
			<img alt="리락쿠마 아이콘 1" src="../resources/img/R1.png" id="R1" name="R1" onclick="make();" style="width: 100px;">
		</div>
		
		<div id="div_con" class="div_con">
			<h3>내용 부분</h3>
		</div>
		
		<script src="../resources/js/postform2.js"></script>

	</body>
</html>