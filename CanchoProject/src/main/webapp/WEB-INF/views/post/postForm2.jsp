<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Drag & Drop</title>
	
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script type="text/javascript" src="<c:url value="/resources/js/fabric.min.js" />"></script>
  <script type="text/javascript" src="<c:url value="/resources/js/fabric.js" />"></script>
  <script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js" />"></script>
  <script>
  
  	$(function(){
  	  var $ = function(id){return document.getElementById(id)};

  	  var canvas = this.__canvas = new fabric.Canvas('c', {
  	    isDrawingMode: true
  	  });

  	  fabric.Object.prototype.transparentCorners = false;

  	  var drawingModeEl = $('drawing-mode'),
  	      drawingOptionsEl = $('drawing-mode-options'),
  	      drawingColorEl = $('drawing-color'),
  	      drawingShadowColorEl = $('drawing-shadow-color'),
  	      drawingLineWidthEl = $('drawing-line-width'),
  	      drawingShadowWidth = $('drawing-shadow-width'),
  	      drawingShadowOffset = $('drawing-shadow-offset'),
  	      clearEl = $('clear-canvas');

  	  clearEl.onclick = function() { canvas.clear() };

  	  drawingModeEl.onclick = function() {
  	    canvas.isDrawingMode = !canvas.isDrawingMode;
  	    if (canvas.isDrawingMode) {
  	      drawingModeEl.innerHTML = 'Cancel drawing mode';
  	      drawingOptionsEl.style.display = '';
  	    }
  	    else {
  	      drawingModeEl.innerHTML = 'Enter drawing mode';
  	      drawingOptionsEl.style.display = 'none';
  	    }
  	  };

  	  if (fabric.PatternBrush) {
  	    var vLinePatternBrush = new fabric.PatternBrush(canvas);
  	    vLinePatternBrush.getPatternSrc = function() {

  	      var patternCanvas = fabric.document.createElement('canvas');
  	      patternCanvas.width = patternCanvas.height = 10;
  	      var ctx = patternCanvas.getContext('2d');

  	      ctx.strokeStyle = this.color;
  	      ctx.lineWidth = 5;
  	      ctx.beginPath();
  	      ctx.moveTo(0, 5);
  	      ctx.lineTo(10, 5);
  	      ctx.closePath();
  	      ctx.stroke();

  	      return patternCanvas;
  	    };

  	    var hLinePatternBrush = new fabric.PatternBrush(canvas);
  	    hLinePatternBrush.getPatternSrc = function() {

  	      var patternCanvas = fabric.document.createElement('canvas');
  	      patternCanvas.width = patternCanvas.height = 10;
  	      var ctx = patternCanvas.getContext('2d');

  	      ctx.strokeStyle = this.color;
  	      ctx.lineWidth = 5;
  	      ctx.beginPath();
  	      ctx.moveTo(5, 0);
  	      ctx.lineTo(5, 10);
  	      ctx.closePath();
  	      ctx.stroke();

  	      return patternCanvas;
  	    };

  	    var squarePatternBrush = new fabric.PatternBrush(canvas);
  	    squarePatternBrush.getPatternSrc = function() {

  	      var squareWidth = 10, squareDistance = 2;

  	      var patternCanvas = fabric.document.createElement('canvas');
  	      patternCanvas.width = patternCanvas.height = squareWidth + squareDistance;
  	      var ctx = patternCanvas.getContext('2d');

  	      ctx.fillStyle = this.color;
  	      ctx.fillRect(0, 0, squareWidth, squareWidth);

  	      return patternCanvas;
  	    };

  	    var diamondPatternBrush = new fabric.PatternBrush(canvas);
  	    diamondPatternBrush.getPatternSrc = function() {

  	      var squareWidth = 10, squareDistance = 5;
  	      var patternCanvas = fabric.document.createElement('canvas');
  	      var rect = new fabric.Rect({
  	        width: squareWidth,
  	        height: squareWidth,
  	        angle: 45,
  	        fill: this.color
  	      });

  	      var canvasWidth = rect.getBoundingRect().width;

  	      patternCanvas.width = patternCanvas.height = canvasWidth + squareDistance;
  	      rect.set({ left: canvasWidth / 2, top: canvasWidth / 2 });

  	      var ctx = patternCanvas.getContext('2d');
  	      rect.render(ctx);

  	      return patternCanvas;
  	    };

  	    var img = new Image();
  	    img.src = '../assets/honey_im_subtle.png';

  	    var texturePatternBrush = new fabric.PatternBrush(canvas);
  	    texturePatternBrush.source = img;
  	  }

  	  $('drawing-mode-selector').onchange = function() {

  	    if (this.value === 'hline') {
  	      canvas.freeDrawingBrush = vLinePatternBrush;
  	    }
  	    else if (this.value === 'vline') {
  	      canvas.freeDrawingBrush = hLinePatternBrush;
  	    }
  	    else if (this.value === 'square') {
  	      canvas.freeDrawingBrush = squarePatternBrush;
  	    }
  	    else if (this.value === 'diamond') {
  	      canvas.freeDrawingBrush = diamondPatternBrush;
  	    }
  	    else if (this.value === 'texture') {
  	      canvas.freeDrawingBrush = texturePatternBrush;
  	    }
  	    else {
  	      canvas.freeDrawingBrush = new fabric[this.value + 'Brush'](canvas);
  	    }

  	    if (canvas.freeDrawingBrush) {
  	      canvas.freeDrawingBrush.color = drawingColorEl.value;
  	      canvas.freeDrawingBrush.width = parseInt(drawingLineWidthEl.value, 10) || 1;
  	      canvas.freeDrawingBrush.shadow = new fabric.Shadow({
  	        blur: parseInt(drawingShadowWidth.value, 10) || 0,
  	        offsetX: 0,
  	        offsetY: 0,
  	        affectStroke: true,
  	        color: drawingShadowColorEl.value,
  	      });
  	    }
  	  };

  	  drawingColorEl.onchange = function() {
  	    canvas.freeDrawingBrush.color = this.value;
  	  };
  	  drawingShadowColorEl.onchange = function() {
  	    canvas.freeDrawingBrush.shadow.color = this.value;
  	  };
  	  drawingLineWidthEl.onchange = function() {
  	    canvas.freeDrawingBrush.width = parseInt(this.value, 10) || 1;
  	    this.previousSibling.innerHTML = this.value;
  	  };
  	  drawingShadowWidth.onchange = function() {
  	    canvas.freeDrawingBrush.shadow.blur = parseInt(this.value, 10) || 0;
  	    this.previousSibling.innerHTML = this.value;
  	  };
  	  drawingShadowOffset.onchange = function() {
  	    canvas.freeDrawingBrush.shadow.offsetX = parseInt(this.value, 10) || 0;
  	    canvas.freeDrawingBrush.shadow.offsetY = parseInt(this.value, 10) || 0;
  	    this.previousSibling.innerHTML = this.value;
  	  };

  	  if (canvas.freeDrawingBrush) {
  	    canvas.freeDrawingBrush.color = drawingColorEl.value;
  	    canvas.freeDrawingBrush.width = parseInt(drawingLineWidthEl.value, 10) || 1;
  	    canvas.freeDrawingBrush.shadow = new fabric.Shadow({
  	      blur: parseInt(drawingShadowWidth.value, 10) || 0,
  	      offsetX: 0,
  	      offsetY: 0,
  	      affectStroke: true,
  	      color: drawingShadowColorEl.value,
  	    });
  	  }
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
	/* //create a wrapper around native canvas element (with id="c")
	var canvas = new fabric.Canvas('c');
	
	// create a rectangle object
	var rect = new fabric.Rect({
	  left: 100,
	  top: 100,
	  fill: 'red',
	  width: 20,
	  height: 20,
	  //angle: 45
	});
	
	// "add" rectangle onto canvas
	canvas.add(rect);
	
	//Animation
	rect.set('angle', 45);
	
	rect.animate('angle', 45, {
		  onChange: canvas.renderAll.bind(canvas)
		});
	
	rect.animate('left', '+=100', { onChange: canvas.renderAll.bind(canvas) });
	
	rect.animate('angle', '-=5', { onChange: canvas.renderAll.bind(canvas) });
	
	//Color
	rect.setColor('#fff123');
	
	//Text(폰트, 사이즈, 굵기, 밑줄)
	var text = new fabric.Text('hello world', { left: 200, top: 200, fontStyle: 'italic',
		  fontFamily: 'Hoefler Text', fontSize: 40, fontWeight: 'bold', linethrough: true, shadow: 'green -5px -5px 3px'});
	//text.setColor('#fff889');
	canvas.add(text);
	
	
	
	//circle
	var circle = new fabric.Circle({
		radius: 20, fill: 'green', left: 100, top: 100
	});
	
	//triangle
	var triangle = new fabric.Triangle({
		width: 20, height: 30, fill: 'blue', left: 50, top: 50
	});

	canvas.add(circle, triangle);
	
	//삭제
	//canvas.remove(circle); 해당 객체
	//canvas.remove(canvas.item(0)); 가장 첫번째 객체
	
	//backgrond image
	canvas.setBackgroundImage('data:image/jpeg;base64,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');
	
	//image
	var imgElement = document.getElementById('my-image');
	var imgInstance = new fabric.Image(imgElement, {
	  left: 100,
	  top: 100,
	  angle: 30,
	  opacity: 0.85
	});
	canvas.add(imgInstance);
	
	//Group
	var circle1 = new fabric.Circle({
		  radius: 100,
		  fill: '#eef',
		  scaleY: 0.5,
		  originX: 'center',
		  originY: 'center'
		});

		var text1 = new fabric.Text('hello world', {
		  fontSize: 30,
		  originX: 'center',
		  originY: 'center'
		});

		var group = new fabric.Group([ circle1, text1 ], {
		  left: 150,
		  top: 100,
		  angle: -10
		});

		canvas.add(group); */
		
	
	
	
	
	
	
	
	
	
  		
  	});
  	
  	
  </script>
