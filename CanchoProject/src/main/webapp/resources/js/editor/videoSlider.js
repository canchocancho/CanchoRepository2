var selectedClipNum;
var video0TrackobjNum = 0;
var trackWidth =926;
var trackHeight = 70;
var subTracksDuration = {
		"image-1" : 0,
		"image-2" : 0,
		"audio-1" : 0,
		"audio-2" : 0
};
var subTrackObjNum = {
		"image-1" : 0,
		"image-2" : 0,
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
 * 현재 mash된 전체 트랙들의 총합 Duration
 */
function getTotalDur(){
	var videoTrackObjsCnt = $.makeArray($(".video-obj").map(function(){
	    return $(this).attr("frames");
	}));
	
	var videoTrackTotalCnt = 0;
	
	for(var j = 0; j < videoTrackObjsCnt.length; j++){
		videoTrackTotalCnt += Number(videoTrackObjsCnt[j]);
	}
	
	var durations = $.map(subTracksDuration, function(el) { return el });
	durations[durations.length] = videoTrackTotalCnt;
	
	var biggest = -1;
	for (var i = 0; i < durations.length; i++) {
		if (durations[i] > biggest) {
			biggest = durations[i];
		}
	}
	return biggest;
}

/**
 * 경로의 파일 확장자 가져오기
 */
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
 * 경로 안 파일
 */
function getFileName(path){
	var pathArray = path.split('/');
	return pathArray[pathArray.length-1];
}

/**
 * 해당 파일의 확장자
 */
function checkFileType(data){
	if(data.indexOf("video") != -1) return 'video';
	if(data.indexOf("audio") != -1) return 'audio';
	if(data.indexOf("image") != -1) return 'image';
}

function checkTrackType(data){
	if(data.indexOf("videoObj") != -1) return 'video';
	if(data.indexOf("image-") != -1) return 'image';
	if(data.indexOf("audio-") != -1) return 'audio';
}

/**
 * 비디오트랙 클릭 이벤트 등록
 */
function video0TrackEventRegister(){
	$('.video-obj').on('click', function(e) {
		
		var mash = mm_player.mash;
		console.log(JSON.stringify(mash));
		
		var clicked = $(this).attr('clicked');	
		var IdsOftrackObjs = $.makeArray($(".track-obj").map(function(){
		    return $(this).attr("id");
		}));
		if(clicked == 'false') {
			$(this).css({'border-color': '#fff'});
			$(this).attr('clicked', 'true');
			videoTrackSplitEventHandler();
			clickedObj = $(this).attr('id');
			selectedClipNum = 1 * clickedObj.charAt(clickedObj.length-1);
			for(var i = 0; i < IdsOftrackObjs.length; i++){
				var thisId = IdsOftrackObjs[i];
				if(clickedObj == thisId) continue;
				$('#' + thisId).css({'border-color': '#2e2e2e'});
				$('#' + thisId).attr('clicked', 'false');
			}
		}
		else {
			$(this).css({'border-color': '#2e2e2e'});
			$(this).attr('clicked', 'false');
			timeLineSplitEventHandlerRemove();
			clickedObj = '';
			selectedClipNum = 0;
		}
	});
}
/**
 * 비디오트랙 클릭 이벤트 해제
 */
function video0TrackEventRemover(){
	$('.video-obj').off('click');	
}

function seletedFreeOtherObj(){
	var IdsOftrackObjs = $.makeArray($(".track-obj").map(function(){
	    return $(this).attr("id");
	}));
	for(var i = 0; i < IdsOftrackObjs.length; i++){
		var thisId = IdsOftrackObjs[i];
		if(clickedObj == thisId) continue;
		$('#' + thisId).css({'border-color': '#2e2e2e'});
		$('#' + thisId).attr('clicked', 'false');
	}	
}


/**
 * 일반 Movie Player와 비디오 슬라이더의 싱크를 맞춰 준다. 
 */
function sliderSyncro(slider){
	var t_slider = document.getElementById('t-slider').value;
	var p_slider = document.getElementById('p-slider').value;
	if(slider == 'tslider') {
		document.getElementById('p-slider').value = t_slider;
		mm_player.position = t_slider;
	}else if(slider == 'pslider'){
		document.getElementById('t-slider').value = p_slider;
		mm_player.position = p_slider;
	}
}

/**
 * 비디오 슬라이더 Drag & Drop 세팅
 */
function videoSlider(){
    $("#video-track").sortable({
        revert: true,
        start: function(event, ui) {
        },
        change: function(event, ui) {
        },
        update: function(event, ui) {
        	var idsInOrder = $("#video-track").sortable("toArray");
        	reorderingVideo0Clips(idsInOrder);
        }
    });
}

/**
 * Drag 이벤트
 */
function drag(e) {
    e.dataTransfer.setData("text", e.target.id);
}

/**
 * 비디오 drag&drop 핸들러
 */
function trackDragAndDropEventHander(){
	var trackArr= Object.keys(subTrackObjNum);
	videoDragDropEventHandler();
	for(var i = 0; i < trackArr.length; i++){
		var splited = trackArr[i].split('-');
		var type = splited[0];
		subTrackDragDropEventHandler(trackArr[i], type);
	}
}

/**
 * 메인 drag&drop
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
		if(checkFileType(data) == 'video') {
			addVideoTrackVideoObj(data);
		}else{
			return;
		}
	});
	$('#video-track').on('dragleave dragend', function(e) {
		e.preventDefault();
		$(this).css('border', '0px');
	});	
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
		e.preventDefault();
		$('#' + trackId + '-cont').css('border', '0px');
		var data = e.originalEvent.dataTransfer.getData("text");
		if(checkFileType(data) == type) {
			addSubTrackObj(trackId, data);
		}else{
			return;
		}	
	});
	$('#' + trackId).on('dragleave dragend', function(e) {
		e.preventDefault();
		$('#' + trackId + '-cont').css('border', '0px');
	});	
}

/**
 * 메인트랙 오브젝트 추가
 */
function addVideoTrackVideoObj(id){
	var ffid = $('#' + id).attr('ffid');
	var path = $('#' + id).attr('path');
	var fname = getFileName(path);	
		$.ajax({
		url : 'getVideoInfo',
		type : 'GET',
		data : {
			ffid : ffid
		},
		dataType : 'json',
		success : function(videoInfo) {
			var html = $('#video-track').html();
			var newid = 'video'+'Obj' + video0TrackobjNum;
			video0TrackobjNum++;
			var frames = videoInfo.count/30; 
			html += '<div class="ui-state-default video-obj track-obj" ';
			html += ' frames=' + frames +' ';
			html += ' id=' + newid +' ';
			html += ' itemId=' + id +' ';
			html += ' clicked=' + 'false' +' ';
			html += '>';
			html +=  fname;
			html += '</div>';
			$('#video-track').html(html);
			add_mash(newid, videoInfo.extractPath.replace(/\\/gi, '/') ,videoInfo.count, videoInfo.isAudio);
			resizeTrackObj(0);
			video0TrackEventRemover();
			video0TrackEventRegister();
		},
		error : function(e) {
		}
	});
}

/**
 * 서브트랙 오브젝트 추가
 */
function addSubTrackObj(trackId, id){
	if(video0TrackobjNum == 0){
		return;
	}
	var path = $('#' + id).attr('path');
	var fname = getFileName(path);
	var type = getFileType(path);
	var url = path.substring(2,path.length);
	var html = $('#' + trackId).html();
	var num = subTrackObjNum[trackId]*1;
	num++;
	var newid = trackId + '-' + num;
	subTrackObjNum[trackId] = num;
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
			alert(duration);
			if(type == 'audio') {
				html += '<div class="draggable ui-widget-content ' + trackClass + ' audio-obj other-obj track-obj"';
			}
			else if( type == 'image') {
				html += '<div class="draggable ui-widget-content ' + trackClass + ' image-obj  other-obj track-obj"';
			}
			var thumbId = newid+'image';
			html += ' frames=' + duration +' ';
			html += ' id=' + newid +' ';
			html += ' itemId=' + id +' ';
			html += ' fname=' + fname +' ';
			html += ' trackId=' + trackId +' ';
			html += ' clicked=' + 'false' +' ';
			html += '>';
			html += fname;
			html += '</div>';
			$('#' + trackId).html(html);
			$( ".other-obj" ).draggable({ axis: "x", containment: '#' + trackId, scroll: false });
			var addedClip = add_media(trackId, newid, url, fname, duration);
			$('#' + newid).attr('frame', addedClip.frame);
			resizeSubTrackObj(newid, trackId);
			trackObjEventRegister();
		    $(".draggable").draggable({
		        stop: function() {
		        	updateLocationObj($(this).attr('id'), $(this).attr('trackId'));
		        }
		     });
		},
		error : function(e) {
		}
	});	
}

