<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>POST2</title>
	
	<style type="text/css">
		#div_root{
			margin: auto;
			width: 100%;
			height:100px;
			background-color:#ff9999;
		}
		
		#div_top{
			width:100%;
			height:100px;
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
	</style>
	
	<script>
	    function add_item(){
	        // pre_set 에 있는 내용을 읽어와서 처리..
	        var div = document.createElement('div');
	        div.innerHTML = document.getElementById('pre_set').innerHTML;
	        document.getElementById('field').appendChild(div);
	    }
	 
	    function remove_item(obj){
	        // obj.parentNode 를 이용하여 삭제
	        document.getElementById('field').removeChild(obj.parentNode);
	    }
	</script>

	</head>
	
	<body>
		<div id="div_root"><h1>div를 새로 파서 만들어봅니다</h1></div>
		
		<div id="div_top">

		</div>
		
		<div id="div_menu">유저리스트</div>
		
		<div id="div_con">
			<div id="pre_set" style="display:none">
			    <textarea name="" value="" style="width:200px"></textarea> <input type="button" value="삭제" onclick="remove_item(this)">
			</div>
			
			<div id="field"></div>
			 
			<input type="button" value=" 추가 " onclick="add_item()"><br>
			추가 버튼을 눌러보세요.
		</div>
	</body>
</html>