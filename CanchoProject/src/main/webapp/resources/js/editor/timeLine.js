
var trackWidth =926;
var trackHeight = 70;

var clickedObj;
var selectedClipNum = 0;
var video0TrackobjNum = 0;

function checkFileType(data){
	if(data.indexOf("video") != -1) return 'video';
	if(data.indexOf("audio") != -1) return 'audio';
	if(data.indexOf("image") != -1) return 'image';
	if(data.indexOf("filter") != -1) return 'filter';
	if(data.indexOf("transition") != -1) return 'transition';
}

function resizeTrackObj(maxValue){
	//
	var videoTrackObjsCnt = $.makeArray($(".video-obj").map(function(){
		//if($(this).attr('itemId').indexOf('transition') != -1) return -1 * ($(this).attr("frames"));
	    return $(this).attr("frames");
	}));
	
	var videoTrackTotalCnt = 0;
	
	for(var j = 0; j < videoTrackObjsCnt.length; j++){
		videoTrackTotalCnt += Number(videoTrackObjsCnt[j]);
	}
	
	if(maxValue != null && maxValue < videoTrackTotalCnt)
		maxValue = videoTrackTotalCnt;
	
	var trackArr= Object.keys(tracksDuration);
	for(var i = 0; i < trackArr.length; i++){
		if( tracksDuration[trackArr[i]] > maxValue )
			maxValue = tracksDuration[trackArr[i]];
	}	
	
	var IdsOftrackObjs = $.makeArray($(".track-obj").map(function(){
	    return $(this).attr("id");
	}));
	
	//alert(maxValue);
	if(maxValue==1) maxValue = 2;
	for(var i = 0; i < IdsOftrackObjs.length; i++){
		var thisId = IdsOftrackObjs[i];
		var thisCnt = $('#' + thisId).attr('frames');
		var newWidth = ( trackWidth * thisCnt ) / maxValue;
		$('#'+thisId).css({	
							'heigth': trackHeight,
							'width': newWidth
		});
		
	}
}

function video0TrackEventRemover(){
	$('.video-obj').off('click');
	
	
}

function seletedFreeOtherObj(){
	var IdsOftrackObjs = $.makeArray($(".track-obj").map(function(){
	    return $(this).attr("id");
	}));
	//alert(IdsOftrackObjs.length);
	//alert(clickedObj);
	for(var i = 0; i < IdsOftrackObjs.length; i++){
		var thisId = IdsOftrackObjs[i];
		if(clickedObj == thisId) continue;
		$('#' + thisId).css({'border-color': '#2e2e2e'});
		$('#' + thisId).attr('clicked', 'false');
	}	
}

function clearEditor(){
	var html = '';
	w2ui.timeLine.content('right', html);
}


//비디오 상세 설정창(라벨, 점프, 볼륨, 필터 등)
function outputVideoEditor(){
	
	var video0Clips = mm_player.mash.video[0].clips;
	var selectedClip = video0Clips[selectedClipNum];
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
	htmlt += '<table id="editorBox">';
	htmlt += '<tr>';
	htmlt += '<td><div>Label </div></td>';
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
		$('#editor_jump').attr('min', 0);
		$('#editor_jump').attr('value', trim.toFixed(2));
		$('#editor_jump').attr('step', 1);
		
		$('#editor_time').attr('max', duration.toFixed(2));
		
		var index = 0;
		for(var i = 0; i < mm_player.mash.video[0].clips.length; i++){
			//alert(JSON.stringify(selectedVideoClip));
			if( getType(mm_player.mash.video[0].clips[i].id) == 'image' ||
				getType(mm_player.mash.video[0].clips[i].id) == 'transition' 	) continue;
			if(i==selectedClipNum) {
				var vol = mm_player.mash.audio[0].clips[index];
				document.getElementById('editor-vol').value = vol;
				break;
			}
			index++;
		}
	}
	
	mm_player.selectedClip = selectedClip;
	
	if( label != 'Crossfade') {
		outputEditorFilters(selectedClip);
	}
	
	FilterBoxDragDropEventHandler();
	$('#editor_time').attr('min', 0);
	$('#editor_time').attr('value', frames.toFixed(2));
	$('#editor_time').attr('step', 1);
	
	editorUnbinder();
	editorBinder();
}

