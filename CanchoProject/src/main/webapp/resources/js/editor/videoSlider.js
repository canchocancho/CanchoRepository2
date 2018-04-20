var selectedClipNum;
var tracksDuration = {
		"video-1" : 0,
		"video-2" : 0,
		"audio-1" : 0,
		"audio-2" : 0
};


/**
 * 현재 mash된 미디어의 라벨
 */
function getLabel(id){
	var label;
	var media = mm_player.mash.media;
	for(var j = 0; j < media.length; j++){
		if(media[j].id == id){
			label = media[j].label;
			break;
		}
	}
	return label;
}

/**
 * 현재 mash된 미디어의 타입
 */
function getType(id){
	var type;
	var media = mm_player.mash.media;
	for(var j = 0; j < media.length; j++){
		if(media[j].id == id){
			type = media[j].type;
			break;
		}
	}
	return type;
}

/**
 * 현재 mash된 미디어의 url
 */
function getUrl(id){

	var url;
	var media = mm_player.mash.media;
	for(var j = 0; j < media.length; j++){
		if(media[j].id == id){
			url = media[j].url;
			break;
		}
	}
	return url;
}

/**
 * 현재 mash된 미디어의 Duration
 */
function getDur(id){

	var duration;
	var media = mm_player.mash.media;
	for(var j = 0; j < media.length; j++){
		if(media[j].id == id){
			duration = media[j].duration;
			break;
		}
	}
	return duration;
}

function getFileType(path){
	var imgExtarr = new Array('jpg', 'jpeg', 'png');
	var vdoExtarr = new Array('mp4', 'wemb', 'ogg');
	var adoExtarr = new Array('mp3');
	
	var rtn = 'file';
	
	var pathArray = path.split('\\');
	var fileArray = pathArray[pathArray.length-1].split('.');
	var ext = fileArray[fileArray.length-1];
	
	for (var i in imgExtarr) {
		if(imgExtarr[i] == ext.toLowerCase())
			return 'image';
	}
	
	for (var i in vdoExtarr) {
		if(vdoExtarr[i] == ext.toLowerCase())
			return 'video';
	}
	
	for (var i in adoExtarr) {
		if(adoExtarr[i] == ext.toLowerCase())
			return 'audio';
	}
	
	return rtn;
}


/**
 * 비디오 상세 설정창(라벨, 점프, 볼륨, 필터 등)
 */
function outputVideoEditor(){
	selectedClipNum = 0;
	var video0Clips = mm_player.mash.video[0].clips;
	var selectedClip = video0Clips[selectedClipNum];
	var frames = selectedClip.frames;
	var trim = selectedClip.trim;
	var label = getLabel(selectedClip.id);
	var duration = getDur(selectedClip.id)
	//실행될 미디어의 모든 정보가 객체로 담겨진 함수
	var media = mm_player.mash.media;
	
	var htmlt = '';
	htmlt += '<div>';
	htmlt += '<table id="editorBox">';
	htmlt += '<tr>';
	htmlt += '<td><div>Label</div></td>';
	htmlt += '<td><p id="editor_label">Label</p></td>';
	htmlt += '</tr>';
	if(duration != null){
		htmlt += '<tr>';
		htmlt += '<td><div>Jump</div></td>';
		htmlt += '<td><input id="editor_jump" class="e-num" type="number">Sec</td>';
		htmlt += '</tr>';
	}
	htmlt += '<tr>';
	htmlt += '<td><div>Time</div></td>';
	htmlt += '<td><input id="editor_time" class="e-num" type="number">Sec</td>';
	htmlt += '</tr>';
	if(duration != null){
		htmlt += '<tr>';
		htmlt += '<td><div>Vol</div> </td>';
		htmlt += '<td><input type="range" id="editor-vol" step="0.001" value="1" min="0" max="2" onmouseup="volumeControll()" onchange="volumeControll()" oninput="volumeControll()" /></td>';
		htmlt += '</tr>';
	}
	$('#volume').html(htmlt);	
	$('#editor_label').text(label);
	
	if(duration != null){
		$('#editor_jump').attr('max', duration.toFixed(2));
		$('#editor_jump').attr('value', trim.toFixed(2));
		$('#editor_jump').attr('min', 0);
		$('#editor_jump').attr('step', 1);
	/*	$('#editor_time').attr('max', duration.toFixed(2));*/
		
		var index = 0;
		for(var i = 0; i < mm_player.mash.video[0].clips.length; i++){
			if( getType(mm_player.mash.video[0].clips[i].id) == 'image' ||
				getType(mm_player.mash.video[0].clips[i].id) == 'transition'){
				continue;
			}
			if(i==selectedClipNum) {
				var vol = mm_player.mash.audio[0].clips[index];
				document.getElementById('editor-vol').value = vol;
				break;
			}
			index++;
		}
	}
	
	mm_player.selectedClip = selectedClip;
	
	$('#editor_time').attr('min', 0);
	$('#editor_time').attr('value', frames.toFixed(2));
	$('#editor_time').attr('step', 1);
	
	/*editorUnbinder();*/
	editorBinder();
}

