var order = 'odd';
var vorder = 3;
var aorder = 3;



function delIndiFile(delFileName) {
	var indiFileName = delFileName;
	alert(indiFileName);
	
	$.ajax({
		type:"POST"
		,url: "deleteIndiFile"
		,data: {
			indiFileName : indiFileName
		}
		,success: function() {
			readFileList();
		}
		,error: function(e) {
			console.log(e);
		}
		
	}); 
}

function delAll() {
	var mess = "delAll";
	$.ajax({
		type:"GET"
		,url: "deleteAllFiles"
		,data: {
			deleteMess : mess
		}
		,success: function() {
			readFileList();
		}
		,error: function(e) {
			console.log(e);
		}
	});
	
}

$(function(){
	
	$("#imgBtn").on("click",function(){
		
		var selectedType = $('#selectedFile').val();
		alert(selectedType);
		
		var formData = new FormData();
		formData.append("file",$("#upload")[0].files[0]);
		formData.append("fileType", selectedType);
		
		$.ajax({
			type:"POST",						
			url:"fileupload",				
			data: formData,
			processData: false,
		    contentType: false,
			dataType:"json",				
			success:function(data){	
				console.log(data);
				readFileList();
			},
			error: function(e){			
				console.log(e);
			}
		});
	});
	
	$('#selectedFile').on('change', function() {
		var selectedType = $('#selectedFile').val();
		alert(selectedType);
		readFileList();

	});
});


function readFileList() {
	var selectedType = $('#selectedFile').val();
	$.ajax({
		type:"POST"
		,url: "getFileList"
		,data: {
			selectedType : selectedType
			}
		,datatype: "json"
		,success: function(data) {
				var str = "";
				for(var li in data) {
					str += "<div>" + data[li] + "   <button class=\"IndiFile\" filen=\"" + data[li] + "\">Delete</button></div>"
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

		}	/*	success end	*/
		,error: function(e) {
			console.log(e);
		}
	});
}

function addTrackEventHandlerRegister(){
	$('#addImgTrack').on('dblclick', function(){
		var html = $('#all-track-container').html();
		
		var cls = order + '-track-container';
		var cls2 = 'track-' +  order;
		if(order == 'odd') order='even';
		else if(order == 'even') order='odd';
		
		var divId = 'video-' + vorder + '-cont';
		var trackId = 'video-' + vorder;
		vorder++;

		html +=	'<div>';
		html +=		'<div  class="' + cls + '" id="' + divId + '">';
		html +=			'<span class="track-name">';
		html +=				'<i class="fa fa-picture-o" aria-hidden="true"></i>';
		html +=			'</span>';
		html +=			'<div class="' + cls2 + ' other-track" id="' + trackId + '">';
		html +=			'</div>';
		html +=		'</div>';
		html +=	'</div>';
		
		$('#all-track-container').html(html);
		tracksDuration[trackId] = 0;
		otherObjNum[trackId] = 0;
		
		add_track(trackId);
		video0TrackEventRegister();
		trackDragAndDropEventHander();
		trackObjEventRegister();
		
	    $( ".draggable" ).draggable({
	        stop: function() {
	        	addUndoArr(mm_player.mash)
	        	updateLocationObj($(this).attr('id'), $(this).attr('trackId'));
	        	setMash()
	        }
	     });
		
		
	    $( "#video-track" ).sortable({
	        revert: true,
	        start: function(event, ui) {
	            //alert("start");
	        },
	        change: function(event, ui) {
	           // alert("change");
	        },
	        update: function(event, ui) {
	        	var idsInOrder = $("#video-track").sortable("toArray");
	        	//alert(idsInOrder);
	        	addUndoArr(mm_player.mash)
	        	reorderingVideo0Clips(idsInOrder);
	        	setMash()
	        }
	    });

	});
	$('#addAudioTrack').on('dblclick', function(){
		var html = $('#all-track-container').html();
		
		var cls = order + '-track-container';
		var cls2 = 'track-' +  order;
		if(order == 'odd') order='even';
		else if(order == 'even') order='odd';
		
		var divId = 'audio-' + aorder + '-cont';
		var trackId = 'audio-' + aorder;
		aorder++;

		html +=	'<div>';
		html +=		'<div  class="' + cls + '" id="' + divId + '">';
		html +=			'<span class="track-name">';
		html +=				'<i class="fa fa-music" aria-hidden="true"></i>';
		html +=			'</span>';
		html +=			'<div class="' + cls2 + ' other-track" id="' + trackId + '">';
		html +=			'</div>';
		html +=		'</div>';
		html +=	'</div>';
		
		$('#all-track-container').html(html);
		tracksDuration[trackId] = 0;
		otherObjNum[trackId] = 0;
		
		add_track(trackId);
		
		//밑에 등록해야할 이벤트들
		video0TrackEventRegister();
		trackDragAndDropEventHander();
		trackObjEventRegister();
	    $( ".draggable" ).draggable({
	        stop: function() {
	        	updateLocationObj($(this).attr('id'), $(this).attr('trackId'));
	        }
	     });
	    $( ".other-obj" ).draggable({ axis: "x", containment: '#' + trackId, scroll: false });
	    
	    $( "#video-track" ).sortable({
	        revert: true,
	        start: function(event, ui) {
	            //alert("start");
	        },
	        change: function(event, ui) {
	           // alert("change");
	        },
	        update: function(event, ui) {
	        	var idsInOrder = $("#video-track").sortable("toArray");
	        	//alert(idsInOrder);
	        	addUndoArr(mm_player.mash)
	        	reorderingVideo0Clips(idsInOrder);
	        	setMash()
	        }
	    });
	});	
}