function editorUnbinder(){
	$("#editor_jump").unbind( 'change mouseup');
	$("#editor_time").unbind( 'change mouseup');
}

function volumeControll(){
	if(clickedObj == '') return;
	var value = document.getElementById('editor-vol').value;
	var index = 0;
	for(var i = 0; i < mm_player.mash.video[0].clips.length; i++){
		//alert(JSON.stringify(selectedVideoClip));
		if( getType(mm_player.mash.video[0].clips[i].id) == 'image' ||
				getType(mm_player.mash.video[0].clips[i].id) == 'transition'	) continue;
		if(i==selectedClipNum) {
			mm_player.mash.audio[0].clips[index].gain = value;
			
			mm_player.__adjust_gain(mm_player.mash.audio[0].clips);
			break;
		}
		index++;
	}
}

function editorBinder(){
	$("#editor_jump").bind('change mouseup', function () {
		addUndoArr(mm_player.mash);
		var video0Clips = mm_player.mash.video[0].clips;
		var selectedClip = video0Clips[selectedClipNum];
		
		var jump = selectedClip.trim*1;
		var time = selectedClip.frames*1;
		var sum = jump + time;
		
		//alert(sum);
		var newJump = 1*document.getElementById("editor_jump").value;
		var newTime = sum - newJump;

		$('#editor_time').attr('value', newTime);
		//$('#e-time').attr('max', newTime);
		
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
			//alert(JSON.stringify(selectedVideoClip));
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
		setMash();
	});
	
	$("#editor_time").bind('change mouseup', function () {
		addUndoArr(mm_player.mash);
		var newTime = 1*document.getElementById("editor_time").value;

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

//클릭 및 클릭 해제
function video0TrackEventRegister(){
	$('.video-obj').on('click', function(e) {
		//alert("haha");
		//alert($(this).html());
		var clicked = $(this).attr('clicked');
		
		if(clicked == 'false') { //클릭되었을때
			$(this).css({'border-color': '#fff'});
			$(this).attr('clicked', 'true');
/*			
			var video0Clips = mm_player.mash.video[0].clips;
			selectedClip = video0Clips[selectedClipNum];
			mm_player.selectedClip = selectedClip;*/
			
			videoTrackSplitEventHandler();
			
			clickedObj = $(this).attr('id');
			selectedClipNum = 1 * clickedObj.charAt(clickedObj.length-1);
			outputVideoEditor();
			
			seletedFreeOtherObj();
			
		}
		else { //클릭 해제 되었을때
			$(this).css({'border-color': '#2e2e2e'});
			$(this).attr('clicked', 'false');
			timeLineSplitEventHandlerRemove();
			clickedObj = '';
			selectedClipNum = 0;
			clearEditor();
		}
	});
}

function getLabel(id){
	//alert(id);
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

function video0TrackRedraw(){
	video0TrackobjNum = 0;
	var html = '';
	html +=			'<span class="track-name">';
	html +=				'<i class="fa fa-video-camera" aria-hidden="true"></i>';
	html +=			'</span>';
	var mash = mm_player.mash;
	var media = mash.media;
	
	var video0Clips = mm_player.mash.video[0].clips;
//	alert("redraw");
//	alert(JSON.stringify(video0Clips));
	
	for(var i = 0; i<video0Clips.length; i++){
		//alert(JSON.stringify(video0Clips));
		var label = getLabel(video0Clips[i].id);
		
		var newid = 'video'+'Obj' + video0TrackobjNum;
		video0TrackobjNum++;
		
		var thumbPath = '';
		var itemId = '';
		for(var j = 0; j < media.length; j++){
			if(media[j].id == video0Clips[i].id){
				//alert(JSON.stringify(media[j].type));
				if (media[j].type == 'image'){
					itemId = media[j].type;
					thumbPath = getThumbPath(media[j].url);
				}else if (media[j].type == 'video'){
					itemId = media[j].type;
					thumbPath = media[j].url + '000000150.jpg';
				}else if (media[j].type == 'transition'){
					itemId = media[j].type;
				}
				break;
			}
		}
		
		var frames = video0Clips[i].frames;
		if (i+1 < video0Clips.length && getType(video0Clips[i+1].id) == 'transition'){
			//alert("hjah");
			frames = video0Clips[i].frames - (video0Clips[i+1].frames);
		}
		else if (i > 0 &&getType(video0Clips[i-1].id) == 'transition'){
			//alert("hjah");
			frames = (video0Clips[i].frames - video0Clips[i-1].frames);
		}
		
		if(itemId ==  'transition')
			html += '<div class="ui-state-default trans-obj video-obj track-obj" ';
		else
			html += '<div class="ui-state-default video-obj track-obj" ';
		html += ' frames=' + frames +' ';
		html += ' id=' + newid +' ';
		html += ' fname=' + newid +' ';
		html += ' itemId=' + itemId +' ';

		html += ' clicked=' + 'false' +' ';
		html += '>';
		html += '<img class="obj-thumb" src="' + thumbPath + '">'
		html += label;
		html += '</div>';
	}
	
	$('#video-track').html(html);
	resizeTrackObj(0);
	timeLineSplitEventHandlerRemove();
	video0TrackEventRemover();
	video0TrackEventRegister();
	selectedRedraw();
}

function selectedRedraw(){
	if(clickedObj=='') return;
	
	$('#' + clickedObj).css({'border-color': '#fff'});
	$('#' + clickedObj).attr('clicked', 'true');
	
	videoTrackSplitEventHandler();
	
	//clickedObj = $(this).attr('id');
	//selectedClipNum = 1 * clickedObj.charAt(clickedObj.length-1);
	outputVideoEditor();
	//seletedFreeOtherObj();
}

function changeSelectedClip(){
	var audio0Clips = mm_player.mash.audio[0].clips;
	var selectedClip;
	var index = 0;
	for(var i = 0; i < mm_player.mash.video[0].clips.length; i++){
		//alert(JSON.stringify(selectedVideoClip));
		if( getType(mm_player.mash.video[0].clips[i].id) == 'image' ||
				getType(mm_player.mash.video[0].clips[i].id) == 'transition') continue;
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
		//alert("video split");
		addUndoArr(mm_player.mash);
		if(getType(mm_player.mash.video[0].clips[selectedClipNum].id) == 'image' ||
				getType(mm_player.mash.video[0].clips[selectedClipNum].id) == 'transition' 	) return;
		changeSelectedClip();
		video0TrackRedraw();
		timeLineSplitEventHandlerRemove();
		clearEditor();
		setMash();
	});
}

function timeLineSplitEventHandlerRemove(){
	$('#split').off('click');
}

function addVideoTrackVideoObj(id){
	
	var ffid = $('#' + id).attr('ffid');
	//var fname = getFileName(path);
	//alert(ffid);
	var path = $('#' + id).attr('path');
	var fname = getFileName(path);
	//alert(path);
	var thumbPath = getThumbPath(path);
	//alert(thumbPath);
	$.ajax({
		url : 'getVideoInfo',
		type : 'GET',
		data : {
			ffid : ffid
		},
		dataType : 'json',
		success : function(videoInfo) {
			//alert(videoInfo.count);
			var html = $('#video-track').html();
			//alert(html);
			var newid = 'video'+'Obj' + video0TrackobjNum;
			video0TrackobjNum++;
			html += '<div class="ui-state-default video-obj track-obj" ';
			html += ' frames=' + videoInfo.count/30 +' ';
			html += ' id=' + newid +' ';
			html += ' fname=' + fname +' ';
			html += ' itemId=' + id +' ';
			//html += ' path=' + videoInfo.extractPath +' ';
			html += ' clicked=' + 'false' +' ';
			html += '>';
			html += '<img class="obj-thumb" src="' + thumbPath + '">'
			html +=  fname;
			html += '</div>';
			
			$('#video-track').html(html);
			add_video0(newid, videoInfo.extractPath.replace(/\\/gi, '/') ,videoInfo.count, fname, videoInfo.isAudio);
			resizeTrackObj(0);
			video0TrackEventRemover();
			video0TrackEventRegister();
			//alert(JSON.stringify(mm_player.mash.video[0].clips));
		},
		error : function(e) {
			//alert(JSON.stringify(e));
		}
	});	
}

function addVideoTrackImageObj(id){
	var path = $('#' + id).attr('path');
	var fname = getFileName(path);
	var thumbPath = getThumbPath(path);
	
	//alert(fname);
	//var result = s.replace(/oo/gi, 'ZZ');
	var url = path.substring(2,path.length);
	//alert(url);
	var html = $('#video-track').html();
	var newid = 'video'+'Obj' + video0TrackobjNum;
	video0TrackobjNum++;
	html += '<div class="ui-state-default video-obj track-obj" ';
	html += ' frames=' + 2 +' ';
	html += ' id=' + newid +' ';
	html += ' itemId=' + id +' ';
	//html += ' path=' + url +' ';
	html += ' fname=' + fname +' ';
	html += ' clicked=' + 'false' +' ';
	html += '>';
	html += '<img class="obj-thumb" src="' + thumbPath + '">'
	html += fname;
	html += '</div>';
	
	$('#video-track').html(html);
	add_video0img(newid, url, fname, false);
	resizeTrackObj(0);
	video0TrackEventRemover();
	video0TrackEventRegister();
}

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
		
/*		if(checkFileType(data) == 'transition'){
			
			mm_player.add(effects['CrossFade'], 'transition', 0);
			alert(JSON.stringify(mm_player.mash, null, '\t'));
		
			
		}*/
		addUndoArr(mm_player.mash);
		//여기다가 할일을 
		if(checkFileType(data) == 'video') {
			addVideoTrackVideoObj(data);
			//setMash();
		} else if(checkFileType(data) == 'image'){
			addVideoTrackImageObj(data);
			//setMash();
		} 
		else if(checkFileType(data) == 'transition'){
			addVideoTrackTransitionsObj(data);
			//setMash();
		}
		
	});
	
	$('#video-track').on('dragleave dragend', function(e) {
		e.preventDefault();
		$(this).css('border', '0px');
	});	
}