/**
 * 일반 Movie Player와 비디오 슬라이더의 싱크를 맞춰 준다. 
 */
function sliderSyncro(slide_type){
	var svalue;
	var tsvalue = document.getElementById('t-slider').value;
	var psvalue = document.getElementById('p-slider').value;
	if(slide_type == 'tslider') {
		document.getElementById('p-slider').value = tsvalue;
		svalue = tsvalue;
	}else if(slide_type == 'pslider'){
		document.getElementById('t-slider').value = psvalue;
		svalue = psvalue;
	}
	mm_player.position = svalue;
}

/**
 * 비디오 슬라이더
 */
function videoSlider(){
    $("#video-track").sortable({
        revert: true,
        start: function(event, ui) {
            alert("start");
        },
        change: function(event, ui) {
           alert("change");
        },
        update: function(event, ui) {
        	var idsInOrder = $("#video-track").sortable("toArray");
        	//reorderingVideo0Clips(idsInOrder);
        }
    });
}

function drag(ev) {
    ev.dataTransfer.setData("text", ev.target.id);
}

/**
 * 비디오 drag&drop
 */
function videoDragDropEventHandler(){
	
	$('#video-track').on('dragenter dragover', function(e) {
		e.preventDefault();
		$(this).css('border', '2px solid #ff0080');
	});
	
	$('#video-track').on('drop', function(e) {
		
		e.preventDefault();
		$(this).css('border', '0px');
		var data = e.originalEvent.dataTransfer.getData("text");
		if(data=='') return;
	
		if( checkFileType(data) != 'video' && 
			checkFileType(data) != 'image' &&
			checkFileType(data) != 'transition') return;

		addUndoArr(mm_player.mash);
		//여기다가 할일을 
		if(checkFileType(data) == 'video') {
			addVideoTrackVideoObj(data);
		} else if(checkFileType(data) == 'image'){
			addVideoTrackImageObj(data);
		} 
		else if(checkFileType(data) == 'transition'){
			addVideoTrackTransitionsObj(data);
		}
		
	});
	
	$('#video-track').on('dragleave dragend', function(e) {
		e.preventDefault();
		$(this).css('border', '0px');
	});	
}

/**
 * 메인트랙 drag&drop
 */
function trackDragAndDropEventHander(){
	videoDragDropEventHandler();
	var trackArr= Object.keys(tracksDuration);
	for(var i = 0; i < trackArr.length; i++){
		var splited = trackArr[i].split('-');
		var type = '';
		if(splited[0] == 'video') {
			type = 'image';
		}else if(splited[0] == 'audio'){
			type = 'audio';
		}
		subTrackDragDropEventHandler(trackArr[i], type);
	}
}
/**
 * 서브트랙 drag&drop
 */
