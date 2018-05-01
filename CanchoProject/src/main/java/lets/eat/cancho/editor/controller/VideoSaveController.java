package lets.eat.cancho.editor.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import lets.eat.cancho.common.util.FileService;
import lets.eat.cancho.user.controller.MyPageController;

@Controller
public class VideoSaveController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyPageController.class);
	
	final String uploadPath = "/videofile";
	
	@RequestMapping(value="saveVideo", method=RequestMethod.POST)
	public String saveVideo(HttpSession session, Model model, MultipartFile upload){
		logger.info("비디오 저장");
		String id = (String)session.getAttribute("loginId");
		
		vPost post = new vPost();
		post.setUser_id(id);
		
        if(!upload.isEmpty()){
            //첨부파일이 있는 경우
            //Post 객체에 originalFileName과 savedfileName을 저장
            String savedfile = FileService.saveFile(upload, uploadPath); //저장된 파일명
            post.setSavedfile(savedfile);
            post.setOriginalfile(upload.getOriginalFilename());
         }
        
        int result = dao.writePost(post);
        
        if(result != 1){
           //등록실패
           model.addAttribute("errorMsg", "오류가 발생했습니다.");
           logger.info("포스팅 실패");
           
           return "post/postForm";
        }
        
        logger.info("포스팅 종료");
        
        ArrayList<Post> postList = dao.postList(loginId);
        session.setAttribute("postList", postList);

        return "redirect:/";
		
		
		return "";
	}
}
