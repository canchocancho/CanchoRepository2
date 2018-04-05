$(".post").draggable({
		cursor:"move",
		stack:".post",
		opacity:0.8,
		containment:'parent'
	});

	$(".post").bind("dragstart",function(event, ui){
		$(this).addClass("color");	//bgi 체인지
	});
	$(".post").bind("dragstop", function(event, ui){
		$(this).removeClass("color")	//bgi 체인지
	});