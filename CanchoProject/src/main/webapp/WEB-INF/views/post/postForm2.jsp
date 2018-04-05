<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>POST2</title>
	
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/ui/1.8.23/jquery-ui.min.js"></script>
	<link rel="stylesheet" href="../resources/css/style.css">
	
	<style>
		#div_root{
			width: 100%;
			height:100px;
			float:left;
			background-color:#ff9999;
		}
		
		#div_top{
			width:100%;
			height:100px;
			float:left;
			background-color:#ffe699;
		}
		
		#div_menu{
			width:20%;
			height:500px;
			float:left;
			background-color:#99ffb3;
		}
		
		#div_con{
			width:80%;
			height:500px;
			float:left;
			background-color:#99b3ff;
		}
		
		div.post {
			float:left;
			width:150px;
			height:150px;
			padding:10px 0px 0px 20px;
			background-color:#f9d716;
			border:1px solid black;
			box-shadow:2px 2px 2px;
		}
		div.color {
			background-color:salmon;
		}
	</style>
	
	</head>
	
	<body>
	
		<div id="div_root">
			<h1>div를 새로 파서 만들어봅니다</h1>
		</div>
		
		<div id="div_top">
			<h3>메뉴 영역</h3>
		</div>
		
		<div id="div_menu">
			<h3>유저리스트</h3>
		</div>
		
		<div id="div_con" class="div_con">
		
			<div class="post">
				<p>hello</p>
			</div>
		
			<div class="post">
				<p>Lorem ipsum dolor <br> sit amet, consecteturlit. Aenean</p>    
			</div>
		
			<div class="post">
				<p>Drag me</p>
			</div>
		
			<div class="post">
				<p>What a Wonderful</p>
				<img src="http://sevensprings.dothome.co.kr/img/6.jpg" width="130" height="80">
			</div>
		
		</div>

	<script src="../resources/js/index.js"></script>
	
	</body>
</html>