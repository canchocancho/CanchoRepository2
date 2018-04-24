var vorder = 3;
var aorder = 3;
var clickedObj;
var cnt = 0;

/**
 * 개별 파일 삭제
 */
function delIndiFile(fileName, fileType, fileExt) {
	   
	   var fileName = fileName;
	   var fileType = fileType;
	   var fileExt = fileExt;
	   
	   $.ajax({
	      type:"POST"
	      ,url: "delIndiFile"
	      ,data: {
	         fileName : fileName
	         ,fileType : fileType
	         ,fileExt : fileExt
	      }
	      ,success: function() {
	         $.ajax({
	               type:"POST"
	               ,url: "getFileList"
	               ,datatype: "json"
	               ,success: function(data) {
	                     outputFileList(data);
	               }
	               ,error: function(e) {
	                  console.log(e);
	               }
	            });
	      }
	      ,error: function(e) {
	         console.log(e);
	      }
	      
	   }); 
	}
/**
 * 전체 파일 삭제
 */
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

/**
 * 파일 업로드
 */
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
							outputFileList(data);
					}
					,error: function(e) {
						console.log(e);
					}
				});
				$('#upload').val("");
			},
			error: function(e){			
				console.log(e);
			}
		});
	});
	$('#selectedFile').on('change', function(){
	      $.ajax({
	            type:"POST"
	            ,url: "getFileList"
	            ,datatype: "json"
	            ,success: function(data) {
	                  outputFileList(data);
	            }
	            ,error: function(e) {
	               console.log(e);
	            }
	         });
	   });
});


/**
 * 파일 리스트 자동갱신
 */
$.ajax({
	type:"POST"
	,url: "getFileList"
	,datatype: "json"
	,success: function(data) {
			outputFileList(data);
	}
	,error: function(e) {
		console.log(e);
	}
});

/**
 * 파일 리스트 불러오기
 */
function outputFileList(list){
	   var contents_i = '<div id="dragDropZone">';
	   var contents_v = '<div id="dragDropZone">';
	   var contents_a = '<div id="dragDropZone">';
	   
	   var selectBox = $('#selectedFile').val();
	   
	   if(list == null) {
	      cnt = 1;
	   }
	   else {
	      cnt = 2;
	   }
	   $.each(list,function(index, item) {
	         console.log(cnt);
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
	         var lastOfIndex = pathArray[pathArray.length-1].lastIndexOf(".");
	         var fileName = pathArray[pathArray.length-1].substring(0,lastOfIndex);
	         var fileExt = pathArray[pathArray.length-1].substring(lastOfIndex,pathArray[pathArray.length-1].length);
	         if(cnt == 2) {
	            if(selectBox == 'image') {
	               if( fileType == 'image'){
	            	  contents_i += '<table class="fileBox"><tr><td class="fimage">';
	                  contents_i += '<img id="image' + index + '" ondragstart="drag(event)" draggable="true" class="file fimage-editor" path="' + imgPath + '" src="' + imgPath +'" width = "100" height = "100">';
	                  contents_i += '</td></tr><tr><td>'
	                  contents_i += '<img src="resources/images/cancelCon.png" width="20px" height="20px" onclick="delIndiFile(\''+fileName+ '\',\'' + fileType + '\',\'' + fileExt + '\')">';
	               }
	               contents_i += '</td></tr></table>';
	            }
	            
	            if(selectBox == 'video') {
	               if(fileType == 'video'){
	            	   contents_v += '<table class="fileBox"><tr><td class="fimage">';
	            	   var p = item;
	            	   var videoPathrray = p.split('\\');
	            	   var videoPath = './tomolog/';
	               for (var j = 2; j < videoPathrray.length; j++) {
	                  videoPath += videoPathrray[j] ;
	                  if(j < (videoPathrray.length-1) )
	                     videoPath += '/';
	               }
	               
	               contents_v += '<video id="video' + index 
	                      + '" draggable="true" ondragstart="drag(event)" ' 
	                      + 'path="' + videoPath + '" '
	                      + 'ffid="' + fileName + '" '
	                      + 'width=156 height=auto controls'
	                      + '>';
	               contents_v += '<source src="' + videoPath + '" type="video/mp4">';
	               contents_v += '<source src="' + videoPath + '" type="video/ogg">';
	               contents_v += '<source src="' + videoPath + '" type="video/webm">';
	               contents_v += 'Your browser does not support the video tag.';
	               contents_v += '</video></td></tr><tr><td>';
	               contents_v += '<img src="resources/images/cancelCon.png" width="20px" height="20px" onclick="delIndiFile(\''+fileName+ '\',\'' + fileType + '\',\'' + fileExt + '\')">';
	                }
	               contents_v += '</td></tr></table>';
	            }
	            if(selectBox == 'audio') {
	               if(fileType == 'audio'){
	            	  contents_a += '<table class="fileBox"><tr><td class="fimage">';
	                  var p = item;
	                  var audioPathrray = p.split('\\');
	                  var audioPath = './tomolog/';
	                  for (var j = 2; j < audioPathrray.length; j++) {
	                     audioPath += audioPathrray[j] ;
	                     if(j < (audioPathrray.length-1) )
	                        audioPath += '/';
	                  }
	                  contents_a +='<img src="resources/img/audio.png" width = "100" height = "100" draggable="true" ondragstart="drag(event)" ffid="' + item.ffid + '" path="' + audioPath + '" id="audio' + index + '">';
	                  contents_a +='<audio controls>';
	                  contents_a +='  <source src=' + audioPath + ' type="audio/mpeg">';
	                  contents_a +='  Your browser does not support the audio tag.';
	                  contents_a +='</audio></td></tr><tr><td>';   
	                  contents_a += '<img src="resources/images/cancelCon.png" width="20px" height="20px" onclick="delIndiFile(\''+fileName+ '\',\'' + fileType + '\',\'' + fileExt + '\')">';
	               }
	               contents_a += '</td></tr></table>';
	            }
	            
	         }
	   });
	   
	   contents_i += '</div>';
	   contents_v += '</div>';
	   contents_a += '</div>';
	   
	   if(selectBox == 'image') {
	      $('#fileBox').html(contents_i);
	   }
	   
	   if(selectBox == 'video') {
	      $('#fileBox').html(contents_v);
	   }
	   
	   if(selectBox == 'audio') {
	      $('#fileBox').html(contents_a);
	   }
	   
	   
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
	      $.colorbox({maxWidth:"75%", maxHeight:"75%", href:path});
	   });
	}

function timeLineMenuEventHandler(){
	$('#delete').off('click');
	$('#delete').on('click', function(){
		selectedObjDelete(clickedObj);
	});
	$('#clear').off('click');
	$('#clear').on('click', function(){
		var videoTrackIds = $.makeArray($(".video-obj").map(function(){
		    return $(this).attr("id");
		}));
		for(var i = 0; i < videoTrackIds.length; i++)
			selectedObjDelete(videoTrackIds[i]);
		
		var IdsOftrackObjs = $.makeArray($(".track-obj").map(function(){
		    return $(this).attr("id");
		}));
		for(var i = 0; i < IdsOftrackObjs.length; i++)
			selectedObjDelete(IdsOftrackObjs[i]);
	});
}
