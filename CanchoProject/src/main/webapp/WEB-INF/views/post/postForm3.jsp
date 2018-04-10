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
 
 <!-- 일본어 글상자 소스 -->
 <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"></script>
 <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
 <script src="https://raw.github.com/carhartl/jquery-cookie/master/jquery.cookie.js"></script>
		
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
				height:666px;
				float:left;
				background-color:#99ffb3;
			}
					
			#div_con{
				width:1000px;
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
			
			
			
			
			.sticky {
			  width: 250px;
			  height: 50px;
			  position: absolute;
			  cursor: pointer;
			  border: 1px solid #aaa;
			}
			textarea {
			  width: 100%;
			  height: 100%;
			}
			.selected {border-color: #f44;}
		</style>
		
		<script type="text/javascript">
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
		
<script>
$(function() {
  $('#new').click(function() {
    make();
    save();
  });

  $('#del').click(function() {
    $('.selected').remove();
    save();
  });

  function make() {
    var sticky = $('<div class="sticky">Drag & Double Click!</div>');
    sticky.appendTo('#div_con')
      .css('background-color', $('#color').val())
      .draggable({stop: save})
      .dblclick(function() {
        $(this).html('<textarea>' + $(this).html() + '</textarea>')
          .children()
          .focus()
          .blur(function() {
            $(this).parent().html($(this).val());
            save();
          });
      }).mousedown(function() {
        $('.sticky').removeClass('selected');
        $(this).addClass('selected');
      });
    return sticky;
  }

  function save() {
    var items = [];
    $('.sticky').each(function() {
      items.push(
        $(this).css('left'),
        $(this).css('top'),
        $(this).css('background-color'),
        $(this).html()
      );
    });
    $.cookie('sticky', items.join('\t'), {expires: 100});
  }

  function load() {
    if (!$.cookie('sticky')) return;
    var items = $.cookie('sticky').split('\t');
    for (var i = 0; i < items.length; i += 4) {
      make().css({
        left: items[i],
        top: items[i + 1],
        backgroundColor: items[i + 2]
      }).html(items[i + 3]);
    }
  }
  load();
});
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
			    
				텍스트 박스 추가
			    <button class="myButton" onclick="add_item();">Textbox</button>
			    <br>
			    
				    텍스트 박스
				    <input id="new" type="button" value="new">
					<input id="del" type="button" value="del">
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