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

