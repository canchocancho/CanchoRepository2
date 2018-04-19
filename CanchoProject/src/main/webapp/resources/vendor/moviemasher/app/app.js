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
	  /*getMash();*/
}

function extract(){	
	var zeroPlus = '';
    $.ajax({
   		url : 'extract',
   		type : 'GET',
   		success : function(url) {
   			var duration = url.count/30
   			var zeroCount = String(url.count.toString()).length;
   			for(var i = 0; i <= zeroCount; i++){
   				zeroPlus += '0';
    		}
    		var media = {
    	    		'label': 'pika',
   		    		'id': 'pika',
   		    		'type': 'video', 
   		    		'url': url.originPath,
   		    		'fps': 30,
   		    		'pattern':  (zeroPlus+'%.jpg'),
    	    		'duration' : duration
    	   };
    		mm_player.add(media, 'video', videoTotalDuration , 0);
    		/*isAudio ==*/
    		if(true){
    			   media = {
    					      'label': 'pika',
    					      'type': 'audio',
    					      'id': 'pikaaudio',
    					      'url': url.originPath + 'audio.mp3',
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

function myHandler(){
	if(document.getElementById('t-slider') != null &&
	document.getElementById('player-slider') != null) {
		document.getElementById('t-slider').value = mm_player.position;
		document.getElementById('player-slider').value = mm_player.position;
		
		var videoTrackObjsCnt = $.makeArray($(".video-obj").map(function(){
			//if($(this).attr('itemId').indexOf('transition') != -1) return -1 * ($(this).attr("frames"));
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

function getMash(){
	alert("getMash");
	$.ajax({
		url : 'getMash',
		type : 'POST',
		dataType : 'json',
		success : function(item) {
			mm_player.mash = eval("("+item.mash+")");
			tracksDuration = eval("("+item.durations+")");
			videoTotalDuration = item.videoDur * 1;
			//otherObjNum = eval("("+item.otherObjNum+")");
			//video0TrackobjNum = item.videoObjNum * 1;
			
			video0TrackRedraw();
			var trackArr= Object.keys(tracksDuration);
			for(var i = 0; i < trackArr.length; i++){
				trackRedraw(trackArr[i]);
			}	
		},
		error : function(e) {
			console.log(e);
		}
	});	
}

function setMash(){
	alert("setMash");
	$.ajax({
		url : 'setMash',
		type : 'POST',
		data : {
			mash : JSON.stringify(mm_player.mash),
			durations : JSON.stringify(tracksDuration),
			videoDur : videoTotalDuration,
			otherObjNum : otherObjNum,
			videoObjNum : video0TrackobjNum
		},
		success : function() {
		},
		error : function(e) {
			console.log(e);
		}
	});	
}
