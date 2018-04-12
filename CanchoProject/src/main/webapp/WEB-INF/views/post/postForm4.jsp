<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Post4</title>
		
		<script type="text/javascript" src="<c:url value="/resources/js/fabric.min.js" />"></script>
	 	<script type="text/javascript" src="<c:url value="/resources/js/fabric.js" />"></script>
	 	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js" />"></script>

		<script type="text/javascript">
		
			(function(){
				var canvas = new fabric.Canvas('c');
				
				var rect = new fabric.Rect({
					left: 100,
					top:100,
					fill:'red',
					width:20,
					height:20
				});
				
				canvas.add(rect);
			});
		</script>
	</head>
	
	<body>
	
	<canvas id="c" width="500" height="500" style="border:1px solid #ccc"></canvas>
	
	<script>
	var canvas = this.__canvas = new fabric.Canvas('c');
	// create a rectangle object
	var rect = new fabric.Rect({
		left: 100,
		top: 50,
		fill: '#D81B60',
		width: 100,
		height: 100,
		strokeWidth: 2,
		stroke: "#880E4F",
		rx: 10,
		ry: 10,
		angle: 45,
		hasControls: true
	});
	</script>
	
	</body>
</html>