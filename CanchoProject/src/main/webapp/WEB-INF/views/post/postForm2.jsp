<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>POST2</title>
	
	<script type="text/javascript" src="../resources/js/jquery-3.2.1.js"></script>
	<link rel="stylesheet" href="../resources/css/postform2.css" />
	
	<style type="text/css">
	    div post{
	    	width: 400px;
	    	height: 400px;
	    	background-color: lime;
	    }
	</style>
	
	<script type="text/javascript">
	    $(function(){
	    	$( '.css_test img' )
		    .draggable({
		        containment : '.css_test'
		    });
	    });
	</script>

	</head>
	
	<body>
	
		<div id="div_root">
			<h1>표지 만들기</h1>
		</div>
		
		<div id="div_top">
			<h3>메뉴 영역</h3>
		</div>
		
		<div id="div_menu">
			<h3>도구 영역</h3>
		</div>
		
		<div id="div_con" class="div_con">
			<h3>내용 부분</h3>
			
			<input type="button" value="생성" id="a" onclick="add()"/>
			<div id="new_input"></div>
			<script>
			var i = 1;
			function add() {
			    var element = document.createElement("div post");
			    element.type = 'button';
			    element.value = "a"+i;
			    element.name = "a"+i;
			    element.id = "a"+i++;
			    var foo = document.getElementById("new_input");
			    foo.appendChild(element);
			}
			</script>
			
		</div>

	</body>
</html>