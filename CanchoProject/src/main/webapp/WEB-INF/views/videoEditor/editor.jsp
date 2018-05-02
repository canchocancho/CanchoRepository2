<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>TOMOLog</title>
    
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
   <link rel="stylesheet" href="resources/vendor/jquery/jquery-ui-1.12.1/jquery-ui.css">
   <link rel="stylesheet"  href="resources/vendor/font-awesome/css/font-awesome.min.css" type="text/css">
   <!-- <link rel="stylesheet" href="resources/css/editor/editor.css" type="text/css"> -->
   <link href="resources/vendor/colorBox/colorbox.css" rel="stylesh1eet">
   <!-- <link href="resources/css/editor/cancho_editor.css" rel="stylesheet" type="text/css"> -->
   <link href="resources/css/editor/cancho_edit.css" rel="stylesheet" type="text/css">
   <link href="resources/css/editor/cancho_edit2.css" rel="stylesheet" type="text/css">
   <!-- <link rel="stylesheet" href="resources/css/bootstrap.min.css" /> -->
   <link rel="stylesheet" href="resources/css/style.css" />
   <!--    <link rel="stylesheet" href="resources/css/ionicons.min.css" /> -->
   
   <script type="text/javascript" src="resources/vendor/jquery/jquery.js"></script>
   <script type="text/javascript" src="resources/vendor/jquery/jquery-ui-1.12.1/jquery-ui.js"></script>
   
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
    
    <script src="resources/js/timeslider.js"></script>
    <script src="resources/js/editor/app.js"></script>
    <script src="resources/js/editor/editor.js"></script>
    <script src="resources/js/editor/videoSlider.js"></script>
    
    
   
  </head> 
  <body onload='mm_load()'>
  <header>
  <nav class="navbar navbar-default navbar-fixed-top menu">
        <div class="container">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <a class="navbar-brand" href="/cancho"><img id="logologo" src="resources/images/logo.png" alt="logo" /></a>
          </div>
        </div><!-- /.container -->
      </nav>
   </header>
   <div id="upperContainer">  
      <div id ="playerContainer">
          <div id="playerBox">
             <canvas id='mm-canvas'></canvas>
          </div>
          <div id="range-and-btn">
             <div id="player-btns">
                  <img src="resources/images/playCon.png" onclick="mm_player.paused = false" width="30px" height="30px">
                  <img src="resources/images/pauseCon.png" onclick="mm_player.paused = true" width="30px" height="30px">
             
<!--              <div id="player-slider">   -->  
                <input type= 'range' id='p-slider' step= '0.001' value='0' min='0' max='1' oninput='sliderSyncro("pslider")'/>
             <!-- </div> -->
             </div>
          </div>
       </div>
       <div id ="uploadContainer">
         <div id="upperBar">
            <input type="file" id="upload" name="file-data">   
            <!-- 버튼 이미지로 바꾸 -->
            <img src="resources/images/uploadConJ.png" width="50px" height="35px" id="imgBtn">      
           <!--  <input type="button" id="imgBtn" value="upload"> -->
            <select id="selectedFile">
               <option value="video">Video</option>
               <option value="image">Image</option>
               <option value="audio">Audio</option>
            </select>
         </div>
            <div id="fileBox">
            </div>   
      </div>    
    
       <div id = "bottom">
      <!-- <button id="split">split</button>
      <button id="mute" clicked = "false"> mute</button>
      <button id="delete">delete</button>
      <button id="clear">clear</button> -->
         <table id="iconTable">
            <tr class="con_tr">
               <td class="con_td"><img src="resources/images/splitCon.png" id="split" class="bottom_cons"></td>
               <td class="con_td"><img src="resources/images/saveCon.png" id="save" clicked="false" class="bottom_cons"></td>
            </tr>
            <tr class="text_tr">
               <td class="text_td">split</td>
               <td class="text_td">save</td>
            </tr>
            <tr class="con_tr">
               <td class="con_td"><img src="resources/images/deleteCon.png" id="delete" class="bottom_cons"></td>
               <td class="con_td"><img src="resources/images/clearCon.png" id="clear" class="bottom_cons"></td>
            </tr>
            <tr class="text_tr">
               <td class="text_td">delete</td>
               <td class="text_td">clear</td>
            </tr>
            <tr id="text_tt">
            	<td colspan="2">
	            	<form action="post/write2" method="post" enctype="multipart/form-data">
						<input type="file" name="upload" accept="file_extension|audio/*|video/*|image/*|media_type">
						<input type="submit" value="POST"> 	
	   				</form>
   				</td>
            </tr>
         </table>
      </div>
   </div>
      <div id="middle"></div> 
      <div id="downContainer">
         <div id = "timeLine">
            <div id="all-tracks-container">
            <span style="padding-left:33px"></span>
            <span class='fslider'>
               <input type='range' id='t-slider' step='0.001' value='0' min='0' max='1' oninput='sliderSyncro("tslider")' />
            </span>
            <div id="firstTrack">
               <div class="main-track ui-state-default" id="video-track">
                  <div class="track-name">
                  </div>
               </div>
            </div>
            <div>
               <div  class="odd-track-container" id="image-1-cont" >
                  <div class="track-name">
                  </div>
                  <div class="track-odd other-track" id="image-1">
                  </div>
               </div>
            </div>   
            <div>
               <div class="even-track-container" id="audio-1-cont">
                  <div class="track-name">
                  </div>
                  <div class="track-even other-track" id="audio-1">
                  </div>
               </div>
            </div>
            <div>
               <div class="odd-track-container" id="image-2-cont">
                  <div class="track-name">
                  </div>
                  <div class="track-odd other-track" id="image-2">
                  </div>
               </div>
            </div>
            <div>
               <div class="even-track-container" id="audio-2-cont">
                  <div class="track-name">
                  </div>
                  <div class="track-even other-track" id="audio-2">
                  </div>
               </div>
            </div>
         </div>
      </div>
      <div id = "volume"></div>
   </div>
  </body>
</html>