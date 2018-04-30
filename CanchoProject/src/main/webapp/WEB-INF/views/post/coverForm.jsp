<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Make Cover</title>

		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="This is social network html5 template available in themeforest......" />
		<meta name="keywords" content="Social Network, Social Media, Make Friends, Newsfeed, Profile Page" />
		<meta name="robots" content="index, follow" />
		
		<script type="text/javascript" src="<c:url value="/resources/js/fabric.min.js" />"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/fabric.js" />"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js" />"></script>
		<script src="../resources/js/sockjs-0.3.4.js"></script>
		
		<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
		<link rel="stylesheet" href="../resources/css/style.css" />
		<link rel="stylesheet" href="../resources/css/ionicons.min.css" />
	    <link rel="stylesheet" href="../resources/css/font-awesome.min.css" />
	
	    <!--Google Font-->
	    <link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
	    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,400i,700,700i" rel="stylesheet">
	
	    <!--Favicon-->
	    <link rel="shortcut icon" type="image/png" href="../resources/images/fav.png"/>

		<script type="text/javascript" src="<c:url value="/resources/js/html2canvas.min.js" />"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/html2canvas.js" />"></script>

		<script src="http://hongru.github.io/proj/canvas2image/canvas2image.js"></script>
		<link href="https://fonts.googleapis.com/css?family=Cute+Font|Do+Hyeon|Gaegu|Gamja+Flower|Gugi|Indie+Flower|Lato|Lobster|Lora|Oswald|PT+Sans+Narrow|Roboto|Roboto+Condensed|Slabo+27px|Ubuntu" rel="stylesheet">
		
		<style>
		.myButton {
			-moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
			-webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
			box-shadow:inset 0px 1px 0px 0px #ffffff;
			background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #f9f9f9), color-stop(1, #e9e9e9));
			background:-moz-linear-gradient(top, #f9f9f9 5%, #e9e9e9 100%);
			background:-webkit-linear-gradient(top, #f9f9f9 5%, #e9e9e9 100%);
			background:-o-linear-gradient(top, #f9f9f9 5%, #e9e9e9 100%);
			background:-ms-linear-gradient(top, #f9f9f9 5%, #e9e9e9 100%);
			background:linear-gradient(to bottom, #f9f9f9 5%, #e9e9e9 100%);
			filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#f9f9f9', endColorstr='#e9e9e9',GradientType=0);
			background-color:#f9f9f9;
			-moz-border-radius:6px;
			-webkit-border-radius:6px;
			border-radius:6px;
			border:1px solid #dcdcdc;
			display:inline-block;
			cursor:pointer;
			color:#666666;
			font-family:Arial;
			font-size:12px;
			padding:6px 12px;
			text-decoration:none;
			text-shadow:0px 1px 0px #ffffff;
		}
		.myButton:hover {
			background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #e9e9e9), color-stop(1, #f9f9f9));
			background:-moz-linear-gradient(top, #e9e9e9 5%, #f9f9f9 100%);
			background:-webkit-linear-gradient(top, #e9e9e9 5%, #f9f9f9 100%);
			background:-o-linear-gradient(top, #e9e9e9 5%, #f9f9f9 100%);
			background:-ms-linear-gradient(top, #e9e9e9 5%, #f9f9f9 100%);
			background:linear-gradient(to bottom, #e9e9e9 5%, #f9f9f9 100%);
			filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#e9e9e9', endColorstr='#f9f9f9',GradientType=0);
			background-color:#e9e9e9;
		}
		.myButton:active {
			position:relative;
			top:1px;
		}
		#div_menu{
			width:250px;
			height:500px;
			float:left;
			background-color:#F6F6F6;
			margin-top: 10px;
		}		
		#div_con{
			margin-top:10px;
			width:1013px;
			height:500px;
			float:left;
		}
		.btn1 {
			  background: #a234d9;
			  background-image: -webkit-linear-gradient(top, #a234d9, #2b84b8);
			  background-image: -moz-linear-gradient(top, #a234d9, #2b84b8);
			  background-image: -ms-linear-gradient(top, #a234d9, #2b84b8);
			  background-image: -o-linear-gradient(top, #a234d9, #2b84b8);
			  background-image: linear-gradient(to bottom, #a234d9, #2b84b8);
			  -webkit-border-radius: 20;
			  -moz-border-radius: 20;
			  border-radius: 20px;
			  font-family: Arial;
			  color: #ffffff;
			  font-size: 18px;
			  padding: 5px 10px 5px 10px;
			  text-decoration: none;
			}
			
		.btn1:hover {
			  background: #3cb0fd;
			  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
			  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
			  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
			  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
			  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
			  text-decoration: none;
		}
		</style>
		
		<script type="text/javascript">
	    	  function download(){
    			var download = document.getElementById("download");
    			var image = document.getElementById("finalCover").toDataURL("image/png")
    	                    .replace("image/png", "image/octet-stream");
    				  download.setAttribute("href", image);
    		}

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
		    	      drawingShadowOffset = $('drawing-shadow-offset');
		    	      /* clearEl = $('clear-canvas'); */
		    	  
		    	  var text = $('insertText');
		    	  var uploadImage = $('imageLoader');
		    	  var tMenu = $('textmenu');
		    	  
		    	  /* clearEl.onclick = function() { canvas.clear() }; */
		    	  
		    	  var n;

		    	  drawingModeEl.onclick = function() {
		    	    canvas.isDrawingMode = !canvas.isDrawingMode;
		    	    if (canvas.isDrawingMode) {
		    	      drawingModeEl.innerHTML = 'Drawing OFF';
		    	      drawingOptionsEl.style.display = '';
		    	      text.style.display = 'none';
		    	      tMenu.style.display = 'none';
		    	      uploadImage.style.display = 'none';
		    	    }
		    	    else {
		    	      drawingModeEl.innerHTML = 'Drawing ON';
		    	      drawingOptionsEl.style.display = 'none';
		    	      text.style.display = '';
		  	  	    tMenu.style.display = '';
		  	 	   uploadImage.style.display = '';
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
		    	    img.src = '../resources/img/honey_im_subtle.jpg';

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
		    	  
		    	  //선택 삭제
		    	 $('delete').onclick = function() {
		    		 canvas.remove(canvas.getActiveObject())
				  }
		    	  
		    	  //뒤로가기
		    	 $('roll-back').onclick = function() {
		    		 n = canvas.getObjects().length;
		    		 canvas.remove(canvas.item(n-1));
		    		 n--;
				  }
		    	  
		    	  //복사
		    	  $('copy').onclick = function() {
				  		canvas.getActiveObject().clone(function(cloned) {
				  			_clipboard = cloned;
				  		});
				  	}
		    	  
		    	 //붙여넣기--
				 $('paste').onclick = function(){
				  		_clipboard.clone(function(clonedObj) {
				  			canvas.discardActiveObject();
				  			clonedObj.set({
				  				left: clonedObj.left + 10,
				  				top: clonedObj.top + 10,
				  				evented: true,
				  			});
				  			if (clonedObj.type === 'activeSelection') {
				  				clonedObj.canvas = canvas;
				  				clonedObj.forEachObject(function(obj) {
				  					canvas.add(obj);
				  				});
				  				clonedObj.setCoords();
				  			} else {
				  				canvas.add(clonedObj);
				  			}
				  			_clipboard.top += 10;
				  			_clipboard.left += 10;
				  			canvas.setActiveObject(clonedObj);
				  			canvas.requestRenderAll();
				  		});
				  	}
		    	 
		    	  //글씨체 변경
		    	  $('font-family').onchange = function(){
		    	  	 canvas.getActiveObject().set("fontFamily", this.value);
		    		 canvas.requestRenderAll();
		    	  };
		    	 
		    	  //글자 색상 변경
		    	  $('font-color').onchange = function(){
			    	  	if (this.value == 'Red') {
			    	  		 canvas.getActiveObject().set("fill", 'rgb(255,0,0)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'Orange') {
			    	  		 canvas.getActiveObject().set("fill", 'rgb(255,187,0)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'Yellow') {
			    	  		 canvas.getActiveObject().set("fill", 'rgb(255,228,0)');
				    		 canvas.requestRenderAll();
						}
			    	  	 
			    	  	if (this.value == 'Green') {
			    	  		 canvas.getActiveObject().set("fill", 'rgb(0,200,0)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'Light Blue') {
			    	  		 canvas.getActiveObject().set("fill", 'rgb(0,216,255)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'Blue') {
			    	  		 canvas.getActiveObject().set("fill", 'rgb(0,84,255)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'Purple') {
			    	  		 canvas.getActiveObject().set("fill", 'rgb(95,0,255)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'Pink') {
			    	  		 canvas.getActiveObject().set("fill", 'rgb(255,0,127)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'Black') {
			    	  		 canvas.getActiveObject().set("fill", 'rgb(0,0,0)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'White') {
			    	  		 canvas.getActiveObject().set("fill", 'rgb(255,255,255)');
				    		 canvas.requestRenderAll();
						}
			      };
		    	  
		    	  
		    	  //폰트 배경 색상 변경
		    	  $('font-background').onchange = function(){
			    	  	if (this.value == 'Red') {
			    	  		 canvas.getActiveObject().set("textBackgroundColor", 'rgb(255,0,0)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'Orange') {
			    	  		 canvas.getActiveObject().set("textBackgroundColor", 'rgb(255,187,0)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'Yellow') {
			    	  		 canvas.getActiveObject().set("textBackgroundColor", 'rgb(255,228,0)');
				    		 canvas.requestRenderAll();
						}
			    	  	 
			    	  	if (this.value == 'Green') {
			    	  		 canvas.getActiveObject().set("textBackgroundColor", 'rgb(0,200,0)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'Light Blue') {
			    	  		 canvas.getActiveObject().set("textBackgroundColor", 'rgb(0,216,255)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'Blue') {
			    	  		 canvas.getActiveObject().set("textBackgroundColor", 'rgb(0,84,255)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'Purple') {
			    	  		 canvas.getActiveObject().set("textBackgroundColor", 'rgb(95,0,255)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'Pink') {
			    	  		 canvas.getActiveObject().set("textBackgroundColor", 'rgb(255,0,127)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'Black') {
			    	  		 canvas.getActiveObject().set("textBackgroundColor", 'rgb(0,0,0)');
				    		 canvas.requestRenderAll();
						}
			    	  	
			    	  	if (this.value == 'White') {
			    	  		 canvas.getActiveObject().set("textBackgroundColor", 'rgb(255,255,255)');
				    		 canvas.requestRenderAll();
						}
			      };
		    	  
		    	  //insertText
		    	  $('insertText').onclick = function() {

		    		var textbox = new fabric.Textbox('Hello TomoLog', {
		    		  left: 50,
		    		  top: 50,
		    		  width: 150,
		    		  fontSize: 20,
		    		});
		    		canvas.add(textbox).setActiveObject(textbox);
		    		
		    		canvas.getActiveObject().set("fontFamily", 'Lobster');
		    		canvas.requestRenderAll();
		    	  }
		    	  
		    	  
		    	  $('btnComplete').onclick = function(){
		    		  
		    		  alert('아래쪽에서 완성된 커버를 확인 후 저장하세요!');

		    		    var finalCover = document.getElementById("finalCover");
		    		    
		    		    if(finalCover != null){
		    		    	finalCover.outerHTML='';
		    		    }
		    		  
			    	html2canvas(document.querySelector("#div_con")).then(canvas => {
				    		    document.body.appendChild(canvas).setAttribute("id", "finalCover");
				    	});
		    	  }
		    	  

		    	  	 //upload Image
		    		 var imageLoader = document.getElementById('imageLoader');
		    	     imageLoader.addEventListener('change', handleImage, false);
		    	 
		    	     function handleImage(e){
		    	         var reader = new FileReader();
		    	         reader.onload = function(event){
		    	        	 var img = new Image();
		    	        	 img.onload = function(){
		    	        		 var imgInstance = new fabric.Image(img)
		    	        		 canvas.add(imgInstance);
		    	        	 }
		    	        	 img.src = event.target.result;
		    	         }
		    	         reader.readAsDataURL(e.target.files[0]);
		    	     }		  
		  	});
		</script>
	</head>
	
	<body>
		<header id="header">
      <nav class="navbar navbar-default navbar-fixed-top menu">
        <div class="container">

          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href=""><img src="../resources/images/logo.png" alt="logo"></a>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            
            <a id="download" download="post_cover.png"><button class="btn btn-primary pull-right" onClick="download()" style="margin-top: 10px;">Save</button></a>
			<button class="btn btn-primary pull-right" id="btnComplete" onclick="btnComplete()" style="margin-top: 10px;">Preview</button>
			
          </div><!-- /.navbar-collapse -->
        </div><!-- /.container -->
      </nav>
    </header>

    <!-- Main content
    ================================================= -->
    <div class="error-page" style="height: 500px;">
		
		<!-- 왼쪽 도구 영역 -->
		<div id="div_menu" class="div_menu">
			<!-- 배경 버튼들 -->
			<div id="backgroundDiv">
				<h4>Select your background</h4>
				<select name="backgroundChoice" id="backgroundChoice">
					<option value="Select" selected="selected">>Select Background</option>
					<option value="1">Autumn Leaves</option>
					<option value="2">Dry Leaves</option>
					<option value="3">Blackboard</option>
					<option value="4">White Christmas</option>
					<option value="5">Christmasy Cone</option>
					<option value="6">Autumn's Gift</option>
					<option value="7">Cookie Desk</option>
					<option value="8">Ginger Cookies</option>
					<option value="9">Red Ribbon</option>
					<option value="10">Flower Drawing</option>
					<option value="11">Flower Drawing2</option>
					<option value="12">Rose Leaves</option>
					<option value="13">Simple Flower</option>
					<option value="14">Coffee Flower</option>
					<option value="15">Sparkling</option>
					<option value="16">Pink Heart</option>
					<option value="17">Poster on Wall</option>
					<option value="18">Poster with Cat</option>
					<option value="19">Pink Workspace</option>
					<option value="20">Sticky Monster</option>
					<option value="21">Pinky Desk</option>
					<option value="0">>Delete Background</option>
				</select>
			</div>
			
			<hr>
			
			<!-- 캔버스 버튼들 -->
			<div style="display: inline-block; margin-left: 10px">
			  	<button id="drawing-mode" class="btn btn-info">Drawing OFF</button><br><br>
			  	<button id="insertText" class="myButton" style="display: none;">Write Text</button>
			  	<div id="textmenu" class="controls" style="display: none;">
					<p>
						Font-family: 
						<select id="font-family">
							<option value="Select" selected="selected">Select</option>
							<option value="Roboto">Roboto</option>
							<option value="Do Hyeon">Do Hyeon</option>
							<option value="Gugi">Gugi</option>
							<option value="Lato">Lato</option>
							<option value="Lora">Lora</option>
							<option value="Oswald">Oswald</option>
							<option value="Slabo">Slabo</option>
							<option value="Cute Font">Cute Font</option>
							<option value="Ubuntu">Ubuntu</option>
							<option value="Gamja Flower">Gamja Flower</option>
							<option value="Gaegu">Gaegu</option>
							<option value="Indie Flower">Indie Flower</option>
							<option value="PT Sans Narrow">PT Sans Narrow</option>
							<option value="Lobster">Lobster</option>
						</select>
					</p>
					<p>
						Font-Color:
						<select id="font-color">
							<option value="Select" selected="selected">Select</option>
							<option value="White">White</option>
							<option value="Red">Red</option>
							<option value="Orange">Orange</option>
							<option value="Yellow">Yellow</option>
							<option value="Green">Green</option>
							<option value="Light Blue">Light Blue</option>
							<option value="Blue">Blue</option>
							<option value="Purple">Purple</option>
							<option value="Pink">Pink</option>
							<option value="Black">Black</option>
						</select>
					</p>
					<p>
						Font-Background:
						<select id="font-background">
							<option value="Select" selected="selected">Select</option>
							<option value="Red">Red</option>
							<option value="Orange">Orange</option>
							<option value="Yellow">Yellow</option>
							<option value="Green">Green</option>
							<option value="Light Blue">Light Blue</option>
							<option value="Blue">Blue</option>
							<option value="Purple">Purple</option>
							<option value="Pink">Pink</option>
							<option value="Black">Black</option>
							<option value="White">White</option>
						</select>
					</p>
					<input type="file" id="imageLoader" name="imageLoader" style="display: none;"><br>
				</div>
			  	<div class="controls" style="margin-left: 0;">
						<button id="copy" class="myButton">Copy</button>
						<button id="paste" class="myButton">Paste</button>
						<button id="delete" class="myButton">Delete</button>
						<button id="roll-back" class="myButton">Back</button>
				</div>
		 		<div id="drawing-mode-options" style="margin-top: 20px;">
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
		    		</select>
					<br>
					
				    <label for="drawing-color">Line color:</label>
				    <input type="color" value="#005E7A" id="drawing-color"><br>
					
				    <label for="drawing-line-width">Line width:</label>
				    <span class="info">10</span><input type="range" value="10" min="0" max="150" id="drawing-line-width">

				    <label for="drawing-shadow-color">Shadow color:</label>
				    <input type="color" value="#005E7A" id="drawing-shadow-color"><br>
				
				    <label for="drawing-shadow-width">Shadow width:</label>
				    <span class="info">0</span><input type="range" value="0" min="0" max="50" id="drawing-shadow-width">
				
				    <label for="drawing-shadow-offset">Shadow offset:</label>
				    <span class="info">0</span><input type="range" value="0" min="0" max="50" id="drawing-shadow-offset">
		 	 </div>
			</div>
		</div>
		
		<!-- 내용(표지 부분) 영역 -->
		<div id="div_con" class="div_con">
			<!-- 캔버스 -->
			<canvas id="c" width="1013" height="500"></canvas>
 		</div>
 		   
    </div>

    <!-- Footer
    ================================================= -->
    <footer id="footer">
      
      <div class="copyright">
        <p>Tomo Log @2018. All rights reserved</p>
      </div>
	</footer>
    
    <!--preloader-->
    <div id="spinner-wrapper">
      <div class="spinner"></div>
    </div>
    
    <!-- Scripts
    ================================================= -->
    <script src="../resources/js/jquery-3.1.1.min.js"></script>
    <script src="../resources/js/bootstrap.min.js"></script>
    <script src="../resources/js/script.js"></script>
    <script>
	 //배경 변경
	 $("#backgroundChoice").on("change", function(){
 	  	if (this.value == '1') {
 	  		document.getElementById("c").style.background = "url(../resources/img/autumn.jpg)";
		}
 	  	if (this.value == '2') {
 	  		document.getElementById("c").style.background = "url(../resources/img/autumn2.jpg)";
		}
 	  	if (this.value == '3') {
 	  		document.getElementById("c").style.background = "url(../resources/img/blackboard.jpg)";
		}
 	  	if (this.value == '4') {
 	  		document.getElementById("c").style.background = "url(../resources/img/christmas.jpg)";
		}
 	  	if (this.value == '5') {
 	  		document.getElementById("c").style.background = "url(../resources/img/christmas2.jpg)";
		}
 	  	if (this.value == '6') {
 	  		document.getElementById("c").style.background = "url(../resources/img/christmas3.jpg)";
		}
 	  	if (this.value == '7') {
 	  		document.getElementById("c").style.background = "url(../resources/img/christmas4.jpg)";
		}
 	  	if (this.value == '8') {
 	  		document.getElementById("c").style.background = "url(../resources/img/christmas5.jpg)";
		}
 	  	if (this.value == '9') {
 	  		document.getElementById("c").style.background = "url(../resources/img/christmas6.jpg)";
		}
 	  	if (this.value == '10') {
 	  		document.getElementById("c").style.background = "url(../resources/img/flower.jpg)";
		}
 	  	if (this.value == '11') {
 	  		document.getElementById("c").style.background = "url(../resources/img/flower2.jpg)";
		}
 	  	if (this.value == '12') {
 	  		document.getElementById("c").style.background = "url(../resources/img/flower3.jpg)";
		}
 	  	if (this.value == '13') {
 	  		document.getElementById("c").style.background = "url(../resources/img/flower4.jpg)";
		}
 	  	if (this.value == '14') {
 	  		document.getElementById("c").style.background = "url(../resources/img/notebook.jpg)";
		}
 	  	if (this.value == '15') {
 	  		document.getElementById("c").style.background = "url(../resources/img/pattern.jpg)";
		}
 	  	if (this.value == '16') {
 	  		document.getElementById("c").style.background = "url(../resources/img/pattern2.jpg)";
		}
 	  	if (this.value == '17') {
 	  		document.getElementById("c").style.background = "url(../resources/img/poster.jpg)";
		}
 	  	if (this.value == '18') {
 	  		document.getElementById("c").style.background = "url(../resources/img/poster2.jpg)";
		}
 	  	if (this.value == '19') {
 	  		document.getElementById("c").style.background = "url(../resources/img/workplace.jpg)";
		}
 	  	if (this.value == '20') {
 	  		document.getElementById("c").style.background = "url(../resources/img/workplace2.jpg)";
		}
 	  	if (this.value == '21') {
 	  		document.getElementById("c").style.background = "url(../resources/img/workplace3.jpg)";
		}
 	  	if (this.value == '0') {
 	  		document.getElementById("c").style.background = "";
		}
	 });
    </script>
	</body>
</html>