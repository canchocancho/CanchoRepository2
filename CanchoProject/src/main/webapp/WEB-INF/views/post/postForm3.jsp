<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>POST3</title>

 		<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
 		<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
 		
 		<script type="text/javascript" src="../resources/js/fabric.js"></script>
 		<script type="text/javascript" src="../resources/js/fabric.min.js"></script>

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
				width:20%;
				height:600px;
				float:left;
				background-color:#99ffb3;
			}
					
			#div_con{
				width:80%;
				height:600px;
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

			/* 텍스트 div */
			.textDiv {
				padding: 20px;
			    border: 2px solid;
			    width: 200px;
			    resize: both;
			    overflow: auto;
			}
		</style>
		
		<script type="text/javascript">
		
	 		$(function() {
	 			
				$('#add').click(function() {
					addTextDiv();
			  });
	
			});
	 		
			function addTextDiv(){
			    var myDiv = $('<div id="draggableDiv" class="draggableDiv"><div id="textDiv" class="textDiv" contenteditable="true"></div></div>');
			    myDiv.appendTo('#div_con');
			}
		
			function changebg(img){
				var div_con = document.getElementById("div_con");
				if(img == 'cd'){
					div_con.style.backgroundImage = "url(../resources/img/cd.jpg)";
				}
				if(img == 'christmas'){
					div_con.style.backgroundImage = "url(../resources/img/christmas.jpg)";
				}
				if(img == 'diary'){
					div_con.style.backgroundImage = "url(../resources/img/diary.jpg)";
				}
				if(img == 'label'){
					div_con.style.backgroundImage = "url(../resources/img/label.jpg)";
				}
				if(img == 'menu'){
					div_con.style.backgroundImage = "url(../resources/img/menu.jpg)";
				}
				if(img == 'paper'){
					div_con.style.backgroundImage = "url(../resources/img/paper.jpg)";
				}
				if(img == 'poster'){
					div_con.style.backgroundImage = "url(../resources/img/poster.jpg)";
				}
			}
		</script>
	</head>
	
	<body>
		<!-- 맨 위 메뉴 바 부분 -->
		<div id="div_root" style="text-align: center;">
			<h3>나만의 표지를 꾸며봅시다.</h3>
		</div>
		
		<!-- 편집 메뉴 영역 -->
		<div id="div_top">
				Background
			    <button class="myButton" onclick="changebg('cd')">CD</button>
			    <button class="myButton" onclick="changebg('christmas')">Christmas</button>
			    <button class="myButton" onclick="changebg('diary')">Diary</button>
			    <button class="myButton" onclick="changebg('label')">Label</button>
			    <button class="myButton" onclick="changebg('menu')">Menu</button>
			    <button class="myButton" onclick="changebg('paper')">Paper</button>
			    <button class="myButton" onclick="changebg('poster')">Poster</button>
			    <br>
				
				Div Text
				<input class="myButton" id="add" type="button" value="textDiv">
				<br>
				
				<div class="buttons">
				    <input type="button" class="BOLD" value="B" onclick="document.execCommand('bold')" />
				    <input type="button" class="ITALIC" value="Italic" onclick="document.execCommand('Italic')" />
				    <input type="button" class="UNDERBAR" value="밑줄" onclick="document.execCommand('Underline')" />
				    <input type="button" class="BAR" value="취소선" onclick="document.execCommand('StrikeThrough')" />
				    <input type="button" class="aignLeft" value="왼쪽 정렬" onclick="document.execCommand('justifyleft')" />
				    <input type="button" class="aignCenter" value="가운데 정렬" onclick="document.execCommand('justifycenter')" />
				    <input type="button" class="aignRight" value="오른쪽 정렬" onclick="document.execCommand('justifyright')" />
				</div>
		</div>
		
		<!-- 왼쪽 도구 영역 -->
		<div id="div_menu" class="div_menu">

		</div>
		
		<!-- 내용(표지 부분) 영역 -->
		<div id="div_con" class="div_con">
		
		</div>
		
	</body>
</html>