function resizeTrackObj(maxValue){
	var videoTotalLength = 0;
	var videoTrackObjsCnt = $.makeArray($(".video-obj").map(function(){
	    return $(this).attr("frames");
	}));
	for(var j = 0; j < videoTrackObjsCnt.length; j++){
		videoTotalLength += Number(videoTrackObjsCnt[j]);
	}
	
	if(maxValue != null && maxValue < videoTotalLength)
		maxValue = videoTotalLength;
	
	var trackArr= Object.keys(subTracksDuration);
	for(var i = 0; i < trackArr.length; i++){
		if(subTracksDuration[trackArr[i]] > maxValue)
			maxValue = subTracksDuration[trackArr[i]];
	}
	var totalNumberOfObj = $.makeArray($(".track-obj").map(function(){
	    return $(this).attr("id");   
	}));
	if(maxValue==1) {
		maxValue = 5;
	}
	for(var i = 0; i < totalNumberOfObj.length; i++){
		var thisId = totalNumberOfObj[i];
		var thisCnt = $('#' + thisId).attr('frames');
		var newWidth = ( trackWidth * thisCnt ) / maxValue;
		$('#'+thisId).css({
			'heigth': trackHeight,'width': newWidth
		});	
	}
}

function resizeSubTrackObj(id, trackId){	
	var videoTrackObjsCnt = $.makeArray($(".video-obj").map(function(){
	    return $(this).attr("frames");
	}));
	var totalVideoTrack = 0;
	var thisCnt = $('#' + id).attr('frames');
	for(var j = 0; j < videoTrackObjsCnt.length; j++){
		totalVideoTrack += Number(videoTrackObjsCnt[j]);
	}
	var newWidth = ( trackWidth * thisCnt ) / totalVideoTrack;
	var values = Object.values(subTracksDuration);
	var biggest = -1;
	for (var i = 0; i < values.length; i++) {
		if (values[i] > biggest) {
			biggest = values[i];
		}
	}
	if( biggest > totalVideoTrack){
		resizeTrackObj(biggest);
	} else {
		$('#'+id).css({
			'heigth': trackHeight, 'width': newWidth
		});
	}
}

