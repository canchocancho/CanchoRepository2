/*jshint unused:false */
/*global MovieMasher:true*/
'use strict';
var mm_player;
var mm_init_media;
var videoTotalDuration = 0;

/**
 * MovieMasher Loader
 * Body가 실행될 때 가장 먼저 같이 실행된다.
 */
function mm_load() {
	  var canvas = document.getElementById('mm-canvas')
	  
	    var myContext = canvas.getContext('2d');
	  canvas.addEventListener( 'blargle', myHandler, false );
	  eventOnDraw( myContext, 'blargle' );
	  
	  if (canvas && MovieMasher && MovieMasher.supported) {
	    mm_player = MovieMasher.player();
	    
	    // 필터 등록
	    MovieMasher.register(MovieMasher.Constant.filter, [
	      { "id":"color", "source": "resources/vendor/moviemasher/dist/filters/color.js" },
	      { "id":"drawtext", "source": "resources/vendor/moviemasher/dist/filters/drawtext.js" },
	      { "id":"overlay", "source": "resources/vendor/moviemasher/dist/filters/overlay.js" },
	      { "id":"scale", "source": "resources/vendor/moviemasher/dist/filters/scale.js" },
	      { "id":"setsar", "source": "resources/vendor/moviemasher/dist/filters/setsar.js" }
	    ]);
	    // 폰트 등록
	    MovieMasher.register(MovieMasher.Constant.font, {
	      "label": "Blackout Two AM",
	      "id":"com.moviemasher.font.default",
	      "source": "resources/vendor/moviemasher/app/media/font/default.ttf",
	      "family":"Freemiere Mash"
	    });
	    mm_player.canvas_context = canvas.getContext('2d');
	    mm_player.mash = {};
	  }
}

function extract(data){
	var zeroPlus = '';
    $.ajax({
   		url : 'extract',
   		type : 'GET',
   		data : {
   			fileName : data
   		},
   		success : function(path) {
   			var url = path.originPath + data +'\\';
   			var duration = path.count/30
   			var zeroCount = String(path.count.toString()).length;
   			for(var i = 0; i <= zeroCount; i++){
   				zeroPlus += '0';
    		}
    		var media = {
    	    		'label': data,
   		    		'id': data,
   		    		'type': 'video', 
   		    		'url': url,
   		    		'fps': 30,
   		    		'pattern': (zeroPlus+'%.jpg'),
    	    		'duration' : duration
    	   };
    		mm_player.add(media, 'video', videoTotalDuration , 0);
    		/*isAudio ==*/
    		if(true){
    			   media = {
    					      'label': data,
    					      'type': 'audio',
    					      'id': data,
    					      'url': url + 'audio.mp3',
    					      'duration': duration,
    			  };
    			   
    			  mm_player.add(media, 'audio', videoTotalDuration , 0);
    		   }
    		  videoTotalDuration += duration;
    		  //setMash();
    		  outputVideoEditor();
    		  videoSlider();
    	},
   		error : function(e) {
   			alert("추출 실패");
   		}
   	});	
 }
//드래그 앤 드롭 이벤트
function eventOnDraw( ctx, eventName ){
	  var fireEvent = function(){
	    var evt = document.createEvent("Events");
	    evt.initEvent(eventName, true, true);
	    ctx.canvas.dispatchEvent( evt );
	  }
	  var stroke = ctx.stroke;
	  ctx.stroke = function(){
	    stroke.call(this);
	    fireEvent();
	  };
	  var fillRect = ctx.fillRect;
	  ctx.fillRect = function(x,y,w,h){
	    fillRect.call(this,x,y,w,h);
	    fireEvent();
	  };
	  var fill = ctx.fill;
	  ctx.fill = function(){
	    fill.call(this);
	    fireEvent();
	  };
}

function myHandler(){
	if(document.getElementById('t-slider') != null &&
	document.getElementById('player-slider') != null) {
		document.getElementById('t-slider').value = mm_player.position;
		document.getElementById('player-slider').value = mm_player.position;
		
		var videoTrackObjsCnt = $.makeArray($(".video-obj").map(function(){
		    return $(this).attr("frames");
		}));
		
		var maxValue = 0;
		
		for(var j = 0; j < videoTrackObjsCnt.length; j++){
			maxValue += Number(videoTrackObjsCnt[j]);
		}

		var trackArr= Object.keys(tracksDuration);
		for(var i = 0; i < trackArr.length; i++){
			if( tracksDuration[trackArr[i]] > maxValue )
				maxValue = tracksDuration[trackArr[i]];
		}	
		
		var time = maxValue * mm_player.position;
		time = time.toFixed(2);
		var tempTime = time + '';
		var tempTimeSplited = tempTime.split('.');
		var timeEnd = tempTimeSplited[1];
		var timeSec = tempTimeSplited[0] * 1;
		var timeStr = ' ';

		function plusZero(time){
			var t = time + '';
			if(t.length == 2) return t;
			else{
				return '0' + t;
			}
		}
		
		if (timeSec < 60) {
			timeStr += '00:00:' + plusZero(timeSec) + ':';
		} else if (timeSec < 3600){
			timeStr += '00:' + plusZero(Math.floor(timeSec%3600/60)) + ':' + plusZero(timeSec%60) + ':';
		} else {
			timeStr += plusZero(Math.floor(timeSec/3600)) + ':' + plusZero(Math.floor(timeSec%3600/60)) + ':' + plusZero(timeSec%60) + ':';
		}
		timeStr += plusZero(timeEnd);
		$('#time').text(timeStr);
	}
}

$(document).ready(function () {
	
	var toolContents = '';

	//삭제 등의 버튼 추가
	var bottomContents = '';
	bottomContents += '<span class="toolbox"><i id="undo" class="itool fa fa-undo" aria-hidden="true"> undo</i></span>';
	bottomContents += '<span class="toolbox"><i id="split" class="itool fa fa-scissors" aria-hidden="true"> split</i></span>';
	bottomContents += '<span class="toolbox"><i id="delete" class="itool fa fa-trash" aria-hidden="true"> delete</i></span>';
	bottomContents += '<span class="toolbox"><i id="clear" class="itool fa fa-trash-o" aria-hidden="true"> clear</i></span>';
	bottomContents += '<span style="padding-left: 330px"></span>';
	bottomContents += '<span class="bottombox"><i id="addImgTrack" class="ibottom fa fa-plus" aria-hidden="true"> <span class="character">ADD IMAGE TRACK</span></i></span>';
	bottomContents += '<span class="bottombox"><i id="addAudioTrack" class="ibottom fa fa-plus" aria-hidden="true"> <span class="character">ADD AUDIO TRACK</span></i></span>';
	bottomContents += '<span style="padding-left: 15px"></span>';
	bottomContents +=	 ' <i class="fa fa-search" aria-hidden="true"></i>';
	bottomContents +=	 " <input type='range' id='track-zoom' step='0.01' value='1' min='1' max='5' oninput='javascript:zoom();' />";   
	$('#bottm').html(bottomContents);
	
	videoSlider();
	trackDragAndDropEventHander();
});