package lets.eat.cancho.editor.util;

import java.awt.List;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.springframework.web.multipart.MultipartFile;

/**
 * 파일 관련 유틸
 * 업로드한 파일의 저장 & 서버에 저장된 파일 삭제 등의 기능 제공
 */
public class FileService {

	/**
	 * 업로드 된 파일을 지정된 경로에 저장하고, 저장된 파일명을 리턴
	 * @param mfile 업로드된 파일
	 * @param path 저장할 경로
	 * @return 저장된 파일명
	 */
	static ArrayList<String> nameList;
	static HashMap<Object, Object> nameNumber = new HashMap<>();
	
	static int count;
	
	public static String saveFile(MultipartFile mfile, String uploadPath) {
		
		count = 1;
		nameList = new ArrayList<>();
		
		//업로드된 파일이 없거나 크기가 0이면 저장하지 않고 null을 리턴
		if (mfile == null || mfile.isEmpty() || mfile.getSize() == 0) {
			return null;
		}
		
		//저장 폴더가 없으면 생성
		File path = new File(uploadPath);
		if (!path.isDirectory()) {
			path.mkdirs();
		}
		
		//원본 파일명
		String originalFilename = mfile.getOriginalFilename();
		
		//저장할 파일명을 오늘 날짜의 년월일로 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		/*String savedFilename = sdf.format(new Date());*/
		
		
		//원본 파일의 확장자
		String ext;
		int lastIndex = originalFilename.lastIndexOf('.');
		//String nama = originalFilename.substring(lastIndex, arg1)
		//확장자가 없는 경우
		if (lastIndex == -1) {
			ext = "";
		}
		//확장자가 있는 경우
		else {
			ext = "." + originalFilename.substring(lastIndex + 1);
		}

		//저장할 전체 경로를 포함한 File 객체
		File serverFile = null;
		
		//저장할 파일명은 원본 이름으로 생성. 확장자 전 까지로 저장.
		String savedFilename = originalFilename.substring(0, lastIndex);
		
		while (true) {
			
			serverFile = new File(uploadPath + "/" + savedFilename + ext);
			
			if (!serverFile.isFile()) break;
			
			savedFilename = savedFilename + new Date().getTime();	
			//savedFilename = savedFilename + "(" + nameNumber.get(savedFilename) + ")"
			
		}
		
		
		
		//파일 저장
		try {
			mfile.transferTo(serverFile);
			
		} catch (Exception e) {
			savedFilename = null;
			e.printStackTrace();
		}
		
		return savedFilename + ext;
	}
	
	/**
	 * 서버에 저장된 파일의 전체 경로를 전달받아, 해당 파일을 삭제
	 * @param fullpath 삭제할 파일의 경로
	 * @return 삭제 여부
	 */
	public static boolean deleteFile(HashMap<String, String>delMap) {
	      //파일 삭제 여부를 리턴할 변수
	      boolean result = false;
	      
	      System.out.println("삭제부분입니다???");
	      System.out.println(delMap.get("fullpath"));
	      
	      System.out.println("fullpath : " + delMap.get("fullpath"));
	      System.out.println("fullpathEx : " + delMap.get("fullpathEx"));
	      
	      String fullpath = (String)delMap.get("fullpath");
	      String fullpathEx = (String)delMap.get("fullpathEx");
	      
	      //전달된 전체 경로로 File객체 생성
	      File delFile = new File(fullpath);
	      System.out.println(delFile.exists());
	      System.out.println(delFile.isFile());
	      
	      
	      
	      //해당 파일이 존재하면 삭제
	      if (delFile.isFile()) {
	         System.out.println("삭제하러 들어왔음다");
	         try {
	            
	         delFile.delete();
	         
	         if(!(fullpathEx.equals("notVideo")))   {
	            
	            System.out.println("비디오입니다");
	            
	            File delDirec = new File(fullpathEx);
	            
	             String[] fnameList = delDirec.list();
	             int fCnt = fnameList.length;
	             String childPath = "";
	             
	             for(int i = 0; i < fCnt; i++) {
	               childPath = fullpathEx + "/" +fnameList[i];
	               File f = new File(childPath);
	               if( ! f.isDirectory()) {
	                 f.delete();   //파일이면 바로 삭제
	               }
	             }
	             
	             File f = new File(fullpathEx);
	             f.delete();   //폴더는 맨 나중에 삭제
	            
	         }
	         result = true;
	         
	         }catch (Exception e) {
	            e.printStackTrace();
	         }
	         
	      }
	      
	      return result;
	   }
	