function updateLocationObj(id, trackId){
	var position = $("#" + id).position();
	var maxDuration = getTotalDur();
	var leftPosition = position.left;
	var unitDuration = maxDuration / trackWidth;
	
	var newFrame = leftPosition * unitDuration;
	if(newFrame < 0) newFrame = 0;
	if(newFrame > maxDuration) newFrame = maxDuration;
	
	var trackInfo = trackId.split('-');
	
	var frame = $("#" + id).attr('frame');
	
	if(trackInfo[0] == 'image') {
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
			if(clips[i].frame == frame){
				index = i;
				break;
			}
		}
		mm_player.mash.audio[trackInfo[1]*1].clips[index].frame = newFrame;
	}
	$("#" + id).attr('frame', newFrame);
	mm_player.change(frame);
}


function videoClipSplit(){
	var audio0Clips = mm_player.mash.audio[0].clips;
	var selectedClip;
	var index = 0;
	for(var i = 0; i < mm_player.mash.video[0].clips.length; i++){
		if(getType(mm_player.mash.video[0].clips[i].id) == 'image') continue;
		if(i==selectedClipNum) {
			selectedClip = audio0Clips[index];
			break;
		}
		index++;
	}
	mm_player.selectedClip = selectedClip;
	mm_player.split();
	var video0Clips = mm_player.mash.video[0].clips;
	selectedClip = video0Clips[selectedClipNum];
	mm_player.selectedClip = selectedClip;
	mm_player.split();
}

function videoTrackSplitEventHandler(){
	$('#split').off('click');
	$('#split').on('click', function(){
		if(getType(mm_player.mash.video[0].clips[selectedClipNum].id) == 'image') return;
		videoClipSplit();
		video0TrackRedraw();
		timeLineSplitEventHandlerRemove();
	});
}

