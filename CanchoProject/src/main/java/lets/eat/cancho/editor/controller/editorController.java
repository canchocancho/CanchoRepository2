package lets.eat.cancho.editor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping(value="video")
@Controller
public class editorController {
	
	@RequestMapping(value="editor", method=RequestMethod.GET)
	public String editor(){
		return "videoEditor/v_editor";
	}
}