	// 전체 파일 삭제
	public static boolean deleteAllFiles(ArrayList<String>list, String path) {
		boolean result = false;
		
		String temppath = path + "\\temp\\";
		String extractpath = path + "\\extract\\";
		
		// temp폴더 밑의 파일들을 삭제(오직 파일만 존재)
		File tempFile = new File(temppath);
		
		String[] fnameList = tempFile.list();
	    int fCnt = fnameList.length;
	    String childPath = "";
	    
	    for(int i = 0; i < fCnt; i++) {
	      childPath = tempFile + "/" +fnameList[i];
	      File f = new File(childPath);
	      if( ! f.isDirectory()) {
	        f.delete();   //파일이면 바로 삭제
	      }
	      /*else {
	        deleteFolder(childPath);
	      }*/
	    }
	    
	    if(list != null) {
	    	deleteExt(extractpath, list);
	    }
	    
		
		return result;
	}
	
	public static void deleteExt(String extractpath, ArrayList<String>list) {
		
		String fullpathEx = "";
		int lastIndex = 0;
		String realName = "";
		
		//String fileName = savedfile.substring(0, lastIndex);
		//String extName = savedfile.substring(lastIndex+1, fileLength);	//	확장자 구하기
		
		for (int i = 0; i < list.size(); i++) {
				
			lastIndex = list.get(i).lastIndexOf('.');
			realName = list.get(i).substring(0, lastIndex);
			
			fullpathEx = extractpath + realName;
			File delDirec = new File(fullpathEx);
			
		    String[] fnameList = delDirec.list();
		    int fCnt = fnameList.length;
		    String childPath = "";
		    
		    for(int j = 0; j < fCnt; j++) {
		      childPath = fullpathEx + "/" +fnameList[j];
		      File f = new File(childPath);
		      if( ! f.isDirectory()) {
		        f.delete();   //파일이면 바로 삭제
		      }
		      /*else {
		        deleteFolder(childPath);
		      }*/
		    }
		    
		    File f = new File(fullpathEx);
		    f.delete();   //폴더는 맨 나중에 삭제
		    
			}
	
	    
	}
	public static boolean deleteSaved() {
        boolean result = false;
        
        
        String savedPath = "c:\\tomolog\\saved\\";
        String audioPath = savedPath + "audio\\";
        // temp폴더 밑의 파일들을 삭제(오직 파일만 존재)
        
        File audiFile = new File(audioPath);
        File tempFile = new File(savedPath);
        
        String[] anameList = audiFile.list();
        int aCnt = anameList.length;
        String ccPath = "";
        
        String[] fnameList = tempFile.list();
         int fCnt = fnameList.length;
         String childPath = "";
         
         for(int j = 0; j < aCnt; j++) {
            ccPath = audiFile + "/" + anameList[j];
            File a = new File(ccPath);
            if(! a.isDirectory()) {
               a.delete();
            }
         }
         
         audiFile.delete();
         
         for(int i = 0; i < fCnt; i++) {
           childPath = tempFile + "/" +fnameList[i];
           
           File f = new File(childPath);
           if( ! f.isDirectory()) {
             f.delete();   //파일이면 바로 삭제
           }
           else {
              
           }
           
           }

         File f = new File(savedPath);
         f.delete();   //폴더는 맨 나중에 삭제
        
        return result;
     }
	
	public static void deleteMaked() {
	      boolean result = false;
	      
	      String makedPath = "c:\\tomolog\\maked\\";
	      
	      File makedFile = new File(makedPath);
	      
	      String[] mnameList = makedFile.list();
	       int fCnt = mnameList.length;
	       String childPath = "";
	       
	       for(int i = 0; i < fCnt; i++) {
	          System.out.println(mnameList[i]);
	         childPath = makedFile + "/" +mnameList[i];
	         File f = new File(childPath);
	         if( ! f.isDirectory()) {
	           f.delete();
	         }
	       }
	      
	       File mf = new File(makedPath);
	        mf.delete();   
	   }
	
	
}