function timeLineSplitEventHandlerRemove(){
	$('#split').off('click');
}

function video0TrackRedraw(){
	video0TrackobjNum = 0;
	var html = '';
	html +='<div id="nno" class="track-name">';
	html +='</div>';
	var mash = mm_player.mash;
	var media = mash.media;
	var video0Clips = mm_player.mash.video[0].clips;
	for(var i = 0; i<video0Clips.length; i++){
		var label = getLabel(video0Clips[i].id);
		
		var newid = 'video'+'Obj' + video0TrackobjNum;
		video0TrackobjNum++;
		
		var itemId = '';
		for(var j = 0; j < media.length; j++){
			if(media[j].id == video0Clips[i].id){
				if (media[j].type == 'image'){
					itemId = media[j].type;
				}else if (media[j].type == 'video'){
					itemId = media[j].type;
				}
				break;
			}
		}	
		var frames = video0Clips[i].frames;
		html += '<div class="ui-state-default video-obj track-obj" ';
		html += ' frames=' + frames +' ';
		html += ' id=' + newid +' ';
		html += ' fname=' + newid +' ';
		html += ' itemId=' + itemId +' ';
		html += ' clicked=' + 'false' +' ';
		html += '>';
		html += label;
		html += '</div>';
	}
	$('#video-track').html(html);
	resizeTrackObj(0);
	timeLineSplitEventHandlerRemove();
	video0TrackEventRemover();
	video0TrackEventRegister();
}

///으아아아아아아  이건 진짜 모르겠다 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ
function reorderingVideo0Clips(videoOrders){
	var video0Clips = mm_player.mash.video[0].clips;
	var newVideo0Clips = [];
	var imgIdxs = [];
	var iidx = 0;
	for(var i = 1; i < videoOrders.length; i++){
		var num = 1 * videoOrders[i].charAt(videoOrders[i].length-1);
		var selectedClip = video0Clips[num];
		newVideo0Clips[i-1] = selectedClip;
		if(getType(selectedClip.id) == 'image') {
			imgIdxs[iidx] = num;
			iidx++;
		}
	}
	var preFrame = 0;
	for(var i = 0; i < newVideo0Clips.length; i++){
		
		newVideo0Clips[i].frame = preFrame;
		preFrame = preFrame + newVideo0Clips[i].frames;
	}
	var removeImgAudioOrders = reorderingAudio0(videoOrders, imgIdxs);
	var audio0Clips = mm_player.mash.audio[0].clips;
	var newAudio0Clips = [];
	
	for(var i = 0; i < removeImgAudioOrders.length; i++){

		newAudio0Clips[i] = audio0Clips[removeImgAudioOrders[i]];
	}
	
	var index = 0;
	for(var i = 0; i < newVideo0Clips.length; i++){
		if( getType(newVideo0Clips[i].id) == 'image') continue;
		newAudio0Clips[index].frame = newVideo0Clips[i].frame;
		newAudio0Clips[index].trim = newVideo0Clips[i].trim;
		newAudio0Clips[index].frames = newVideo0Clips[i].frames;
		index++;
	}
	
	mm_player.mash.video[0].clips = newVideo0Clips;
	mm_player.mash.audio[0].clips = newAudio0Clips;
	
	for(var i = 0; i < mm_player.mash.video[0].clips.length; i++){
		mm_player.selectedClip = mm_player.mash.video[0].clips[i];
		mm_player.change('frames');
	}
	
	for(var i = 0; i < mm_player.mash.audio[0].clips.length; i++){
		mm_player.selectedClip = mm_player.mash.audio[0].clips[i];
		mm_player.change('frames');
	}
	
	video0TrackRedraw();
	
}
function reorderingAudio0(videoOrders, imgIdxs){
	var rtn = [];
	var idx = 0;
	for(var i = 1; i < videoOrders.length; i++){
		var num = 1 * videoOrders[i].charAt(videoOrders[i].length-1);
		
		var cont = true;
		var num2 = num;
		for(var j = 0; j < imgIdxs.length; j++){
			if(num == imgIdxs[j]) {
				cont=false;
				break; 
			}
			if(num > imgIdxs[j]) num2--;
		}
		
		if(cont == false) continue;
		
		rtn[idx] = num2;
		idx++;
	}
	return rtn;
}

