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
   			alert(zeroCount);
   			alert(url);
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

