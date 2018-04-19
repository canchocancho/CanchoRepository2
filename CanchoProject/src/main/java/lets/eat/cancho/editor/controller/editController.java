package lets.eat.cancho.editor.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lets.eat.cancho.editor.util.FileService;
import lets.eat.cancho.editor.util.ImageFileManager;
import lets.eat.cancho.editor.util.test;


/**
 * Handles requests for the application home page.
 */
@Controller
public class editController {
	
	int Cnt = 0;
	ArrayList<String> videoList = new ArrayList<String>();	//	video가 담길 리스트
	ArrayList<String> audioList = new ArrayList<String>();	//	audio가 담길 리스트
	ArrayList<String> imageList = new ArrayList<String>();	//	image가 담길 리스트
	ArrayList<String> nullList = new ArrayList<String>();	//	message가 담길 리스트
	HashMap<String, String> deleteMap = new HashMap<String, String>();
	
	/*사용자에 토모로그 폴더 생기게*/
	
	final String uploadPath = "C:\\tomolog\temp\\";	//파일 업로드 경로
	final String extractPath = "C:\\tomolog\\extract\\";	// 추출된 이미지 경로
	ImageFileManager fileManger = new ImageFileManager();
	
	@RequestMapping(value = "/editor", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	
	@ResponseBody
	@RequestMapping(value = "extract", method = RequestMethod.GET)
	public HashMap<String, Object> extract(){
		HashMap<String, Object> rtn  = new HashMap<>();
		String originPath = "tomolog\\";
		String videoPath = "C:\\tomolog";
		int count = test.findFileNum(videoPath) - 1;
		rtn.put("count", count);
		rtn.put("originPath", originPath);
		return rtn;
	}
	
	@ResponseBody
	@RequestMapping(value="fileupload", method = RequestMethod.POST)
	public ArrayList<String> fileupload(MultipartHttpServletRequest request, HttpServletResponse response, String selectedType) {
        System.out.println("ㅋㅋ 지움");
		Iterator<String> itr =  request.getFileNames();
        String fileType = request.getParameter("fileType");
        if(itr.hasNext()) {
            MultipartFile mpf = request.getFile(itr.next());
            try {
                System.out.println("file length : " + mpf.getBytes().length);
                System.out.println("file nameeeeeeeee : " + mpf.getOriginalFilename());       
        		if (!mpf.isEmpty()) {
        			String savedfile = FileService.saveFile(mpf, uploadPath);
        			
        			// 파일 종류 판별
        			
        			int fileLength = savedfile.length();
        			String ext;
        			int lastIndex = savedfile.lastIndexOf('.');
        			
        			String fileName = savedfile.substring(0, lastIndex);
        			String extName = savedfile.substring(lastIndex+1, fileLength);	//	확장자 구하기
	
        			// 페이지에 넘겨줄 파일경로가 담긴 리스트
        			switch(extName) {
        				
        			case "mp4": videoList.add(savedfile); break;
        			case "ogg": videoList.add(savedfile); break;
        			case "webm": videoList.add(savedfile); break;
        			case "mp3": audioList.add(savedfile); break;
        			case "jpg": imageList.add(savedfile); break;
        			case "jpeg": imageList.add(savedfile); break;
        			case "png": imageList.add(savedfile); break;
        			
        			}
        			
        			
        			

        			if(extName.equals("mp4") || extName.equals("ogg") || extName.equals("webm")) {
        				fileManger.extractVideo(fileName, fileName);
        			}

        			nullList.add("There is no!!!!");
        			
        			
        			if(videoList == null && imageList == null && audioList == null) {
        				return nullList;
        			}
        			
        			switch (fileType) {
        			
        			case "Video":
        					System.out.println("video");
        					return videoList;
        				
        			case "Image":
        					System.out.println("image");
        					return imageList;
        				
        			case "Audio": 
        					System.out.println("audio");
        					return audioList;
        			
        			}
        			
        			return nullList;
        			
        		}
            } catch (IOException e) {
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
            return nullList;
        } else {
            return nullList;
        }
        
    }
	
	@ResponseBody
	@RequestMapping(value = "getFileList", method = RequestMethod.POST)
	public ArrayList<String> getFileList(String selectedType) {
		
		System.out.println("hello im getFileList!!!!!!!!!!!!!!!!!!!!!");
		
		String type = selectedType;
		
		nullList.add(0, "no file");

		if(videoList == null && imageList == null && audioList == null) {
			return nullList;
		}
		
		switch (type) {
		
		case "Video":
			if(videoList != null) {
				return videoList;
			}
			else {
				return nullList;
			}
		case "Image":
			if(imageList != null) {
				return imageList;
			}
			else {
				return nullList;
			}
		case "Audio": 
			if(audioList != null) {
				return audioList;
			}
			else {
				return nullList;
			}
		}
		
		return nullList;
		
	}
	
	@RequestMapping(value = "download", method = RequestMethod.GET)
	public void fileDownload(HttpServletResponse response, String origin , String saved){
		try {
			response.setHeader("Content-Disposition", " attachment;filename="+ URLEncoder.encode(origin, "UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String fullPath = uploadPath + "/" + saved;
		//서버의 파일을 읽을 입력 스트림과 클라이언트에게 전달할 출력스트림
		FileInputStream filein = null;
		ServletOutputStream fileout = null;
		
		try {
			filein = new FileInputStream(fullPath);
			fileout = response.getOutputStream();
			
			//Spring의 파일 관련 유틸
			FileCopyUtils.copy(filein, fileout);
			
			filein.close();
			fileout.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "deleteIndiFile", method = RequestMethod.POST)
	public void deleteIndiFile(String indiFileName) {
		String delFileName = indiFileName;
		
		String fullpath = uploadPath + delFileName;
		
		
		String ext;
		int lastIndex = delFileName.lastIndexOf('.');
		int fileLength = delFileName.length();
		String extName = delFileName.substring(lastIndex+1, fileLength);
		String realName = delFileName.substring(0, lastIndex);
		
		String fullpathEx = extractPath + realName;
		System.out.println(fullpathEx);
		
		deleteMap.put("fullpath", fullpath);
		
		if(extName.equals("mp4") || extName.equals("ogg") || extName.equals("webm")) {
			deleteMap.put("fullpathEx", fullpathEx);
		}
		else {
			deleteMap.put("fullpathEx", "notVideo");
		}
		
		boolean del = FileService.deleteFile(deleteMap);
		
		if(del) {
			switch(extName) {
			
				case "mp4": videoList.remove(delFileName); break;
				case "ogg": videoList.remove(delFileName); break;
				case "webm": videoList.remove(delFileName); break;
				case "mp3": audioList.remove(delFileName); break;
				case "jpg": imageList.remove(delFileName); break;
				case "jpeg": imageList.remove(delFileName); break;
				case "png": imageList.remove(delFileName); break;
				
			}
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value = "deleteAllFiles", method = RequestMethod.GET)
	public void deleteAllFiles(String deleteMess) {
		
		String mess = deleteMess;
		String path = "C:\\tomolog\\";
		
		// 전체 파일 이름 담기(확장자명 포함임ㅎ)
		boolean result = FileService.deleteAllFiles(videoList, path);
		
		if (result) {
			for(String v : videoList) {
				videoList.remove(v);
			}
			for(String i : imageList) {
				imageList.remove(i);
			}
			for(String a : audioList) {
				audioList.remove(a);
			}
		}
	}	
}