//오브젝트 선택
function trackObjEventRegister(){
	$('.other-obj').off('click');
	$('.other-obj').on('click', function(e) {
		
		var clicked = $(this).attr('clicked');
		
		if(clicked == 'false') {
			$(this).css({'border-color': '#fff'});
			$(this).attr('clicked', 'true');
			
			clickedObj = $(this).attr('id');
			var trackId = $(this).attr('trackId');
			var idInfo = clickedObj.split('-');
			if(idInfo[0] == 'audio'){
				audioTrackSplitEventHandler();
			} 
			seletedFreeOtherObj();
			
		}
		else {
			$(this).css({'border-color': '#2e2e2e'});
			$(this).attr('clicked', 'false');
			timeLineSplitEventHandlerRemove();
			clickedObj = '';
		}
	});
}

//Mute 기능
$(function(){
	$('#mute').on('click',function(e){
		var volume = mm_player.mash.audio[0].clips;
		alert(volume[selectedClipNum].gain);
		if (volume[selectedClipNum].gain == 1) {
			mm_player.mash.audio[0].clips[selectedClipNum].gain = 0;
		}else{
			mm_player.mash.audio[0].clips[selectedClipNum].gain = 1;
		}
		mm_player.__adjust_gain(mm_player.mash.audio[0].clips);
	});
});

function reAssignUiId(videoOrders, removeIdx){
	var newVideoOrders = [];
	newVideoOrders[0] = '';
	var idx = 1;
	for(var i = 1; i<videoOrders.length; i++){
		var num = 1 * videoOrders[i].charAt(videoOrders[i].length-1);
		if(num == removeIdx) {
			$('#' + videoOrders[i]).attr('frames', 0);
			continue;
		}
		var newIdx = 0;
		if(num > removeIdx) newIdx = num - 1;
		else newIdx=  num;
			
		var newid = 'video'+'Obj' + newIdx;
		$('#' + videoOrders[i]).attr('id', newid);
		newVideoOrders[idx] = newid;
		idx++;
	}

	return newVideoOrders;
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
    	var idsInOrder = $("#video-track").sortable("toArray");
    	var newIdsInOrder =  reAssignUiId(idsInOrder, selectedClipNum);
    	clickedObj = '';
    	selectedClipNum = 0;
    	reorderingVideo0Clips(newIdsInOrder);	
		timeLineSplitEventHandlerRemove();
		videoTotalDuration -= selectedClip.frames;
	}
	else if( track == 'image' || track == 'audio' ){
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
		
    	clickedObj = '';
    	selectedClipNum = 0;
    	subTracksDuration[trackId] = subTracksDuration[trackId] - selectedClip.frames;
		reDrawTrackAfterRemove(trackId, objId);
		$( ".other-obj" ).draggable({ axis: "x", containment: '#' + trackId, scroll: false });
		trackObjEventRegister();
	    $( ".draggable" ).draggable({
	        stop: function() {
	        	updateLocationObj($(this).attr('id'), $(this).attr('trackId'));
	        }
	     });
	}
	var trackArr= Object.keys(subTracksDuration);
	for(var i = 0; i < trackArr.length; i++){
		otherObjMove(trackArr[i]);
	}
}
function reDrawTrackAfterRemove(trackId, objId){
	var trackArr = $('#' + trackId);
	var newHtml = '';
	for (var i = 0; i < trackArr[0].children.length; i++) {
		if(trackArr[0].children[i].outerHTML == $('#' + objId)[0].outerHTML){
			continue;
		}
		
		newHtml += trackArr[0].children[i].outerHTML;
	}
	
	$('#' + trackId).html(newHtml);
	
	subTrackObjNum[trackId] = subTrackObjNum[trackId] - 1;
}


function otherObjMove(track){
	var max = getTotalDur();
	var unit = trackWidth / max;
	
	var idOfObj = $.makeArray($('.' + track + '-obj').map(function(){
	    return $(this).attr("id");
	}));
	for(var i = 0; i < idOfObj.length; i++){
		var left = unit * $('#' + idOfObj[i]).attr('frame') ;
		var width = unit * $('#' + idOfObj[i]).attr('frames');
		var right = left + width;
		
		$("#" + idOfObj[i]).parent().css({position: 'relative'});
		$("#" + idOfObj[i]).css({left: left, width: width, position:'absolute'});
	}
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