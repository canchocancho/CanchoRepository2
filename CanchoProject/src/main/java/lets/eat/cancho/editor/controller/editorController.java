package lets.eat.cancho.editor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class editorController {
	
	@RequestMapping(value="videoEditor", method=RequestMethod.GET)
	public String editor(){
		return "v_editor";
	}
}
