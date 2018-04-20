var order = 'odd';
var vorder = 3;
var aorder = 3;
var clickedObj;


function delIndiFile(delFileName) {
	$.ajax({
		type:"POST"
		,url: "deleteIndiFile"
		,success: function() {
		}
		,error: function(e) {
			console.log(e);
		}
		
	}); 
}

function delAll() {
	$.ajax({
		type:"GET"
		,url: "deleteAllFiles"
		,success: function() {
		}
		,error: function(e) {
			console.log(e);
		}
	});
}

$(function(){
	$("#imgBtn").on("click",function(){		
		var selectedType = $('#selectedFile').val();
		var formData = new FormData();
		formData.append("file",$("#upload")[0].files[0]);
		formData.append("fileType", selectedType);
		$.ajax({
			type:"POST",						
			url:"fileupload",				
			data: formData,
			processData: false,
		    contentType: false,
		    dataType : "text",				
			success:function(data){
				$.ajax({
					type:"POST"
					,url: "getFileList"
					,datatype: "json"
					,success: function(data) {
							var str = "";
							for(var li in data) {
								str += "<div draggable=\"true\" ondragstart=\"drag(event)\">" + data[li] + "<button class=\"IndiFile\" filen=\"" + data[li] + "\">Delete</button></div>"
							}
							str += "<div id=\"deleteAllBox\"><button id=\"deleteAll\">DeleteAll</button></div>";
							$('#fileListBox').html(str);
							$('.IndiFile').on('click', function() {
								var delFileName = $(this).attr("filen");
								delIndiFile(delFileName);
							});
							$('#deleteAll').on('click', function() {
								delAll();
							});
					}
					,error: function(e) {
						console.log(e);
					}
				});
			},
			error: function(e){			
				console.log(e);
			}
		});
	});
});


$.ajax({
	type:"POST"
	,url: "getFileList"
	,datatype: "json"
	,success: function(data) {
			alert("그래");
			var str = "";
			for(var li in data) {
				str += "<div>" + data[li] + "<button class=\"IndiFile\" filen=\"" + data[li] + "\">Delete</button></div>"
			}
			str += "<div id=\"deleteAllBox\"><button id=\"deleteAll\">DeleteAll</button></div>";
			$('#fileListBox').html(str);
			$('.IndiFile').on('click', function() {
				var delFileName = $(this).attr("filen");
				console.log("the fileName is " + delFileName);
				delIndiFile(delFileName);
			});
			$('#deleteAll').on('click', function() {
				delAll();
			});
			outputFileList(data);
			
	}
	,error: function(e) {
		console.log(e);
	}
});

/**
 * 볼륨 조절
 */
function volumeControll(){
	if(clickedObj == '') return;
	var value = document.getElementById('editor-vol').value;
	var index = 0;
	for(var i = 0; i < mm_player.mash.video[0].clips.length; i++){
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

function outputFileList(list){
	var contents = '<div id="dragDropZone">';
	
	$.each(list,function(index, item) {
		contents += '<table class="fileBox"><tr><td class="fimage">';
		contents += '';
		var path = item;
			var pathArray = path.split('\\');
			var imgPath = './tomolog/';
			for (var j = 2; j < pathArray.length; j++) {
				imgPath += pathArray[j];
				if(j < (pathArray.length-1) ) {
					imgPath += '/';
				}
			}
			var fileType = getFileType(item);
		/*	if( fileType == 'image'){
				contents += '<img id="image' + index + '" ondragstart="drag(event)" draggable="true" class="file fimage-editor" path="' + imgPath + '" src="' + thumbPath +'">';
			}
			else */if(fileType == 'video'){
				
				var p = item;
				var videoPathrray = p.split('\\');
				var videoPath = './tomolog/';
				for (var j = 2; j < videoPathrray.length; j++) {
					videoPath += videoPathrray[j] ;
					if(j < (videoPathrray.length-1) )
						videoPath += '/';
				}
				
				contents += '<video id="video' + index 
						 + '" draggable="true" ondragstart="drag(event)" ' 
						 + 'path="' + videoPath + '" '
						 + 'width=156 height=auto controls'
						 + '>';
				contents +=   '<source src="' + videoPath + '" type="video/mp4">';
				contents +=   '<source src="' + videoPath + '" type="video/ogg">';
				contents +=   '<source src="' + videoPath + '" type="video/webm">';
				contents +=   'Your browser does not support the video tag.';
				contents += '</video>';
			}
			/*else if(fileType == 'audio'){
				
				var p = item.path;
				var audioPathrray = p.split('\\');
				var audioPath = './storageResources/';
				for (var j = 2; j < audioPathrray.length; j++) {
					audioPath += audioPathrray[j] ;
					if(j < (audioPathrray.length-1) )
						audioPath += '/';
				}
				contents +='<img draggable="true" ondragstart="drag(event)" ffid="' + item.ffid + '" path="' + audioPath + '" id="audio' + index + '">';
				contents +='<audio controls>';
				contents +='  <source src=' + audioPath + ' type="audio/mpeg">';
				contents +='  Your browser does not support the audio tag.';
				contents +='</audio>';
				  
			}*/
		contents += '</td></tr>';
	});
	
	contents += '</div>';
	
	$('#fileBox').html(contents);
	
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