</head>
<body>
	
	<canvas id="c" width="700" height="500"></canvas>
	<div style="display: inline-block; margin-left: 10px">
	  	<button id="drawing-mode" class="btn btn-info">Cancel drawing mode</button><br>
	  	<button id="clear-canvas" class="btn btn-info">Clear</button><br>

 		<div id="drawing-mode-options" style="">
   			<label for="drawing-mode-selector">Mode:</label>
   			<select id="drawing-mode-selector">
			     <option>Pencil</option>
			     <option>Circle</option>
			     <option>Spray</option>
			     <option>Pattern</option>
			     <option>hline</option>
			     <option>vline</option>
			     <option>square</option>
			     <option>diamond</option>
			     <option>texture</option>
    		</select><br>

		    <label for="drawing-line-width">Line width:</label>
		    <span class="info">30</span><input type="range" value="30" min="0" max="150" id="drawing-line-width"><br>
		
		    <label for="drawing-color">Line color:</label>
		    <input type="color" value="#005E7A" id="drawing-color"><br>

		    <label for="drawing-shadow-color">Shadow color:</label>
		    <input type="color" value="#005E7A" id="drawing-shadow-color"><br>
		
		    <label for="drawing-shadow-width">Shadow width:</label>
		    <span class="info">0</span><input type="range" value="0" min="0" max="50" id="drawing-shadow-width"><br>
		
		    <label for="drawing-shadow-offset">Shadow offset:</label>
		    <span class="info">0</span><input type="range" value="0" min="0" max="50" id="drawing-shadow-offset"><br>
 	 </div>
	</div>
	
	
	
	
	<!-- <img src="resources/img/01.png" id="my-image"> -->
	
	
	
	
	
	
	
	
	
	
	

</body>
</html>