function subTrackDragDropEventHandler(trackId, type){
	$('#' + trackId).on('dragenter dragover', function(e) {
		e.preventDefault();
		$('#' + trackId + '-cont').css('border', '2px solid #ff0080');
	});
	
	$('#' + trackId).on('drop', function(e) {
		addUndoArr(mm_player.mash);
		e.preventDefault();
		$('#' + trackId + '-cont').css('border', '0px');
		var data = e.originalEvent.dataTransfer.getData("text");
		if(data=='') return;
		if( checkFileType(data) != type) return;
		addObj(trackId, data );
	});
	$('#' + trackId).on('dragleave dragend', function(e) {
		e.preventDefault();
		$('#' + trackId + '-cont').css('border', '0px');
	});	
}

function addObj(trackId, id){
	if(video0TrackobjNum == 0){
		alert("video 트랙에 적어도 하나의 영상이 필요합니다.");
		return;
	}
	
	var path = $('#' + id).attr('path');
	var fname = getFileName(path);
	var type = getFileType(path);
	//alert(path);
	var thumbPath = getThumbFpath(path, type);
	//alert(thumbPath);
		
	var url = path.substring(2,path.length);
	//alert(url);
	var html = $('#' + trackId).html();
	var num = otherObjNum[trackId]*1;
	var newid = trackId + '-' + num;
	num++;
	otherObjNum[trackId] = num;
	//alert(JSON.stringify(otherObjNum));
	var trackClass = trackId + '-obj';
	$.ajax({
		url : 'getObjectInfo',
		type : 'GET',
		data : {
			path : path,
			type : type
		},
		dataType : 'json',
		success : function(duration) {
			if(type == 'audio') {
				html += '<div class="draggable ui-widget-content ' + trackClass + ' audio-obj other-obj track-obj"';
			}
			else if( type == 'image') {
				html += '<div class="draggable ui-widget-content ' + trackClass + ' image-obj  other-obj track-obj"';
			}
			var thumbId = newid+'image';
			//alert(thumbId);
			html += ' frames=' + duration +' ';
			html += ' id=' + newid +' ';
			html += ' itemId=' + id +' ';
			//html += ' path=' + url +' ';
			html += ' fname=' + fname +' ';
			html += ' trackId=' + trackId +' ';
			html += ' thumbPath=' + thumbPath +' ';
			html += ' clicked=' + 'false' +' ';
			html += '>';
			html += '<img class="obj-thumb" src="' + thumbPath + '">'
			html += fname;
			html += '</div>';
			
			$('#' + trackId).html(html);
			$( ".other-obj" ).draggable({ axis: "x", containment: '#' + trackId, scroll: false });
			var addedClip = add_media(trackId, newid, url, fname, duration);
			//alert(JSON.stringify(mm_player.mash));
			$('#' + newid).attr('frame', addedClip.frame);
			
			resizeOtherTrackObj(newid, trackId);
			trackObjEventRegister();
		    $( ".draggable" ).draggable({
		        stop: function() {
		        	addUndoArr(mm_player.mash);
		        	updateLocationObj($(this).attr('id'), $(this).attr('trackId'));
		        	setMash();
		        }
		     });
		},
		error : function(e) {
			//alert(JSON.stringify(e));
		}
	});	
}

function add_media(trackId, id, url, fname, duration){
	
	var trackInfos = trackId.split('-');
	var type = trackInfos[0];
	if(type == 'video') type='image';
	
	var add = {
		      'label': fname,
		      'type': type,
		      'id': id,
		      'url': url,
	};
	
	if(type == 'audio'){
		add['duration']  = duration;
	}
	mm_player.add(add, trackInfos[0], tracksDuration[trackId] , trackInfos[1]*1);
	//alert(JSON.stringify(mm_player.selectedClip, null, '\t'));
	setMash();
	
	tracksDuration[trackId] += duration;	
	return mm_player.selectedClip;
	//alert(JSON.stringify(mm_player.mash, null, '\t'));
}