function addVideoTrackTransitionsObj(id){

	var html = $('#video-track').html();
	var newid = 'video'+'Obj' + video0TrackobjNum;
	video0TrackobjNum++;
	html += '<div class="ui-state-default trans-obj video-obj track-obj" ';
	html += ' frames=' + 1 +' ';
	html += ' id=' + newid +' ';
	html += ' itemId=' + id +' ';
	//html += ' path=' + url +' ';
	html += ' clicked=' + 'false' +' ';
	html += '><p><i class="fa fa-exchange fa-1x" aria-hidden="true"> Crossfade</i></p></div>';
	
	$('#video-track').html(html);
	add_transition();
	resizeTrackObj(0);
	video0TrackEventRemover();
	video0TrackEventRegister();	
	
}

function otherTrackDragDropEventHandler(trackId, type){
	$('#' + trackId).on('dragenter dragover', function(e) {
		e.preventDefault();
		$('#' + trackId + '-cont').css('border', '2px solid #ff0080');
	});
	
	$('#' + trackId).on('drop', function(e) {
		addUndoArr(mm_player.mash);
		e.preventDefault();
		$('#' + trackId + '-cont').css('border', '0px');
		var data = e.originalEvent.dataTransfer.getData("text");
		//alert(data);
		if(data=='') return;
		
		if( checkFileType(data) != type) return;
			
		//alert(type);
		addObj(trackId, data );
		
		//setMash();
	});
	
	$('#' + trackId).on('dragleave dragend', function(e) {
		e.preventDefault();
		$('#' + trackId + '-cont').css('border', '0px');
	});	
}

