/**
 * 
 */
var otherObjNum = {
		"video-1" : 0,
		"video-2" : 0,
		"audio-1" : 0,
		"audio-2" : 0
};

function otherObjMove(track){
	var max = getMaxDurationFromTracks();
	var unit = trackWidth / max;
	
	var idOfObj = $.makeArray($('.' + track + '-obj').map(function(){
	    return $(this).attr("id");
	}));
	//alert(idOfObj);
	for(var i = 0; i < idOfObj.length; i++){
		//alert (idOfObj[i]);
		var left = unit * $('#' + idOfObj[i]).attr('frame') ;
		var width = unit * $('#' + idOfObj[i]).attr('frames');
		var right = left + width;
		
		$("#" + idOfObj[i]).parent().css({position: 'relative'});
		$("#" + idOfObj[i]).css({left: left, width: width, position:'absolute'});
		//alert("left : " + left);
		//alert("width : " + width);
		//alert("right : " + right);
	}
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

function getThumbFpath(path, type){
	var pathArray = path.split('/');
	var thumbPath = '';
	
	if(type == 'audio'){
		thumbPath = './resources/img/storage/audio2.png';
		return thumbPath;
	}
	for (var j = 0; j < pathArray.length-1; j++) {
		thumbPath += pathArray[j];
		thumbPath += '/';
	}
	
	thumbPath += '.thumb/';
	thumbPath += pathArray[pathArray.length-1];
	thumbPath += '.png';
	return thumbPath;
}


function resizeOtherTrackObj(id, trackId){
	var videoTrackObjsCnt = $.makeArray($(".video-obj").map(function(){
	    return $(this).attr("frames");
	}));
	
	var videoTrackTotalCnt = 0;
	
	for(var j = 0; j < videoTrackObjsCnt.length; j++){
		videoTrackTotalCnt += Number(videoTrackObjsCnt[j]);
	}
 

	var values = Object.values(tracksDuration);
	Math.max.apply(null, values);

	if( Math.max.apply(null, values) > videoTrackTotalCnt){
		resizeTrackObj(Math.max.apply(null, values));//개발해야됨.
	} else {
		var thisCnt = $('#' + id).attr('frames');
		//alert("thisCnt : "+ thisCnt);
		//alert("videoTrackTotalCnt : "+ videoTrackTotalCnt);
		var newWidth = ( trackWidth * thisCnt ) / videoTrackTotalCnt;
		
		$('#'+id).css({	
							'heigth': trackHeight,
							'width': newWidth
		});
	}
	
}

function getMaxDurationFromTracks(){
	var videoTrackObjsCnt = $.makeArray($(".video-obj").map(function(){
	    return $(this).attr("frames");
	}));
	
	var videoTrackTotalCnt = 0;
	
	for(var j = 0; j < videoTrackObjsCnt.length; j++){
		videoTrackTotalCnt += Number(videoTrackObjsCnt[j]);
	}
	
	var durations = $.map(tracksDuration, function(el) { return el });
	durations[durations.length] = videoTrackTotalCnt;
	
	var max = Math.max.apply(null, durations);
	
	return max;
}

function updateLocationObj(id, trackId){
	
	//trackWidth;
	var position = $("#" + id).position();
	var maxDuration = getMaxDurationFromTracks();
	var leftPosition = position.left;
	var unitDuration = maxDuration / trackWidth;
	
	var newFrame = leftPosition * unitDuration;
	if(newFrame < 0) newFrame = 0;
	if(newFrame > maxDuration) newFrame = maxDuration;
	
	var trackInfo = trackId.split('-');
	
	var frame = $("#" + id).attr('frame');
	
	if(trackInfo[0] == 'video') {
		var clips = mm_player.mash.video[trackInfo[1]*1].clips;

		var index = 0;
		for(var i = 0; i < clips.length; i++){
			if(clips[i].frame == frame){
				index = i;
				break;
			}
		}
		
		mm_player.mash.video[trackInfo[1]*1].clips[index].frame = newFrame;
	
	}else if(trackInfo[0] == 'audio') {
		var clips = mm_player.mash.audio[trackInfo[1]*1].clips;

		var index = 0;
		for(var i = 0; i < clips.length; i++){
			//alert(clips[i].frame);
			//alert(clips[i].frame);
			if(clips[i].frame == frame){
			//	alert("있냐");
			
				index = i;
				break;
			}
		}
		
		//alert(index);
		mm_player.mash.audio[trackInfo[1]*1].clips[index].frame = newFrame;
		
		
	}
	$("#" + id).attr('frame', newFrame);
	mm_player.change(frame);
}

function audioTrackSplitEventHandler(){
	$('#split').off('click');
	$('#split').on('click', function(){
		var idInfo = clickedObj.split('-');
		var trackId = $('#' + clickedObj).attr('trackId');
		var trackInfo = trackId.split('-');
		var frame = $("#" + clickedObj).attr('frame');
		var clips = mm_player.mash.audio[trackInfo[1]*1].clips;

		var index = 0;
		for(var i = 0; i < clips.length; i++){
			if(clips[i].frame == frame){
				index = i;
				break;
			}
		}
		var selectedClip = mm_player.mash.audio[trackInfo[1]*1].clips[index];
		mm_player.selectedClip = selectedClip;
		mm_player.split();
		reDrawTrack(clickedObj, trackInfo, index);
		timeLineSplitEventHandlerRemove();
	});
}

function reDrawTrack(id, trackId, index){
	
	var trackId = $('#' + clickedObj).attr('trackId');
	var trackInfo = trackId.split('-');
	
	var d1frame = mm_player.mash.audio[trackInfo[1]*1].clips[index].frame;
	var d1frames = mm_player.mash.audio[trackInfo[1]*1].clips[index].frames;
	
	var d2frame = mm_player.mash.audio[trackInfo[1]*1].clips[index+1].frame;
	var d2frames = mm_player.mash.audio[trackInfo[1]*1].clips[index+1].frames;
	
	$('#' + id).attr('frame', d1frame);
	$('#' + id).attr('frames', d1frames);
	
	//alert(d1frames);
	//alert(d2frames);
	
	resizeOtherTrackObj(id, trackId);
	splitAddObj(d2frame, d2frames, id );
}

//클릭 및 클릭 해제
function trackObjEventRegister(){
	$('.other-obj').off('click');
	$('.other-obj').on('click', function(e) {
		
		//alert($(this).html());
		var clicked = $(this).attr('clicked');
		
		if(clicked == 'false') { //클릭되었을때
			$(this).css({'border-color': '#fff'});
			$(this).attr('clicked', 'true');
			
			clickedObj = $(this).attr('id');
			var trackId = $(this).attr('trackId');
			var idInfo = clickedObj.split('-');
			if(idInfo[0] == 'audio'){
				audioTrackSplitEventHandler();
			} 
			
			seletedFreeOtherObj();
			outputOtherEditor();

		}
		else { //클릭 해제 되었을때
			$(this).css({'border-color': '#2e2e2e'});
			$(this).attr('clicked', 'false');
			timeLineSplitEventHandlerRemove();
			clickedObj = '';
			clearEditor();
		}
	});
}

function splitAddObj(frame, frames, preObjId ){
	var trackId = $('#' + preObjId).attr('trackId');
	var fname = $('#' + preObjId).attr('fname');
	var id = $('#' + preObjId).attr('itemId');
	var trackClass = trackId + '-obj';
	var num = otherObjNum[trackId]*1;
	var newid = trackId + '-' + num;
	num++;
	otherObjNum[trackId] = num;
	//alert(preObjId);
	//alert(newid);
	var thumbPath = $('#' + preObjId).attr('thumbPath');
	var html = $('#' + trackId).html();
	
	html += '<div class="draggable ui-widget-content ' + trackClass + ' audio-obj other-obj track-obj"';
	html += ' frames=' + frames +' ';
	html += ' id=' + newid +' ';
	html += ' itemId=' + id +' ';
	//html += ' path=' + url +' ';
	html += ' fname=' + fname +' ';
	html += ' frame=' + frame +' ';
	html += ' trackId=' + trackId +' ';
	html += ' thumbPath=' + thumbPath +' ';
	html += ' clicked=' + 'false' +' ';
	html += '>';
	html += '<img class="obj-thumb" src="' + thumbPath + '">'
	html += fname;
	html += '</div>';
	
	$('#' + trackId).html(html);
	$( ".other-obj" ).draggable({ axis: "x", containment: '#' + trackId, scroll: false });
	
	//위치 지정
	//var position = $("#" + preObjId).position();
	//var leftPosition = position.right-38;
	// $("#" + newid).css({'left': leftPosition});
	otherObjMove(trackId);
	
	resizeOtherTrackObj(newid, trackId);
	trackObjEventRegister();
		
    $( ".draggable" ).draggable({
        stop: function() {
        	addUndoArr(mm_player.mash);
        	updateLocationObj($(this).attr('id'), $(this).attr('trackId'));
        	setMash();
        }
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

function outputOtherEditor(){
	var trackId = $('#' + clickedObj).attr('trackId');
	var trackInfo = trackId.split('-');
	var frame = $("#" + clickedObj).attr('frame');
	var clips;
	if(trackInfo[0] == 'audio'){
		clips = mm_player.mash.audio[trackInfo[1]*1].clips;
	}
	else
		clips = mm_player.mash.video[trackInfo[1]*1].clips;
	
	var index = 0;
	for(var i = 0; i < clips.length; i++){
		if(clips[i].frame == frame){
			index = i;
			break;
		}
	}
	var selectedClip = '';
	if(trackInfo[0] == 'audio')
		selectedClip = mm_player.mash.audio[trackInfo[1]*1].clips[index];
	else {
		selectedClip = mm_player.mash.video[trackInfo[1]*1].clips[index];
		
	}
	//alert(JSON.stringify(selectedClip));
	var frames = selectedClip.frames;
	var trim = selectedClip.trim;
	var label = getLabel(selectedClip.id);
	//step="0.1"
	var duration = -1;
	var media = mm_player.mash.media;
	for(var j = 0; j < media.length; j++){
		if(media[j].id == selectedClip.id){
			duration = media[j].duration;
			break;
		}
	}
	
	var htmlt = '';
	htmlt += '<div>';
	htmlt += 	'<table id="editorBox">';
	htmlt += 		'<tr>';
	htmlt += 			'<td><i class="fa fa-tag" aria-hidden="true">Label </i></td>';
	htmlt += 			'<td><p id="e-label">Label</p></td>';
	htmlt += 		'</tr>';
	if(duration != null){
		htmlt += 		'<tr>';
		htmlt += 			'<td><i class="fa fa-chevron-up" aria-hidden="true">Jump</i></td>';
		htmlt += 			'<td><input id="e-jump" class="e-num" type="number">Sec</td>';
		htmlt += 		'</tr>';
	}
	htmlt += 		'<tr>';
	htmlt += 			'<td><i class="fa fa-clock-o" aria-hidden="true">Time</i></td>';
	htmlt += 			'<td><input id="e-time" class="e-num" type="number">Sec</td>';
	htmlt += 		'</tr>';
	if(duration != null){
		htmlt += 		'<tr>';
		htmlt += 			'<td><i class="fa fa-volume-up" aria-hidden="true">Vol</i> </td>';
		htmlt += 			'<td><input type="range" id="editor-vol" step="0.001" value="1" min="0" max="2" onmouseup="volumeControllOther()" onchange="volumeControllOther()" oninput="volumeControllOther()" /></td>';
		htmlt += 		'</tr>';
	}
	
	if(duration == null){
	htmlt += 		'<tr>';
	htmlt += 			'<td colspan="2"><i class="fa fa-magic" aria-hidden="true">Filter </i></td>';
	htmlt += 		'</tr>';
	htmlt += 		'<tr>';
	htmlt += 			'<td colspan="2"><div id="e-filter-box"></div></td>';
	htmlt += 		'</tr>';
	}
	htmlt += 	'</table>';
	htmlt += '</div>';

	w2ui.timeLine.content('right', htmlt);
	FilterBoxDragDropEventHandler();
	$('#e-label').text(label);
	if(duration != null){
		
		$('#e-jump').attr('max', duration.toFixed(2));
		$('#e-jump').attr('min', 0);
		$('#e-jump').attr('value', trim.toFixed(2));
		$('#e-jump').attr('step', 1);
		
		$('#e-time').attr('max', duration.toFixed(2));

		var vol = selectedClip.gain;
		//alert(vol);
		document.getElementById('editor-vol').value = vol;
		
	}

	$('#e-time').attr('min', 0);
	$('#e-time').attr('value', frames.toFixed(2));
	$('#e-time').attr('step', 1);
	
	if(trackInfo[0] != 'audio')
		outputEditorFilters(selectedClip);
	
	editorUnbinder();
	editorOtherBinder();
}

function editorOtherBinder(){
	$("#e-jump").bind('change mouseup', function () {
		addUndoArr(mm_player.mash);
		var trackId = $('#' + clickedObj).attr('trackId');
		var trackInfo = trackId.split('-');
		var frame = $("#" + clickedObj).attr('frame');
		
		var clips = '';
		if(trackInfo[0] == 'audio'){
			clips = mm_player.mash.audio[trackInfo[1]*1].clips;
		}
		else
			clips = mm_player.mash.video[trackInfo[1]*1].clips;
			
		var index = 0;
		for(var i = 0; i < clips.length; i++){
			if(clips[i].frame == frame){
				index = i;
				break;
			}
		}
		var selectedClip = '';
		if(trackInfo[0] == 'audio')
			selectedClip = mm_player.mash.audio[trackInfo[1]*1].clips[index];
		else
			selectedClip = mm_player.mash.video[trackInfo[1]*1].clips[index];
		
		var jump = selectedClip.trim*1;
		var time = selectedClip.frames*1;
		var sum = jump + time;
		
		//alert(sum);
		var newJump = 1*document.getElementById("e-jump").value;
		var newTime = sum - newJump;

		$('#e-time').attr('value', newTime);
		//$('#e-time').attr('max', newTime);
		
		var oldTime = 0;
		if(trackInfo[0] == 'audio') {
			oldTime = mm_player.mash.audio[trackInfo[1]*1].clips[index].frames;
			mm_player.mash.audio[trackInfo[1]*1].clips[index].frames = newTime;
			mm_player.mash.audio[trackInfo[1]*1].clips[index].trim = newJump;
		
		}else{
			oldTime = mm_player.mash.video[trackInfo[1]*1].clips[index].frames;
			mm_player.mash.video[trackInfo[1]*1].clips[index].frames = newTime;
			mm_player.mash.video[trackInfo[1]*1].clips[index].trim = newJump;
		}
		
		$('#' + clickedObj).attr('frames', newTime);
		
		mm_player.change('frame');
		mm_player.change('trim');
		
		tracksDuration[trackId] = tracksDuration[trackId] - oldTime + newTime;
		
		otherObjMove(trackId);
		setMash();
	});
	
	$("#e-time").bind('change mouseup', function () {
		addUndoArr(mm_player.mash);
		var newTime = 1*document.getElementById("e-time").value;
		
		var trackId = $('#' + clickedObj).attr('trackId');
		var trackInfo = trackId.split('-');
		var frame = $("#" + clickedObj).attr('frame');
		
		var clips = '';
		if(trackInfo[0] == 'audio'){
			clips = mm_player.mash.audio[trackInfo[1]*1].clips;
		}
		else
			clips = mm_player.mash.video[trackInfo[1]*1].clips;
			
		var index = 0;
		for(var i = 0; i < clips.length; i++){
			if(clips[i].frame == frame){
				index = i;
				break;
			}
		}
		
		var oldTime = 0;
		if(trackInfo[0] == 'audio') {
			oldTime = mm_player.mash.audio[trackInfo[1]*1].clips[index].frames;
			mm_player.mash.audio[trackInfo[1]*1].clips[index].frames = newTime;
		
		}else{
			oldTime = mm_player.mash.video[trackInfo[1]*1].clips[index].frames;
			mm_player.mash.video[trackInfo[1]*1].clips[index].frames = newTime;
		}
		
		$('#' + clickedObj).attr('frames', newTime);
		
 		mm_player.change('frame');
 		tracksDuration[trackId] = tracksDuration[trackId] - oldTime + newTime;
 		
 		otherObjMove(trackId); 
 		setMash();
	});
}

function volumeControllOther(){
	addUndoArr(mm_player.mash);
	if(clickedObj == '') return;
	
	var trackId = $('#' + clickedObj).attr('trackId');
	var trackInfo = trackId.split('-');
	var frame = $("#" + clickedObj).attr('frame');
	
	var clips = '';
	if(trackInfo[0] == 'audio'){
		clips = mm_player.mash.audio[trackInfo[1]*1].clips;
	}
	else
		clips = mm_player.mash.video[trackInfo[1]*1].clips;
		
	var index = 0;
	for(var i = 0; i < clips.length; i++){
		if(clips[i].frame == frame){
			index = i;
			break;
		}
	}
	
	var value = document.getElementById('editor-vol').value;
	
	mm_player.mash.audio[trackInfo[1]*1].clips[index].gain = value;;
	mm_player.__adjust_gain(mm_player.mash.audio[trackInfo[1]*1].clips);
	setMash();
}

function checkTrackType(data){
	//alert(data);
	if(data.indexOf("videoObj") != -1) return 'video';
	if(data.indexOf("image-") != -1) return 'image';
	if(data.indexOf("audio-") != -1) return 'audio';
}

function selectedObjDelete(objId){
	var track = checkTrackType(objId);
	if( track == 'video' ) {
		var audio0Clips = mm_player.mash.audio[0].clips;
		var index = 0;
		var selectedAudioClip;
		for(var i = 0; i < mm_player.mash.video[0].clips.length; i++){
			
			if( getType(mm_player.mash.video[0].clips[i].id) == 'image' ||
					getType(mm_player.mash.video[0].clips[i].id) == 'transition'	) continue;
			if(i==selectedClipNum) {
				selectedAudioClip = audio0Clips[index];
				break;
			}
			index++;
		}
		
		var video0Clips = mm_player.mash.video[0].clips;
		var selectedClip = video0Clips[selectedClipNum];

		mm_player.remove(selectedClip, 'video', 0);
		mm_player.remove(selectedAudioClip, 'audio', 0);
		//alert(JSON.stringify(mm_player.mash));
		
    	var idsInOrder = $("#video-track").sortable("toArray");
    	var newIdsInOrder =  reAssignUiId(idsInOrder, selectedClipNum);
    	clickedObj = '';
    	selectedClipNum = 0;
    	reorderingVideo0Clips(newIdsInOrder);	
		//video0TrackRedraw2();
		timeLineSplitEventHandlerRemove();
		clearEditor();
		
		videoTotalDuration -= selectedClip.frames;
	}
	else if( track == 'image' || track == 'audio' ){
		//alert(track);
		//alert("audio split");
		var idInfo = objId.split('-');
		var trackId = $('#' + objId).attr('trackId');
		var trackInfo = trackId.split('-');
		var frame = $("#" + objId).attr('frame');
		var clips ;
		
		if(track == 'image')
			clips = mm_player.mash.video[trackInfo[1]*1].clips;
		else
			clips = mm_player.mash.audio[trackInfo[1]*1].clips;
		
		var index = 0;
		for(var i = 0; i < clips.length; i++){
			if(clips[i].frame == frame){
				index = i;
				break;
			}
		}
		
		var selectedClip = clips[index];
		if(track == 'image') track = 'video';
		//alert(track);
		mm_player.remove(selectedClip, track, trackInfo[1]*1);
		//alert(JSON.stringify(mm_player.mash.audio[trackInfo[1]*1].clips));
		if(track == 'audio') {
			for(var i = 0; i < mm_player.mash.audio[trackInfo[1]*1].clips.length; i++){
				mm_player.selectedClip = mm_player.mash.audio[trackInfo[1]*1].clips[i];
				mm_player.change('frames');
			}
		} else {
			
			for(var i = 0; i < mm_player.mash.video[trackInfo[1]*1].clips.length; i++){
				mm_player.selectedClip = mm_player.mash.video[trackInfo[1]*1].clips[i];
				mm_player.change('frames');
			}	
		}
		

	//	alert(JSON.stringify(mm_player.mash));
    	clickedObj = '';
    	selectedClipNum = 0;
		tracksDuration[trackId] = tracksDuration[trackId] - selectedClip.frames;
		reDrawTrackAfterRemove(trackId, objId);
		clearEditor();
		$( ".other-obj" ).draggable({ axis: "x", containment: '#' + trackId, scroll: false });
		trackObjEventRegister();
	    $( ".draggable" ).draggable({
	        stop: function() {
	        	addUndoArr(mm_player.mash);
	        	updateLocationObj($(this).attr('id'), $(this).attr('trackId'));
	        	setMash();
	        }
	     });
	}
	resizeTrackObj(0);
	var trackArr= Object.keys(tracksDuration);
	for(var i = 0; i < trackArr.length; i++){
		otherObjMove(trackArr[i]);
	}
}

function reDrawTrackAfterRemove(trackId, objId){
	var trackArr = $('#' + trackId);
	var newHtml = '';
	for (var i = 0; i < trackArr[0].children.length; i++) {
		//alert(trackArr[0].children[i].outerHTML);
		//alert($('#' + objId)[0].outerHTML);
		if(trackArr[0].children[i].outerHTML == $('#' + objId)[0].outerHTML){
			continue;
		}
		
		newHtml += trackArr[0].children[i].outerHTML;
	}
	
	$('#' + trackId).html(newHtml);
	
	otherObjNum[trackId] = otherObjNum[trackId] - 1;
}

function FilterBoxDragDropEventHandler(){
	$('#e-filter-box').on('dragenter dragover', function(e) {
		e.preventDefault();
		$(this).css('border', '2px solid #ff0080');
	});
	
	$('#e-filter-box').on('drop', function(e) {
		addUndoArr(mm_player.mash);
		e.preventDefault();
		$(this).css('border', '0px');
		var data = e.originalEvent.dataTransfer.getData("text");
		if(data=='') return;
	
		if( checkFileType(data) != 'filter') return;
		
		//여기다가 할일을 
		addFilter(data);
		setMash();
	});
	
	$('#e-filter-box').on('dragleave dragend', function(e) {
		e.preventDefault();
		$(this).css('border', '0px');
	});	
}

function addFilter(id){
	
	var track = checkTrackType(clickedObj);
	if( track == 'video' ) {
		var frame = mm_player.mash.video[0].clips[selectedClipNum].frame;
		add_effect(id, 'video0', frame);
	} else {
		var trackId = $('#' + clickedObj).attr('trackId');
		var trackInfo = trackId.split('-');
		var frame = $("#" + clickedObj).attr('frame');
		
		var clips = '';
		if(trackInfo[0] == 'audio'){
			clips = mm_player.mash.audio[trackInfo[1]*1].clips;
		}
		else
			clips = mm_player.mash.video[trackInfo[1]*1].clips;
			
		var index = 0;
		for(var i = 0; i < clips.length; i++){
			if(clips[i].frame == frame){
				index = i;
				break;
			}
		}
		var selectedClip = '';
		if(trackInfo[0] == 'audio')
			selectedClip = mm_player.mash.audio[trackInfo[1]*1].clips[index];
		else
			selectedClip = mm_player.mash.video[trackInfo[1]*1].clips[index];
		
		mm_player.selectedClip = selectedClip;
		add_effect(id, trackId, frame);
	}

	var filterInfo = id.split('-');
	var html = $('#e-filter-box').html();
	
	html += '<div class="filter-Obj"';
	html += ' id=' + filterInfo[1] +' ';
	html += '><p> ';
	html += filterInfo[1];
	html += '</p></div>';
			
	$('#e-filter-box').html(html);
	filterDeleteEventHandler();
}

function outputEditorFilters(selectedClip){
	var html = '';
	//alert(JSON.stringify(selectedClip));
	var effects = selectedClip.effects;

	for(var i = 0; i < effects.length; i++){
		html += '<div class="filter-Obj"';
		html += ' id=' + effects[i].id +' ';
		html += '><p> ';
		html += effects[i].id;
		html += '</p></div>';
	}
	$('#e-filter-box').html(html);
	filterDeleteEventHandler();
}

function filterDeleteEventHandler(){
	$('.filter-Obj').off('dblclick');
	$('.filter-Obj').on('dblclick', function(){
		var fId = $(this).attr('id');
		remove_filter(fId);
		outputEditorFilters(mm_player.selectedClip);
	});
}

function trackRedraw(trackId){

	var trackInfo = trackId.split('-');
	var type = trackInfo[0];
	
	
/*	var trackcls = 'odd';
	if( (trackInfo[1]*1) / 2 == 0) trackcls = 'even';
	
	var html = '';

	html +=			'<span class="track-name">';
	html +=				'<i class="fa fa-picture-o" aria-hidden="true"></i>';
	html +=			'</span>';
	html +=			'<div class="track-' + trackcls + ' other-track" id=' + trackId + '>';
	html +=			'</div>';*/

	var clips = '';
	if (type == 'audio')
		clips = mm_player.mash.audio[trackInfo[1]*1].clips;
	else 
		clips = mm_player.mash.video[trackInfo[1]*1].clips;
		
	$('#' + trackId).html('');
	for(var i = 0; i<clips.length; i++){
		
		var frames = clips[i].frames;//ok
		//var trim = clips[i].trim;
		var fname = getLabel(clips[i].id); //ok
		var frame = clips[i].frame;
		var trackClass = trackId + '-obj'; //ok
		var num = otherObjNum[trackId]*1; // ok
		var newid = trackId + '-' + num; //ok
		num++;
		otherObjNum[trackId] = num;
		//alert(preObjId);
		//alert(newid);
		var thumbPath = '';
		
		if(type == 'audio'){
			thumbPath = './resources/img/storage/audio2.png';
		}else{
			thumbPath = getUrl(clips[i].id);
		}
		
		var html = $('#' + trackId).html();
		
		if(type == 'audio') {
			html += '<div class="draggable ui-widget-content ' + trackClass + ' audio-obj other-obj track-obj"';
		}
		else if( type == 'video') {
			html += '<div class="draggable ui-widget-content ' + trackClass + ' image-obj  other-obj track-obj"';
		}

		html += ' frames=' + frames +' ';
		html += ' id=' + newid +' ';
		html += ' itemId=' + type +' ';
		//html += ' path=' + url +' ';
		html += ' fname=' + fname +' ';
		html += ' frame=' + frame +' ';
		html += ' trackId=' + trackId +' ';
		html += ' thumbPath=' + thumbPath +' ';
		html += ' clicked=' + 'false' +' ';
		html += '>';
		html += '<img class="obj-thumb" src="' + thumbPath + '">'
		html += fname;
		html += '</div>';
		
		$('#' + trackId).html(html);
		otherObjMove(trackId);
		
		//reDrawTrack(newid, trackInfo, i);
	}
	
	var objs = $.makeArray($("." + trackClass).map(function(){
	    return $(this).attr("id");
	}));
	
	for(var i = 0 ; i < objs.length; i++)
		resizeOtherTrackObj(objs[i], trackId);
	
	$( ".other-obj" ).draggable({ axis: "x", containment: '#' + trackId, scroll: false });
	
	
	trackObjEventRegister();
	
    $( ".draggable" ).draggable({
        stop: function() {
        	addUndoArr(mm_player.mash);
        	updateLocationObj($(this).attr('id'), $(this).attr('trackId'));
        	setMash();
        }
     });

}