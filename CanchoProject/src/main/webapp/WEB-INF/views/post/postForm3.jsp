<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>POST3</title>
		<link rel="stylesheet" href="../resources/css/postform2.css" />
		
		<style>
			.dropbtn {
			    background-color: #4CAF50;
			    color: white;
			    padding: 16px;
			    font-size: 16px;
			    border: none;
			    cursor: pointer;
			}
			
			/* The container <div> - needed to position the dropdown content */
			.dropdown {
			    position: relative;
			    display: inline-block;
			}
			
			/* Dropdown Content (Hidden by Default) */
			.dropdown-content {
			    display: none;
			    position: absolute;
			    background-color: #f9f9f9;
			    min-width: 160px;
			    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
			    z-index: 1;
			}
			
			/* Links inside the dropdown */
			.dropdown-content a {
			    color: black;
			    padding: 12px 16px;
			    text-decoration: none;
			    display: block;
			}
			
			/* Change color of dropdown links on hover */
			.dropdown-content a:hover {background-color: #f1f1f1}
			
			/* Show the dropdown menu on hover */
			.dropdown:hover .dropdown-content {
			    display: block;
			}
			
			/* Change the background color of the dropdown button when the dropdown content is shown */
			.dropdown:hover .dropbtn {
			    background-color: #3e8e41;
			}
		</style>
		
		<script type="text/javascript">
			function bgtobabypink(){
				document.getElementById("div_con").style.backgroundColor = "#ffccff";
			}
		</script>
	</head>
	
	<body>

		<!-- 맨 위 메뉴 바 부분 -->
		<div id="div_root">

		</div>
		
		<!-- 편집 메뉴 영역 -->
		<div id="div_top">
			<div class="dropdown">
			  <button class="dropbtn">Background</button>
			  <div class="dropdown-content">
			    <a href="" onclick="bgtobabypink()">Babypink</a>
			    <a href="" onclick="bgtomint()">Mint</a>
			    <a href="" onclick="bgtopurple()">Purple</a>
			  </div>
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