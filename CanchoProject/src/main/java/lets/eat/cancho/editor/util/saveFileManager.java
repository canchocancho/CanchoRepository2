package lets.eat.cancho.editor.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import lets.eat.cancho.editor.vo.editorVO;

public class saveFileManager {
	//	[video] path선언
	static String originPath = "c:\\tomolog\\extract\\";
	static String newPath = "c:\\tomolog\\saved\\";
	static String savedPath = "c:\\tomolog\\maked\\";
	static String fileName;
	static String ext;
	
	//	frame선언
	static String startFrame;
	static String endFrame;
	
	//	numbering선언
	static int numbering;
	static int numberingA;	// audio numbering
	
	static String frame;
	
	//static ArrayList<String> timeList;
	
	
	//////////////////////////////////////	[audio]
	static String audioPath = "c:\\tomolog\\saved\\audio\\";
	static String startAudio;
	static String endAudio;
	static HashMap<String,String> calMap = new HashMap<String,String>();
	
	public static void numbering(String startFrame, String endFrame, String fileName) {

	     File path = new File(newPath);
	     if (!path.isDirectory()) {
	        path.mkdirs();
	     }
	     
        //   처음 넘버링을 위한 부분
        File savedFolder = new File(newPath);
        String[] fnameList = savedFolder.list();
          
        if(savedFolder.exists()) {
           numbering = fnameList.length;
        }
        else {
           numbering = 0;
        }
        
        //   0과 정수를 분리합니다. 시작시간 50분
        String startF ="";
        if (startFrame.equals("0")) {
           startF = "1";
        }else {
           startF = startFrame;
        }
        
        String endF = endFrame;
        int count = 0;
        
        //   시작 프레임
        String startZero = "";
        String startNums = "";
        int startNum = 0;
        
        //   끝나는~프레임~
        String endZero = "";
        String endNums = "";
        int endNum = 0;
     
        for(int i = 0; i < 9 - startF.length(); i++) {
           startZero += "0";
        }
        startNum = Integer.parseInt(startF);

        for (int i = 0; i < 9 - endF.length(); i++) {
           endZero += "0";
        }
        
        endNum = Integer.parseInt(endF);
       
        
        //    정수 자리수 
        int newSize = 0;
        int originSize = startF.length();
        for(int i = startNum; i <= endNum; i++) {
           numbering += 1;
           
           newSize = String.valueOf(i).length();
           if( newSize > originSize) {
              startZero = startZero.substring(0,startZero.length()-1);
              originSize = newSize;
           }
           
           frame = startZero + i;
           saving(fileName, frame, numbering);
           
        }
        

     }
  
  public static void saving(String fileName, String frame, int numbering) {
     
     File path = new File(newPath);
     if (!path.isDirectory()) {
        path.mkdirs();
     }
     
     File source = new File(originPath + fileName + "\\" + frame + ".jpg");
       File dest = new File(newPath + numbering + ".jpg");

       long start = System.nanoTime();
       savingFile(source, dest);
     
  }
	
	public static void savingFile(File source, File dest){
	    FileChannel sourceChannel = null;
	    FileChannel destChannel = null;
	    try {
	        sourceChannel = new FileInputStream(source).getChannel();
	        destChannel = new FileOutputStream(dest).getChannel();
	        destChannel.transferFrom(sourceChannel, 0, sourceChannel.size());
	        sourceChannel.close();
	        destChannel.close();
	    }catch(Exception e){    	
	    }
	}
	
	public static void makeVideo() {
		String command = "ffmpeg -r 30 -i ";
		command += newPath + "%0d.jpg -c:v libx264 -pix_fmt yuv420p -crf 23 -r 30  -y saveVideo.mp4";
		
		try {
			executeCommandV(command);
		} catch (IOException | InterruptedException e) {
			e.printStackTrace();
		}
		
	}
	
	private static String executeCommandV(String command) throws IOException, InterruptedException {
		
		File goPath = new File(savedPath);
		if (!goPath.isDirectory()) {
			goPath.mkdirs();
		}
		
	    int exitCode = 0;
	    String result = "";
		
	    Process process;
	    ProcessBuilder builder = new ProcessBuilder(command.replaceAll("[ ]+", " ").split(" "));
	    
	    builder.inheritIO();
	    builder.directory(goPath);
	    process = builder.start();
	    exitCode = process.waitFor();
	    
	    if (exitCode == 0) {
	    	makeAudio();
		}else{
		}
	    
	    return getStringFromInputStream(process.getInputStream());
	}
	
private static String executeCommand(String command) throws IOException, InterruptedException {
		
		File goPath = new File(savedPath);
		if (!goPath.isDirectory()) {
			goPath.mkdirs();
		}
		
	    int exitCode = 0;
	    String result = "";
		
	    Process process;
	    ProcessBuilder builder = new ProcessBuilder(command.replaceAll("[ ]+", " ").split(" "));
	    
	    builder.inheritIO();
	    builder.directory(goPath);
	    process = builder.start();
	    exitCode = process.waitFor();

	    
	    return getStringFromInputStream(process.getInputStream());
	}
	
	
	private static String executeCommandA(String command) throws IOException, InterruptedException {
		
		File goPath = new File(savedPath);
		if (!goPath.isDirectory()) {
			goPath.mkdirs();
		}
		
	    int exitCode = 0;
	    String result = "";
	    
	  
		/*System.out.println(command);*/
		
	    Process process;
	    ProcessBuilder builder = new ProcessBuilder(command.replaceAll("[ ]+", " ").split(" "));
	    
	    builder.inheritIO();
	    builder.directory(goPath);
	    process = builder.start();
	    exitCode = process.waitFor();
	    
	    if (exitCode == 0) {
		}  
	    return getStringFromInputStream(process.getInputStream());
	}
	
