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

/**
 * 파일이 드래그 되는 곳 생성
 */
function outputFileList(list){
	var contents = '<div id="dragDropZone">';
	
	$.each(list,function(index, item) {
		contents += '<table class="fileBox"><tr><td class="fimage">';
		contents += '';
		
		if (item.isFolder == false) {
			var path = item.path;
			var pathArray = path.split('\\');
			var imgPath = './tomolog/';
			var fileType = getFileType(item.path);
			if( fileType == 'image'){
				contents += '<img id="image' + index + '" ondragstart="drag(event)" draggable="true" class="file fimage-editor" ffid="' + item.ffid + '" path="' + imgPath + '">';
			}
			else if(fileType == 'video'){
				
				var p = item.path;
				var videoPathrray = p.split('\\');
				var videoPath = './storageResources/';
				for (var j = 2; j < videoPathrray.length; j++) {
					videoPath += videoPathrray[j] ;
					if(j < (videoPathrray.length-1) )
						videoPath += '/';
				}
				
				contents += '<video id="video' + index 
						 + '" draggable="true" ondragstart="drag(event)" ' 
						 + 'path="' + videoPath + '" '
						 + 'ffid="' + item.ffid + '" '
						 + 'width=156 height=auto controls'
						 + ' poster="' + thumbPath +'">';
				contents +=   '<source src="' + videoPath + '" type="video/mp4">';
				contents +=   '<source src="' + videoPath + '" type="video/ogg">';
				contents +=   '<source src="' + videoPath + '" type="video/webm">';
				contents +=   'Your browser does not support the video tag.';
				contents += '</video>';
			}
			else if(fileType == 'audio'){
				
				var p = item.path;
				var audioPathrray = p.split('\\');
				var audioPath = './storageResources/';
				for (var j = 2; j < audioPathrray.length; j++) {
					audioPath += audioPathrray[j] ;
					if(j < (audioPathrray.length-1) )
						audioPath += '/';
				}
				contents +='<img draggable="true" ondragstart="drag(event)" ffid="' + item.ffid + '" path="' + audioPath + '" id="audio' + index + '" src="./resources/img/storage/audio.png">';
				contents +='<audio controls>';
				contents +='  <source src=' + audioPath + ' type="audio/mpeg">';
				contents +='  Your browser does not support the audio tag.';
				contents +='</audio>';
				  
			}
			else {
				contents += '<img  src="./resources/img/storage/file.png">';
			}
		} 
		contents += '</td></tr>';
		contents += '<tr><td class="fname">'; 
		contents += item.fileName;
		contents += '</td></tr>';
	});
	
	contents += '</div>';
	
	w2ui.view.content('main', contents);
	
	var dragDrop = $("#dragDropZone");
	$('#dragDropZone').on('dragenter dragover', function(e) {
		e.preventDefault();
		$(this).css('border', '2px solid #ff0080');
	});
	$('#dragDropZone').on('drop', function(e) {
		e.preventDefault();
		var files = e.originalEvent.dataTransfer.files;
		if (files.length < 1)
			return;
		$(this).css('border', '0px');
		FileMultiUpload(files, dragDrop);
	});
	$('#dragDropZone').on('dragleave dragend', function(e) {
		e.preventDefault();
		$(this).css('border', '0px');
	});
	
	$('.fimage-editor').on('dblclick', function(){
		var path = $(this).attr('path');
		//alert(path);
		$.colorbox({maxWidth:"75%", maxHeight:"75%", href:path});
	});
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
        	/*addUndoArr(mm_player.mash)
        	reorderingVideo0Clips(idsInOrder);*/
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

function editorBinder(){
	$("#editor_jump").bind('change mouseup', function () {
		/*addUndoArr(mm_player.mash);*/
		var video0Clips = mm_player.mash.video[0].clips;
		var selectedClip = video0Clips[selectedClipNum];
		var jump = selectedClip.trim*1;
		var time = selectedClip.frames*1;
		var sum = jump + time;
		var newJump = 1*document.getElementById("editor_jump").value;
		var newTime = sum - newJump;

		$('#editor_time').attr('value', newTime);
		
		mm_player.mash.video[0].clips[selectedClipNum].frames = newTime;
		mm_player.mash.video[0].clips[selectedClipNum].trim = newJump;
		
		var preFrame = 0;
		for(var i = 0; i < mm_player.mash.video[0].clips.length; i++){
			if(getType(mm_player.mash.video[0].clips[i].id) == 'transition') {
				var frames = mm_player.mash.video[0].clips[i].frames;
				var newFrames = preFrame - frames;
				if(newFrames < 0) newFrames = 0;
				mm_player.mash.video[0].clips[i].frame = newFrames;
				preFrame = newFrames;
				continue;
			}
			mm_player.mash.video[0].clips[i].frame = preFrame;
			preFrame = preFrame + mm_player.mash.video[0].clips[i].frames;
		}
		
		var index = 0;
		for(var i = 0; i < mm_player.mash.video[0].clips.length; i++){
			if( getType(mm_player.mash.video[0].clips[i].id) == 'image' ||
					 getType(mm_player.mash.video[0].clips[i].id) == 'transition'	) continue;

			mm_player.mash.audio[0].clips[index].frame = mm_player.mash.video[0].clips[i].frame;
			mm_player.mash.audio[0].clips[index].trim = mm_player.mash.video[0].clips[i].trim;
			mm_player.mash.audio[0].clips[index].frames = mm_player.mash.video[0].clips[i].frames;
			index++;
		}
		
		mm_player.change('frame');
		mm_player.change('trim');
		video0TrackRedraw();
	});
	
	$("#e-time").bind('change mouseup', function () {
		addUndoArr(mm_player.mash);
		var newTime = 1*document.getElementById("e-time").value;

		mm_player.mash.video[0].clips[selectedClipNum].frames = newTime;
		
		var preFrame = 0;
		for(var i = 0; i < mm_player.mash.video[0].clips.length; i++){
			if(getType(mm_player.mash.video[0].clips[i].id) == 'transition') {
				var frames = mm_player.mash.video[0].clips[i].frames;
				var newFrames = preFrame - frames;
				if(newFrames < 0) newFrames = 0;
				mm_player.mash.video[0].clips[i].frame = newFrames;
				preFrame = newFrames;
				continue;
			}
			mm_player.mash.video[0].clips[i].frame = preFrame;
			preFrame = preFrame + mm_player.mash.video[0].clips[i].frames;
		}
		//alert(JSON.stringify(mm_player.mash.video[0].clips));
		var index = 0;
		for(var i = 0; i < mm_player.mash.video[0].clips.length; i++){
			//alert(JSON.stringify(selectedVideoClip));
			if( getType(mm_player.mash.video[0].clips[i].id) == 'image' ||
					getType(mm_player.mash.video[0].clips[i].id) == 'transition') continue;
			//alert(JSON.stringify(mm_player.mash.video[0].clips[i]));
			//alert(JSON.stringify(mm_player.mash.audio[0].clips[index]));
			mm_player.mash.audio[0].clips[index].frame = mm_player.mash.video[0].clips[i].frame;
			mm_player.mash.audio[0].clips[index].frames = mm_player.mash.video[0].clips[i].frames;
			index++;
		}
		
		var videoTrackObjsCnt = $.makeArray($(".video-obj").map(function(){
		    return $(this).attr("id");
		}));
		//alert(videoTrackObjsCnt);
 		mm_player.change('frames');
 		//alert(JSON.stringify(mm_player.mash));
		video0TrackRedraw();       
		setMash();
	});
}
