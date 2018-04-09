<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>POST3</title>
		
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.8.23/jquery-ui.min.js"></script>
		
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
				/* background-color:#99b3ff; */
			}
			
			.myButton {
				-moz-box-shadow:inset 0px 39px 0px -24px #e67a73;
				-webkit-box-shadow:inset 0px 39px 0px -24px #e67a73;
				box-shadow:inset 0px 39px 0px -24px #e67a73;
				background-color:#e4685d;
				-moz-border-radius:4px;
				-webkit-border-radius:4px;
				border-radius:4px;
				border:1px solid #ffffff;
				display:inline-block;
				cursor:pointer;
				color:#ffffff;
				font-family:Arial;
				font-size:15px;
				padding:6px 15px;
				text-decoration:none;
				text-shadow:0px 1px 0px #b23e35;
			}
			.myButton:hover {
				background-color:#eb675e;
			}
			.myButton:active {
				position:relative;
				top:1px;
			}
			
			.text_box {
			  width:auto;
			  height:auto;
			  border:0;
			  background:transparent;
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
		
		<script type="text/javascript">
			function changebg(){
				var div_con = document.getElementById("div_con");
				div_con.style.backgroundColor= "#ffccff";
			}
			
		    function add_item(){
		        var div = document.createElement('div');
		        div.innerHTML = document.getElementById('pre_set').innerHTML;
		        document.getElementById('div_con').appendChild(div);
		    }
		 
/* 		    function remove_item(obj){
		        document.getElementById('div_con').removeChild(obj.parentNode);
		    } */
		</script>
	</head>
	
	<body>
		<!-- 맨 위 메뉴 바 부분 -->
		<div id="div_root">

		</div>
		
		<!-- 편집 메뉴 영역 -->
		<div id="div_top">
				백그라운드 색상 변경
			    <button class="myButton" onclick="changebg();">Babypink</button><br>
			    
				텍스트 박스 추가
			    <button class="myButton" onclick="add_item();">Textbox</button>
		</div>
		
		<!-- 왼쪽 도구 영역 -->
		<div id="div_menu" class="div_menu">

		</div>
		
		<!-- 내용(표지 부분) 영역 -->
		<div id="div_con" class="div_con">
				<div class="post">
					<p>글을 써보세요.</p>
				</div>
		</div>
		
		<!-- 텍스트 박스 -->
		<div id="pre_set" style="display:none">
			<div class="post">
				<p>글을 써보세요.</p>
			</div>
		</div>

		<script>
	    $(".post").draggable({
			cursor:"move",
			stack:".post",
			opacity:0.8,
			containment:'parent'
		});

		$(".post").bind("dragstart",function(event, ui){
			$(this).addClass("color");
		});
		$(".post").bind("dragstop", function(event, ui){
			$(this).removeClass("color");
		});
		</script>

	</body>
</html>