	private static String executeCommandI(String command) throws IOException, InterruptedException {
		
		File goPath = new File(savedPath);
		if (!goPath.isDirectory()) {
			goPath.mkdirs();
		}
		
	    int exitCode = 0;
	    String result = "";
	    
		
	    Process process;
	    ProcessBuilder builder = new ProcessBuilder(command.replaceAll("[ ]+", " ").split(" "));
	    
	    builder.inheritIO();
	    builder.directory(goPath);
	    process = builder.start();
	    exitCode = process.waitFor();
	    if (exitCode == 0) {
			System.out.println("이미지 삽입 완료");
		}
	    
	    return getStringFromInputStream(process.getInputStream());
	}
	
private static String executeCommandZ(String command) throws IOException, InterruptedException {
		
		File goPath = new File(savedPath);
		if (!goPath.isDirectory()) {
			goPath.mkdirs();
		}
		
	    int exitCode = 0;
	    String result = "";
	    
		
	    Process process;
	    ProcessBuilder builder = new ProcessBuilder(command.replaceAll("[ ]+", " ").split(" "));
	    
	    builder.inheritIO();
	    builder.directory(goPath);
	    process = builder.start();
	    exitCode = process.waitFor();
	    if (exitCode == 0) {
			
		}
	    
	    return getStringFromInputStream(process.getInputStream());
	}
	