function trackDragAndDropEventHander(){
	videoDragDropEventHandler();
	
	var trackArr= Object.keys(tracksDuration);
	for(var i = 0; i < trackArr.length; i++){
		var splited = trackArr[i].split('-');
		//alert(trackArr[i]);
		//alert(splited[0]);
		var type = '';
		if(splited[0] == 'video') type = 'image';
		else if(splited[0] == 'audio') type = 'audio';
		otherTrackDragDropEventHandler(trackArr[i], type);
	}
}

function drag(ev) {
    ev.dataTransfer.setData("text", ev.target.id);
}

//오디오 섞일때 순서를 잡아주는 부분
function reorderingAudio0(videoOrders, imgIdxs){
	//alert(JSON.stringify(videoOrders));
	//alert(JSON.stringify(imgIdxs));
	var rtn = [];
	var idx = 0;
	for(var i = 1; i < videoOrders.length; i++){
		var num = 1 * videoOrders[i].charAt(videoOrders[i].length-1);
		
		var cont = true;
		var num2 = num;
		for(var j = 0; j < imgIdxs.length; j++){
			//alert(num + ' -> num' );
			//alert(imgIdxs[j] + ' -> imgIdxs[j]' );
			if(num == imgIdxs[j]) {
				//alert(num + ', ' + imgIdxs[j]);
				cont=false;
				break; 
			}
			if(num > imgIdxs[j]) num2--;
		}
		
		if(cont == false) continue;
		
		rtn[idx] = num2;
		idx++;
	}
	
	//alert(JSON.stringify(rtn));
	return rtn;
}

