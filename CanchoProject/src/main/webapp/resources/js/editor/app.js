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
	  videoSlider();
	  trackDragAndDropEventHander();
	  timeLineMenuEventHandler();
}

/**
 * MovieMasher masher
 * mm_player에 이미지를 넣어 동영상처럼 만든다
 */
function add_mash(id,fname,url,count,length,isAudio){
	var zeroPlus = '';
	var duration = count/30;
	var zeroCount = String(count.toString()).length;
	for(var i = 0; i <= zeroCount; i++){
		zeroPlus += '0';
	}
	var media = {
    			'label': fname,
	    		'id': id,
	    		'type': 'video', 
	    		'url': url,
	    		'fps': 30,
	    		'pattern': (zeroPlus+'%.jpg'),
	    		'duration' : duration
   };
	mm_player.add(media, 'video', videoTotalDuration , 0);
	if(isAudio ==true){
		   media = {
				      'label': fname,
				      'type': 'audio',
				      'id': "audio"+id,
				      'url': url + 'audio.mp3',
				      'duration': duration,
		  };
		   
		  mm_player.add(media, 'audio', videoTotalDuration , 0);
	   }
	  videoTotalDuration += duration;
	  mainTrackObjCnt++;
 }
/**
 * 추가 미디어 mash추가
 */
function add_media(trackId, id, url, fname, duration){
	var trackInfos = trackId.split('-');
	var type = trackInfos[0];
	var add = {
		      'label': fname,
		      'type': type,
		      'id': id,
		      'url': url,
	};
	if(type == 'audio'){
		add['duration']  = duration;
		mm_player.add(add, trackInfos[0], subTracksDuration[trackId] , trackInfos[1]*1);
	}else{
		mm_player.add(add, trackInfos[0], 60 , trackInfos[1]*1);
	}
	
	subTracksDuration[trackId] += duration;
	return mm_player.selectedClip;
}
/**
 * 드래그 드롭 이벤트 설정
 */
function eventOnDraw(ctx, eventName){
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
	document.getElementById('p-slider') != null) {
		document.getElementById('t-slider').value = mm_player.position;
		document.getElementById('p-slider').value = mm_player.position;
	}
}