	private static String getStringFromInputStream(InputStream is) {

    BufferedReader br = null;
    StringBuilder sb = new StringBuilder();

    String line;
    try {

        br = new BufferedReader(new InputStreamReader(is));
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }

    } catch (IOException e) {
        e.printStackTrace();
    } finally {
        if (br != null) {
            try {
                br.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    return sb.toString();
	}
	
	 public static void calAudio(int startNum, int endNum, String fileName, String filePath) {
		 System.out.println("startF:  " + startNum + "   endF:  " + endNum);
		   
	      File savedFolder = new File(audioPath);
	      String[] fnameList = savedFolder.list();
	      
	      if(savedFolder.exists()) {
	      numberingA = fnameList.length;
	      }
	      else {
	      numberingA = 0;
	      }
	      numberingA += 1;
	      
	      double startTime = startNum / 30;
	      double endTime = (endNum / 30)-startTime;
	      
	      //   start
	      String startAu = "";
	      double s_third = startTime;
	      int s_min_1st = 0; 
	      int s_min_2nd = 0; 
	      
	      //   end
	      String endAu = "";
	      double e_third = endTime; 
	      int e_min_1st = 0;  
	      int e_min_2nd = 0;  
	      
	      
	      
	      File path = new File(audioPath);
	      if (!path.isDirectory()) {
	         path.mkdirs();
	      }
	      
	      if(startTime > 60) {
	         s_third = startTime % 60;
	         s_min_2nd = (int)startTime / 60;
	      if(s_min_2nd > 9) {
	         s_min_2nd = 0;
	         s_min_1st = s_min_2nd / 10;
	         }
	      }
	      
	      //startTime
	      
	      if(endTime > 60) {
	         e_third = endTime % 60;
	         e_min_2nd = (int)endTime / 60;
	      if(e_min_2nd > 9) {
	         e_min_2nd = 0;
	         e_min_1st = e_min_2nd / 10;
	         }
	      }
	      
	      startAu = "00:" + s_min_1st + s_min_2nd + ":" + s_third;
	      endAu = "00:" + e_min_1st + e_min_2nd + ":" + e_third;
	      
	      if(s_third < 10) {
	         startAu = "00:" + s_min_1st + s_min_2nd + ":0" + s_third;
	      }
	      
	      if(e_third < 10) {
	         endAu = "00:" + e_min_1st + e_min_2nd + ":0" + e_third;
	      }
	      
	      
	      
	      String logLoot = "C:/tomolog/saved/";
	      String fileNm = "audio.txt";
	      
	      try{
	    	  File dir = new File(logLoot);
	    	  //디렉토리가 없으면 생성
	    	  if(!dir.isDirectory()){
	    		  dir.mkdirs();
	    	  }
	      
	      //파일에 내용 쓰기
	    	  FileWriter fw = new FileWriter(new File(logLoot+fileNm), true);
	    	  fw.write("file '" + audioPath + "audio" + numberingA + ".mp3'");  
	    	  BufferedWriter out = new BufferedWriter(fw);
	    	  out.newLine();
	    	  fw.flush();
	    	  out.close();
	    	  fw.close();
	      }catch (IOException e){
	    	  
	      }
	      String command = "ffmpeg -i " + originPath + fileName + "\\audio.mp3 -ss ";
	      command += startAu + " -t " + endAu + " " + audioPath + "audio" + numberingA + ".mp3";
	      System.out.println("start Time: " + startAu + "    end Time:  " + endAu);
	      
	      try {
	      executeCommand(command);
	      } catch (IOException e) {
	      // TODO Auto-generated catch block
	      e.printStackTrace();
	      } catch (InterruptedException e) {
	      // TODO Auto-generated catch block
	      e.printStackTrace();
	      }
	 }
	 public static void makeAudio() {
	      String command = "ffmpeg -r 30 -i " + savedPath + "saveVideo.mp4 -f concat -safe 0 -i c:\\tomolog\\saved\\audio.txt -c:a aac -pix_fmt yuv420p -crf 23 -r 30 -shortest -y A.mp4";
	      try {
				executeCommandA(command);
			} catch (IOException | InterruptedException e) {
				e.printStackTrace();
			}
	   }
	 
	 public static void makeImage(String imgPath, String imgFrame) {
		 
		 //int i = ;
		 String command ="";
		  File pp = new File(savedPath);
		  String[] ppList = pp.list();
		  int ppListn = ppList.length;
		  
		  int fNum = ppListn;
		  
	      int endFrame = (int)(Double.parseDouble(imgFrame) + 4);
	      
	      if(fNum == 2) {
	    	  command= "ffmpeg -i A.mp4 -i c:\\" + imgPath + " -filter_complex \"[0:v][1:v] overlay=0:0:enable='between(t,"+imgFrame+","+ endFrame +")'\" -pix_fmt yuv420p -c:a copy c:/tomolog/maked/"+ ppListn +".mp4";
	      }
	      else {
	    	  command = "ffmpeg -i "+ (ppListn - 1) + ".mp4 -i c:\\" + imgPath;
	    	  command += " -filter_complex \"[0:v][1:v] overlay=0:0:enable='between(t,"+imgFrame+","+ endFrame +")'\" -pix_fmt yuv420p -c:a copy c:/tomolog/maked/"+ ppListn +".mp4";
	      }
	      try {
				executeCommandI(command);
			} catch (IOException | InterruptedException e) {
				e.printStackTrace();
			}
	   }
	 public static void calMsTime(String url , String start) {
		  File ap = new File(savedPath);
		  String[] apList = ap.list();
		  int apListn = apList.length;  
	      double sF = (Double.parseDouble(start)) * 1000;
	      String command = "";
	      String nam = "\"";
	      if (apListn <= 2) {
	    	  command = "ffmpeg -i " + savedPath +"A.mp4 -i c:\\" + url + " -filter_complex " + nam + "[1]adelay=" + sF + "|" + sF + "[aud];[0][aud]amix" + nam + " -c:v copy c:\\tomolog\\maked\\" + (apListn) + ".mp4";
	      }else{
	      command = "ffmpeg -i " + savedPath + (apListn-1) + ".mp4 -i c:\\" + url + " -filter_complex " + nam + "[1]adelay=" + sF + "|" + sF + "[aud];[0][aud]amix" + nam + " -c:v copy c:\\tomolog\\maked\\" + apListn + ".mp4";
	      }
	      try {
	    	  executeCommandZ(command);
			} catch (IOException | InterruptedException e) {
				e.printStackTrace();
			}
	   }
	 public static void fisaving() {
		  String ori = "";
		  File pp = new File(savedPath);
		  String[] ppList = pp.list();
		  int ppListn = ppList.length;
		  long time = new Date().getTime();
	      String sysName = System.getProperty("user.name");
	      String downPath = "c:\\users\\" + sysName + "\\downloads\\tomolog"+ time +".mp4";
	      
	    if (ppListn == 2) {
	    	ori = "c:\\tomolog\\maked\\A.mp4";
		}else{
			ori = "c:\\tomolog\\maked\\"+ (ppListn -1)+".mp4";
		}
	        
	       File source = new File(ori);
	       File dest = new File(downPath);

	       long start = System.nanoTime();
	       fisavingFile(source, dest);
	        
	     }
	      
	   public static void fisavingFile(File source, File dest){
		   
		  
	      
	        FileChannel sourceChannel = null;
	        FileChannel destChannel = null;
	        
	        try {
	            sourceChannel = new FileInputStream(source).getChannel();
	            destChannel = new FileOutputStream(dest).getChannel();
	            destChannel.transferFrom(sourceChannel, 0, sourceChannel.size());
	            sourceChannel.close();
	            destChannel.close();
	        }catch(Exception e){       
	        }
	        
	   }    
}