//아이디 숫자 다 가져와
//중간에 없는 숫자 찾아
//2번이 없다면 3번부터 -1 해서 아이디 새로 붙여줘.

function reAssignUiId(videoOrders, removeIdx){
	
	//alert(videoOrders);
	var newVideoOrders = [];
	newVideoOrders[0] = '';
	var idx = 1;
	for(var i = 1; i<videoOrders.length; i++){
		var num = 1 * videoOrders[i].charAt(videoOrders[i].length-1);
		if(num == removeIdx) {
			//alert("들어오니");
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
	
	
	//alert(newVideoOrders);
	return newVideoOrders;
}

//여러 비디오들을 섞을때 순서를 다시 바로 잡아주는 역할
function reorderingVideo0Clips(videoOrders){
	//alert(videoOrders);
	var video0Clips = mm_player.mash.video[0].clips;
	var newVideo0Clips = [];
	var newTimeInfo = new Array(video0Clips.length);
	
	//alert(JSON.stringify(video0Clips));
	
	var imgIdxs = [];
	var iidx = 0;
	for(var i = 1; i < videoOrders.length; i++){
		var num = 1 * videoOrders[i].charAt(videoOrders[i].length-1);
		//alert(videoOrders[i] + ': ' + num);
		var selectedClip = video0Clips[num];
		//alert(JSON.stringify(selectedClip));
		newVideo0Clips[i-1] = selectedClip;
		
		//alert(getType(selectedClip.id));
		if(getType(selectedClip.id) == 'image' || getType(selectedClip.id) == 'transition') {
			imgIdxs[iidx] = num;
			iidx++;
		}
	}
	
	var preFrame = 0;
	for(var i = 0; i < newVideo0Clips.length; i++){
	
		if(getType(newVideo0Clips[i].id) == 'transition') {
			var frames = newVideo0Clips[i].frames;
			var newFrames = preFrame - frames;
			if(newFrames < 0) newFrames = 0;
			newVideo0Clips[i].frame = newFrames;
			preFrame = newFrames;
			continue;
		}
		
		newVideo0Clips[i].frame = preFrame;
		//if(getType(newVideo0Clips[i].id) == 'transition') continue;
		preFrame = preFrame + newVideo0Clips[i].frames;
	}
	//alert(JSON.stringify(newVideo0Clips));
	
	var removeImgAudioOrders = reorderingAudio0(videoOrders, imgIdxs);
	
	//audio
	//alert(removeImgAudioOrders);
	var audio0Clips = mm_player.mash.audio[0].clips;
	var newAudio0Clips = [];
	
	for(var i = 0; i < removeImgAudioOrders.length; i++){

		newAudio0Clips[i] = audio0Clips[removeImgAudioOrders[i]];
	}
	
	var index = 0;
	for(var i = 0; i < newVideo0Clips.length; i++){
		if( getType(newVideo0Clips[i].id) == 'image' || getType(newVideo0Clips[i].id) == 'transition') continue;
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
	
//	mm_player.change('frame');
	video0TrackRedraw();
}

function getType(id){
	//alert(id);
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

function getUrl(id){
	//alert(id);
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


