<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Example :: Movie Masher</title>
    
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="resources/vendor/jquery/jquery-ui-1.12.1/jquery-ui.css">
	<link rel="stylesheet" href="resources/vendor/metisMenu/metisMenu.min.css">
	<link rel="stylesheet" href="resources/vendor/w2ui/w2ui-1.5.rc1.min.css" type="text/css">
	<link rel="stylesheet"  href="resources/vendor/font-awesome/css/font-awesome.min.css" type="text/css">
	<link rel="stylesheet" href="resources/vendor/zTree/css/awesomeStyle/awesome.css" type="text/css">
	<!-- <link rel="stylesheet" href="resources/css/editor/editor.css" type="text/css"> -->
	<link href="resources/vendor/colorBox/colorbox.css" rel="stylesh1eet">
	<link href="resources/css/editor/cancho_editor.css" rel="stylesheet" type="text/css">
	<!-- <link rel="stylesheet" href="resources/css/bootstrap.min.css" /> -->
	<link rel="stylesheet" href="resources/css/style.css" />
<!-- 	<link rel="stylesheet" href="resources/css/ionicons.min.css" /> -->
	
	
	
	<script type="text/javascript" src="resources/vendor/jquery/jquery.js"></script>
	<script type="text/javascript" src="resources/vendor/jquery/jquery-ui-1.12.1/jquery-ui.js"></script>
	
	<script type="text/javascript" src="resources/vendor/w2ui/w2ui-1.5.rc1.min.js"></script>
	<script type="text/javascript" src="resources/vendor/metisMenu/metisMenu.min.js"></script>
	<script type="text/javascript" src="resources/vendor/zTree/js/jquery.ztree.all.min.js"></script>
	<script type="text/javascript" src="resources/vendor/colorBox/jquery.colorbox-min.js"></script>
    
    <script src="resources/vendor/moviemasher/bower_components/opentype.js/dist/opentype.min.js"></script>
    <script src="resources/vendor/moviemasher/bower_components/script.js/dist/script.min.js"></script>
    <script src="resources/vendor/moviemasher/src/moviemasher.js"></script>
    <script src="resources/vendor/moviemasher/src/others/action.js"></script>
    <script src="resources/vendor/moviemasher/src/others/audio.js"></script>
    <script src="resources/vendor/moviemasher/src/others/constant.js"></script>
    <script src="resources/vendor/moviemasher/src/others/defaults.js"></script>
    <script src="resources/vendor/moviemasher/src/others/filter.js"></script>
    <script src="resources/vendor/moviemasher/src/others/loader.js"></script>
    <script src="resources/vendor/moviemasher/src/others/mash.js"></script>
    <script src="resources/vendor/moviemasher/src/others/option.js"></script>
    <script src="resources/vendor/moviemasher/src/others/player.js"></script>
    <script src="resources/vendor/moviemasher/src/others/players.js"></script>
    <script src="resources/vendor/moviemasher/src/others/time.js"></script>
    <script src="resources/vendor/moviemasher/src/others/util.js"></script>
    
    <script src="resources/js/editor/app.js"></script>
    <script src="resources/js/editor/editor.js"></script>
    <script src="resources/js/editor/videoSlider.js"></script>
    <!-- <style>canvas, textarea { width: 320px; height: 240px; }</style> -->
  </head> 
  <body onload='mm_load()'>
	<div id="upperContainer">  
		<div id ="playerContainer">
	    	<div id="playerBox">
		    	<canvas id='mm-canvas'></canvas>
		    </div>
		    <div id="range-and-btn">
			    <div id="player-slider">    
			    	<input type= "range" id="p-slider" step= "0.001" value="0" min="0" max="1" oninput="sliderSyncro('pslider')"/>
			    </div>
			    	
			    <div id="player-btns">
			      	<img src="resources/images/playCon.png" onclick="mm_player.paused = false" width="30px" height="30px">
			      	<img src="resources/images/pauseCon.png" onclick="mm_player.paused = true" width="30px" height="30px">
			    </div>
		    </div>
    	</div>
    	<div id ="uploadContainer">
			<input type="file" id="upload" name="file-data">			
			<input class="btn-primary" type="button" id="imgBtn" value="upload">
		
			
				<select id="selectedFile">
					<option>Video</option>
					<option>Image</option>
					<option>Audio</option>
				</select>
				<div id="fileBox">
					<div id="fileListBox">
					</div>
				</div>
			
		</div>    
    </div>
   	<!-- div id="middle"></div> -->
   	<div id="downContainer">
	   	<div id = "timeLine">
	   		<div id="all-tracks-container">
				<span style="padding-left:33px"></span>
				<span class='fslider'>
					<input type='range' id='t-slider' step='0.001' value='0' min='0' max='1' oninput='sliderSyncro("tslider")' />
				</span>
				<div>
					<div class="main-track ui-state-default" id="video-track">
						<span class="track-name">
							<!-- <i id="cameraCon" class="fa fa-video-camera" aria-hidden="true"></i> -->
						</span>
					</div>
				</div>
				<div>
					<div  class="odd-track-container" id="video-1-cont" >
						<span class="track-name">
						</span>
						<div class="track-odd other-track" id="video-1">
						</div>
					</div>
				</div>	
				<div>
					<div class="even-track-container" id="audio-1-cont">
						<span class="track-name">
						</span>
						<div class="track-even other-track" id="audio-1">
						</div>
					</div>
				</div>
				<div>
					<div class="odd-track-container" id="video-2-cont">
						<span class="track-name">
						</span>
						<div class="track-odd other-track" id="video-2">
						</div>
					</div>
				</div>
				<div>
					<div class="even-track-container" id="audio-2-cont">
						<span class="track-name">
						</span>
						<div class="track-even other-track" id="audio-2">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id = "volume"></div>
	</div>
<div id = "bottom">
</div>
  </body>
</html>

