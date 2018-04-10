<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>POST3</title>
		
<!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.8.23/jquery-ui.min.js"></script> -->

 <script src="https://code.jquery.com/jquery-1.8.2.js"></script>
  <script src="https://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
		
		<style>
			#div_root{
				width: 100%;
				height:50px;
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
				width:15%;
				height:666px;
				float:left;
				background-color:#99ffb3;
			}
					
			#div_con{
				width:85%;
				height:666px;
				float:left;
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
			function changebg(img){
				var div_con = document.getElementById("div_con");
				if(img == 'poster'){
					div_con.style.backgroundImage = "url(../resources/img/poster.jpg)";
				}
				if(img == 'flower'){
					div_con.style.backgroundImage = "url(../resources/img/flower.png)";
				}
				if(img == 'wall'){
					div_con.style.backgroundImage = "url(../resources/img/wall.jpg)";
				}
				if(img == 'sketchbook'){
					div_con.style.backgroundImage = "url(../resources/img/sketchbook.jpg)";
				}
				if(img == 'princess'){
					div_con.style.backgroundImage = "url(../resources/img/princess.jpg)";
				}
				if(img == 'notebook'){
					div_con.style.backgroundImage = "url(../resources/img/notebook.jpg)";
				}
			}
			
		    function add_item(){
		        var div = document.createElement('div');
		        div.innerHTML = document.getElementById('pre_set').innerHTML;
		        document.getElementById('div_con').appendChild(div);
		        
			    $(".post").draggable({
					cursor:"move",
					stack:".post",
					opacity:0.8,
					containment:"#div_con"
				});
			    
			    $("#resizable").resizable({
			    	containment:"#div_con"
			    });
		    }
		 
/* 		    function remove_item(obj){
		        document.getElementById('div_con').removeChild(obj.parentNode);
		    } */
		</script>
		
<!-- 		<script>
		$(document).ready(function(){
		    $(".post").draggable({
				cursor:"move",
				stack:".post",
				opacity:0.8,
				containment:"#div_con"
			});

 			$(".post").bind("dragstart",function(event, ui){
				$(this).addClass("color");
			});
			$(".post").bind("dragstop", function(event, ui){
				$(this).removeClass("color");
			});
		});
		</script> -->
	</head>
	
	<body>
		<!-- 맨 위 메뉴 바 부분 -->
		<div id="div_root" style="text-align: center;">
			<h3>나만의 표지를 꾸며봅시다.</h3>
		</div>
		
		<!-- 편집 메뉴 영역 -->
		<div id="div_top">
				Template Images
			    <button class="myButton" onclick="changebg('poster')">Poster</button>
			    <button class="myButton" onclick="changebg('flower')">Flower</button>
			    <button class="myButton" onclick="changebg('wall')">Wall</button>
			    <button class="myButton" onclick="changebg('sketchbook')">Sketchbook</button>
			    <button class="myButton" onclick="changebg('princess')">Princess</button>
			    <button class="myButton" onclick="changebg('notebook')">Notebook</button>
			    <br>
			    
				텍스트 박스 추가
			    <button class="myButton" onclick="add_item();">Textbox</button>
		</div>
		
		<!-- 왼쪽 도구 영역 -->
		<div id="div_menu" class="div_menu">

		</div>
		
		<!-- 내용(표지 부분) 영역 -->
		<div id="div_con" class="div_con">
				<!-- <div class="post">
					<p>글을 써보세요.</p>
				</div> -->
		</div>
		
		<!-- 텍스트 박스 -->
		<div id="pre_set" style="display:none">
			<div class="post">
				<input type="text" id="resizable" class="ui-state-active" value="This is input box"
					style="border: none; background: transparent;">
				<!-- <p>글을 써보세요.</p> -->
			</div>
		</div>

		<script>

		</script>

	</body>
</html>