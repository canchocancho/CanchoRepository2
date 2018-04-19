var selectedClipNum;



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
	
	/*editorUnbinder();
	editorBinder();*/
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
        	setMash()
        }
    });
}